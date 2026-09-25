permissionset 50100 "ACA Follow-up"
{
    Assignable = true;
    Caption = 'ACA Follow-up', MaxLength = 30;
    Permissions = table "ACA Follow-up" = X,
        tabledata "ACA Follow-up" = RIMD,
        table "ACA Reminder Setup" = X,
        tabledata "ACA Reminder Setup" = RIMD,
        table "ACA Support Ticket" = X,
        tabledata "ACA Support Ticket" = RIMD,
        table "ACA Service Request" = X,
        tabledata "ACA Service Request" = RIMD,
        page "ACA Service Requests" = X,
        codeunit "ACA Service Request Mgt." = X,
        codeunit "ACA Follow-up Mgt." = X,
        codeunit "ACA Follow-up Demo" = X,
        codeunit "ACA Prompt Lesson" = X,
        codeunit "ACA Reminder Dispatcher" = X,
        codeunit "ACA Ticket Escalation" = X;
}