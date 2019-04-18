-- Deal Insert
CREATE FUNCTION deal_insert_log() RETURNS trigger AS $deal_insert_log$
BEGIN
  INSERT INTO "actionlog"("userid","objecttype","objectid","actiontype") VALUES (NEW.userid,'Сделка',NEW.dealid,'Добавлена сделка');
  RETURN NEW;
END;
$deal_insert_log$ LANGUAGE plpgsql;
-- Deal Update
CREATE FUNCTION deal_update_log() RETURNS trigger AS $deal_update_log$
BEGIN
  INSERT INTO "actionlog"("userid","objecttype","objectid","actiontype") VALUES (NEW.userid,'Сделка',NEW.dealid,'Добавлена обновлена');
  RETURN NEW;
END;
$deal_update_log$ LANGUAGE plpgsql;
-- Deal Delete
CREATE FUNCTION deal_delete_log() RETURNS trigger AS $deal_delete_log$
BEGIN
  INSERT INTO "actionlog"("userid","objecttype","objectid","actiontype") VALUES (OLD.userid,'Сделка',OLD.dealid,'Добавлена удалена');
  RETURN OLD;
END;
$deal_delete_log$ LANGUAGE plpgsql;
-- Client Insert
CREATE FUNCTION client_insert_log() RETURNS trigger AS $client_insert_log$
BEGIN
  INSERT INTO "actionlog"("userid","objecttype","objectid","actiontype") VALUES (NEW.userscompaniesid,'Клиент',NEW.clientid,'Клиент добавлен');
  RETURN NEW;
END;
$client_insert_log$ LANGUAGE plpgsql;
-- Client Update
CREATE FUNCTION client_update_log() RETURNS trigger AS $client_update_log$
BEGIN
  INSERT INTO "actionlog"("userid","objecttype","objectid","actiontype") VALUES (NEW.userscompaniesid,'Клиент',NEW.clientid,'Клиент обновлен');
  RETURN NEW;
END;
$client_update_log$ LANGUAGE plpgsql;
-- Client Delete
CREATE FUNCTION client_delete_log() RETURNS trigger AS $client_delete_log$
BEGIN
  INSERT INTO "actionlog"("userid","objecttype","objectid","actiontype") VALUES (OLD.userscompaniesid,'Клиент',OLD.clientid,'Клиент удален');
  RETURN OLD;
END;
$client_delete_log$ LANGUAGE plpgsql;
-- Task Insert
CREATE FUNCTION task_insert_log() RETURNS trigger AS $task_insert_log$
BEGIN
  INSERT INTO "actionlog"("userid","objecttype","objectid","actiontype") VALUES (NEW.userid,'Задача',NEW.taskid,'Задача добавлена');
  RETURN NEW;
END;
$task_insert_log$ LANGUAGE plpgsql;
-- Task Update
CREATE FUNCTION task_update_log() RETURNS trigger AS $task_update_log$
BEGIN
  INSERT INTO "actionlog"("userid","objecttype","objectid","actiontype") VALUES (NEW.userid,'Задача',NEW.taskid,'Задача обновлена');
  RETURN NEW;
END;
$task_update_log$ LANGUAGE plpgsql;
-- Task Delete
CREATE FUNCTION task_delete_log() RETURNS trigger AS $task_delete_log$
BEGIN
  INSERT INTO "actionlog"("userid","objecttype","objectid","actiontype") VALUES (OLD.userid,'Задача',OLD.taskid,'Задача удалена');
  RETURN OLD;
END;
$task_delete_log$ LANGUAGE plpgsql;

CREATE TRIGGER dealinsert
AFTER INSERT ON deals
FOR EACH ROW
EXECUTE PROCEDURE deal_insert_log();

CREATE TRIGGER dealupdate
AFTER UPDATE ON deals
FOR EACH ROW
EXECUTE PROCEDURE deal_update_log();

CREATE TRIGGER dealdelete
AFTER DELETE ON deals
FOR EACH ROW
EXECUTE PROCEDURE client_delete_log();

CREATE TRIGGER clientinsert
AFTER INSERT ON clients
FOR EACH ROW
EXECUTE PROCEDURE client_insert_log();

CREATE TRIGGER clientupdate
AFTER UPDATE ON clients
FOR EACH ROW
EXECUTE PROCEDURE client_update_log();

CREATE TRIGGER clientdelete
AFTER DELETE ON clients
FOR EACH ROW
EXECUTE PROCEDURE client_delete_log();

CREATE TRIGGER taskinsert
AFTER INSERT ON tasks
FOR EACH ROW
EXECUTE PROCEDURE task_insert_log();

CREATE TRIGGER taskupdate
AFTER UPDATE ON tasks
FOR EACH ROW
EXECUTE PROCEDURE task_update_log();

CREATE TRIGGER taskdelete
AFTER DELETE ON tasks
FOR EACH ROW
EXECUTE PROCEDURE task_delete_log();
