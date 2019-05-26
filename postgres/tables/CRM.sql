/*==============================================================*/
/* DBMS name:      PostgreSQL 8                                 */
/* Created on:     18.04.2019 21:31:49                          */
/*==============================================================*/


/*==============================================================*/
/* Table: ActionLog                                             */
/*==============================================================*/
create table ActionLog (
   actionid             SERIAL               not null,
   UserID               INT4                 not null,
   objecttype           VARCHAR(100)         not null,
   objectid             INT4                 not null,
   actiontype           VARCHAR(255)         not null,
   actiondate           DATE                 null default CURRENT_TIMESTAMP,
   constraint PK_ACTIONLOG primary key (actionid)
);

/*==============================================================*/
/* Table: Clients                                               */
/*==============================================================*/
create table Clients (
   ClientID             SERIAL               not null,
   UsersCompaniesID     INT4                 null,
   ClientName           VARCHAR(255)         not null,
   ClientCompanyName    VARCHAR(255)         null,
   ClientPhone          VARCHAR(20)          null,
   ClientEmail          VARCHAR(100)         null,
   ClientSite           VARCHAR(255)         null,
   ClientPosition       VARCHAR(255)         null,
   ClientAdress         TEXT                 null,
   constraint PK_CLIENTS primary key (ClientID)
);

/*==============================================================*/
/* Index: Contacts_PK                                           */
/*==============================================================*/
create unique index Contacts_PK on Clients (
ClientID
);

/*==============================================================*/
/* Index: UsersContacts_FK                                      */
/*==============================================================*/
create  index UsersContacts_FK on Clients (
ClientID
);

/*==============================================================*/
/* Table: Deals                                                 */
/*==============================================================*/
create table Deals (
   DealID               SERIAL               not null,
   ClientID             INT4                 null,
   StageID              INT4                 not null,
   UserID               INT4                 not null,
   DealName             VARCHAR(255)         not null,
   DealPrice            FLOAT8               null,
   DealDate             DATE                 null,
   DealMovedDate        DATE                 null,
   DealCreatedAt        DATE                 null default CURRENT_TIMESTAMP,
   DealLastModify       DATE                 null,
   DealLastStageChange  DATE                 null,
   constraint PK_DEALS primary key (DealID)
);

/*==============================================================*/
/* Index: Deals_PK                                              */
/*==============================================================*/
create unique index Deals_PK on Deals (
DealID
);

/*==============================================================*/
/* Index: StagesDeals_FK                                        */
/*==============================================================*/
create  index StagesDeals_FK on Deals (
StageID
);

/*==============================================================*/
/* Index: UsersDeals_FK                                         */
/*==============================================================*/
create  index UsersDeals_FK on Deals (
UserID
);

/*==============================================================*/
/* Index: ContactsDeals_FK                                      */
/*==============================================================*/
create  index ContactsDeals_FK on Deals (
ClientID
);

/*==============================================================*/
/* Table: Goals                                                 */
/*==============================================================*/
create table Goals (
   GoalID               SERIAL               not null,
   UsersCompaniesID     INT4                 not null,
   GoalValue            FLOAT8               not null,
   GoalDate             DATE                 not null,
   GoalType             VARCHAR(150)         null,
   GoalCreationDate     DATE                 null default CURRENT_TIMESTAMP,
   constraint PK_GOALS primary key (GoalID)
);

/*==============================================================*/
/* Index: Goals_PK                                              */
/*==============================================================*/
create unique index Goals_PK on Goals (
GoalID
);

/*==============================================================*/
/* Index: CompanyGoals_FK                                       */
/*==============================================================*/
create  index CompanyGoals_FK on Goals (
UsersCompaniesID
);

/*==============================================================*/
/* Table: Pipelines                                             */
/*==============================================================*/
create table Pipelines (
   PipelineID           SERIAL               not null,
   UsersCompaniesID     INT4                 not null,
   PipelineName         VARCHAR(255)         not null,
   PipelineCreationDate DATE                 null default CURRENT_TIMESTAMP,
   constraint PK_PIPELINES primary key (PipelineID)
);

/*==============================================================*/
/* Index: Pipelines_PK                                          */
/*==============================================================*/
create unique index Pipelines_PK on Pipelines (
PipelineID
);

/*==============================================================*/
/* Index: UsersCompaniesPipelines_FK                            */
/*==============================================================*/
create  index UsersCompaniesPipelines_FK on Pipelines (
UsersCompaniesID
);

/*==============================================================*/
/* Table: Stages                                                */
/*==============================================================*/
create table Stages (
   StageID              SERIAL               not null,
   PipelineID           INT4                 not null,
   StageName            VARCHAR(255)         not null,
   constraint PK_STAGES primary key (StageID)
);

/*==============================================================*/
/* Index: Stages_PK                                             */
/*==============================================================*/
create unique index Stages_PK on Stages (
StageID
);

/*==============================================================*/
/* Index: UsersStages_FK                                        */
/*==============================================================*/
create  index UsersStages_FK on Stages (
PipelineID
);

