CREATE FUNCTION board()
RETURNS TABLE
(j JSON) AS
$BODY$
BEGIN
    RETURN QUERY
SELECT row_to_json(r, true)
FROM (
    SELECT
        stages.stageid,   
        stages.stagename, 
        json_agg(deals_row) AS deals
    FROM stages
    LEFT JOIN (
        SELECT  
            deals.dealid,       
            deals.dealname,
            deals.stageid,
            deals.dealprice,  
            json_agg(manager_row) AS user,
            json_agg(client_row) AS client
        FROM deals
        INNER JOIN (
      			SELECT
              userid,
      				username,
      				userphoto
      			FROM
      				users
      		) AS manager_row(id,name, avatar) ON (manager_row.id = deals.userid)
        INNER JOIN(
          SELECT
            clientid,
            clientcompanyname,
            clientname,
            clientphone,
            clientemail
          FROM clients
        ) as client_row(id,company,name,phone,email) ON (client_row.id = deals.dealid )
              GROUP BY deals.dealid 
    ) deals_row(id, name,stageid, price, manager, client) ON (deals_row.stageid = stages.stageid)
        -- WHERE stage.pipelineid = 1
    GROUP BY stages.stageid
) r(id, name, deals);
END;
$BODY$ LANGUAGE plpgsql;

-- Users -- UsersCompanies -- Pipelines -- Stages -- Deals -- Users asManagers

CREATE FUNCTION dashboard()
RETURNS TABLE
(j JSON) AS
$BODY$
BEGIN
    RETURN QUERY
    SELECT json_agg(f)->0 FROM(
        SELECT
            (SELECT json_agg(a)->0 FROM (
              SELECT SUM(dealprice) as sumprice, COUNT(dealprice) as countdeals
              FROM deals 
              GROUP BY stageid
					    HAVING stageid=1
            ) as a --END FROM
            ) as firstcontact, -- END SELECT,

            (SELECT json_agg(a)->0 FROM (
              SELECT SUM(dealprice) as sumprice, COUNT(dealprice) as countdeals
              FROM deals 
              GROUP BY stageid
					    HAVING stageid=2
            ) as a --END FROM
            ) as meeting, -- END SELECT,

            (SELECT json_agg(a)->0 FROM (
              SELECT SUM(dealprice) as sumprice, COUNT(dealprice) as countdeals
              FROM deals 
              GROUP BY stageid
					    HAVING stageid=3
            ) as a --END FROM
            ) as sentco, -- END SELECT,

            (SELECT json_agg(a)->0 FROM (
              SELECT SUM(dealprice) as sumprice, COUNT(dealprice) as countdeals
              FROM deals 
              GROUP BY stageid
					    HAVING stageid=4
            ) as a --END FROM
            ) as sentcontract, -- END SELECT,

            (SELECT json_agg(a)->0 FROM (
              SELECT SUM(dealprice) as sumprice, COUNT(dealprice) as countdeals
              FROM deals 
              GROUP BY stageid
					    HAVING stageid=5
            ) as a --END FROM
            ) as inprocess, -- END SELECT,

            (SELECT json_agg(a)->0 FROM (
              SELECT SUM(dealprice) as sumprice, COUNT(dealprice) as countdeals
              FROM deals 
              GROUP BY stageid
					    HAVING stageid=6
            ) as a --END FROM
            ) as success, -- END SELECT,

            (
              SELECT COUNT(taskname) as taskscount
              FROM tasks 
              WHERE taskdate < CURRENT_TIMESTAMP
              GROUP BY userid
					    HAVING userid=1 
            
            ) as overdue, -- END SELECT,

            ( SELECT COUNT(taskname) as taskscount
              FROM tasks
              WHERE taskdate > CURRENT_TIMESTAMP AND taskstatus = false 
              GROUP BY userid
					    HAVING userid=1 
              
            ) as todo, -- END SELECT,

            (SELECT COUNT(taskname) as taskscount
              FROM tasks
              WHERE taskdate > CURRENT_TIMESTAMP AND taskstatus = true 
              GROUP BY userid
					    HAVING userid=1 
              
            ) as done, -- END SELECT,

            (SELECT Count(dealstasks.dealid) 
              FROM (
                SELECT 
                  deals.dealid as dealid,
                  taskid 
                FROM deals LEFT JOIN tasks ON deals.dealid=tasks.dealid
              ) as dealstasks 
              WHERE taskid IS NULL
            ) as missingtasks,

            (SELECT json_agg(a)->0 FROM (
              SELECT
                (SELECT SUM(dealprice) as sumprice FROM deals ) as income,
                (SELECT goalvalue FROM goals ORDER BY goaldate LIMIT 1) as goal
              ) as a 
            ) as incomechart
        ) as f;
END;
$BODY$ LANGUAGE plpgsql;
