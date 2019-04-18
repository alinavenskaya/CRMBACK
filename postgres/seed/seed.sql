
INSERT INTO "userscompanies"("userscompanyname") VALUES ('avenova');

INSERT INTO "users"("userscompaniesid","username","userphone","useremail","userpassword","usertype", "useractivated", "userphoto","userfullname") VALUES
   (1, 'anemanova','+7981236498', 'anemanova@yandex.ru','password','admin', 'true','https://sun9-31.userapi.com/c850216/v850216698/11e26c/jnOAMXU4iW4.jpg?ava=1','Неманова Анна'),
   (1, 'vasyatop','+7978145618', 'vasyatop@yandex.ru','password','manager', 'true','https://pp.userapi.com/c855228/v855228883/25ca2/dt0FCS9FHrc.jpg','Василий Федоров');

--Creation Date default date now
INSERT INTO "pipelines"("userscompaniesid","pipelinename") VALUES (1,'Главная воронка продаж');

INSERT INTO "goals"("userscompaniesid","goalvalue","goaldate","goaltype") VALUES (1,100000,'2019-06-01', 'Полугодовая цель');

INSERT INTO "stages"("pipelineid","stagename") VALUES 
(1,'Первый контакт'),
(1,'Назначена встреча'),
(1,'Отправлено КП'),
(1,'Выслан договор'),
(1,'Исполнение обязанностей'),
(1,'Успех'),
(1,'Неудача');

INSERT INTO "clients"("userscompaniesid","clientname","clientcompanyname","clientphone","clientemail","clientposition","clientadress") VALUES 
  (1,'Королёв Гаянэ Дамирович','Ridge Cloud','8(800)246-22-50','MarkSLucas@teleworm.us','Генеральный диерктор','БЦ Невский'),
  (1,'Авдеев Тимур Львович','Rank Cloud','8(800)178-15-20','BrandiJMusselman@armyspy.com','Генеральный диерктор','БЦ Невский'),
  (1,'Горбунов Федор Филатович','Cloud Ex','8(800)313-37-72','MicahEMurray@dayrep.com','Генеральный диерктор','БЦ Невский'),
  (1,'Шубин Харитон Проклович','Cloud Rhino','8(800)255-53-47','','Генеральный диерктор','ТРК ЛЕТО'),
  (1,'Зуева Санда Михайловна','Cloud Able','8(800)848-00-91','','Генеральный диерктор','ТРК ЛЕТО'),
  (1,'Сорокина Аделия Арсеньевна','Dev Cloud','8(800)693-11-48','','Генеральный диерктор','ТРК ЛЕТО'),
  (1,'Исаев Любомир Мэлорович','Cloud Vine','8(800)693-11-48','','Генеральный диерктор','ТРК ЛЕТО'),
  (1,'Фролов Нелли Матвеевич','Data Cloud','8(800)852-99-04','','Генеральный диерктор','ТРК ЛЕТО');

INSERT INTO "deals"("clientid","stageid","userid","dealname","dealprice","dealdate") VALUES (1,1,1,'Создание дизайна комнаты',1000,'2018-05-01');

INSERT INTO "tasks"("dealid","userid","taskname","taskdescription","taskdate","taskstatus") VALUES
  (1,1,'Позвонить клиенту','Клиент просил перезвонить ему когда он освободится','2019-06-15','false'),
  (1,2,'Подготовить ответ на вопрос почему у нас?','Клиент интересовался почему мы','2019-05-15','true');




INSERT INTO "actionlog"("userid","objecttype","objectid","actiontype") VALUES 
(1,'Сделка',1,'Сделка добавлена'),
(1,'Сделка',1,'Сделка добавлена'),
(1,'Сделка',1,'Сделка обновлена'),
(1,'Сделка',2,'Сделка завершена'),
(1,'Сделка',3,'Сделка добавлена'),
(1,'Сделка',4,'Сделка добавлена'),
(1,'Сделка',5,'Сделка добавлена'),
(1,'Сделка',1,'Сделка переведена на этап КП'),
(1,'Сделка',1,'Сделка переведена на этап переговоров'),
(1,'Сделка',6,'Сделка добавлена'),
(1,'Сделка',7,'Сделка завершена'),
(1,'Сделка',1,'Сделка обновлена'),
(1,'Задача',8,'Задача добавлена'),
(1,'Задача',1,'Задача выполнена'),
(1,'Задача',1,'Задача удалена'),
(1,'Сделка',1,'Сделка добавлена');