/*==============================================================*/
/* Table: Tasks                                                 */
/*==============================================================*/
create table Tasks (
   TaskID               SERIAL               not null,
   DealID               INT4                 not null,
   UserID               INT4                 not null,
   TaskName             VARCHAR(255)         not null,
   TaskDescription      TEXT                 null,
   TaskDate             DATE                 not null,
   TaskStatus           BOOL                 null,
   TaskStatusChangeDate DATE                 null,
   constraint PK_TASKS primary key (TaskID)
);

/*==============================================================*/
/* Index: Tasks_PK                                              */
/*==============================================================*/
create unique index Tasks_PK on Tasks (
TaskID
);

/*==============================================================*/
/* Index: DealsTasks_FK                                         */
/*==============================================================*/
create  index DealsTasks_FK on Tasks (
DealID
);

/*==============================================================*/
/* Index: UsersTasks_FK                                         */
/*==============================================================*/
create  index UsersTasks_FK on Tasks (
UserID
);

/*==============================================================*/
/* Table: Users                                                 */
/*==============================================================*/
create table Users (
   UserID               SERIAL               not null,
   UsersCompaniesID     INT4                 null,
   UserName             VARCHAR(150)         not null,
   UserPhone            VARCHAR(150)         null,
   UserEmail            VARCHAR(150)         not null,
   UserPassword         TEXT                 not null,
   UserType             VARCHAR(30)          null default 'Manager',
   UserActivated        BOOL                 null default false,
   UserActivationDueDate DATE                null,
   UserPhoto            TEXT                 null,
   UserFullName         VARCHAR(200)         null,
   Salt                 TEXT                 not null,
   constraint PK_USERS primary key (UserID)
);

/*==============================================================*/
/* Index: Users_PK                                              */
/*==============================================================*/
create unique index Users_PK on Users (
UserID
);

/*==============================================================*/
/* Index: UsersCompaniesUsers_FK                                */
/*==============================================================*/
create  index UsersCompaniesUsers_FK on Users (
UsersCompaniesID
);

/*==============================================================*/
/* Index: UserName_Index                                        */
/*==============================================================*/
create  index UserName_Index on Users (
UserName
);

/*==============================================================*/
/* Index: UserEmail_Index                                       */
/*==============================================================*/
create  index UserEmail_Index on Users (
UserEmail
);

/*==============================================================*/
/* Table: UsersCompanies                                        */
/*==============================================================*/
create table UsersCompanies (
   UsersCompaniesID     SERIAL               not null,
   UsersCompanyName     VARCHAR(100)         null,
   constraint PK_USERSCOMPANIES primary key (UsersCompaniesID)
);

/*==============================================================*/
/* Index: UsersCompanies_PK                                     */
/*==============================================================*/
create unique index UsersCompanies_PK on UsersCompanies (
UsersCompaniesID
);

alter table ActionLog
   add constraint FK_ACTIONLO_REFERENCE_USERS foreign key (UserID)
      references Users (UserID)
      on delete restrict on update restrict;

alter table Clients
   add constraint FK_CLIENTS_REFERENCE_USERSCOM foreign key (UsersCompaniesID)
      references UsersCompanies (UsersCompaniesID)
      on delete restrict on update restrict;

alter table Deals
   add constraint FK_DEALS_CONTACTSD_CLIENTS foreign key (ClientID)
      references Clients (ClientID)
      on delete restrict on update restrict;

alter table Deals
   add constraint FK_DEALS_STAGESDEA_STAGES foreign key (StageID)
      references Stages (StageID)
      on delete restrict on update restrict;

alter table Deals
   add constraint FK_DEALS_USERSDEAL_USERS foreign key (UserID)
      references Users (UserID)
      on delete restrict on update restrict;

alter table Goals
   add constraint FK_GOALS_COMPANYGO_USERSCOM foreign key (UsersCompaniesID)
      references UsersCompanies (UsersCompaniesID)
      on delete restrict on update restrict;

alter table Pipelines
   add constraint FK_PIPELINE_USERSCOMP_USERSCOM foreign key (UsersCompaniesID)
      references UsersCompanies (UsersCompaniesID)
      on delete restrict on update restrict;

alter table Stages
   add constraint FK_STAGES_PIPELINES_PIPELINE foreign key (PipelineID)
      references Pipelines (PipelineID)
      on delete restrict on update restrict;

alter table Tasks
   add constraint FK_TASKS_TASKSDEAL_DEALS foreign key (DealID)
      references Deals (DealID)
      on delete restrict on update restrict;

alter table Tasks
   add constraint FK_TASKS_USERSTASK_USERS foreign key (UserID)
      references Users (UserID)
      on delete restrict on update restrict;

alter table Users
   add constraint FK_USERS_USERSCOMP_USERSCOM foreign key (UsersCompaniesID)
      references UsersCompanies (UsersCompaniesID)
      on delete restrict on update restrict;

