<%@ Page Language="VB" AutoEventWireup="false" CodeFile="CreateAccount.aspx.vb" Inherits="CreateAccount" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
        San Francisco Coordinating Center<br />
        Secured Login Demonstration<br />
        <hr />
        <br />
        Account creation is managed with the built-in CreateUserWizard.&nbsp; New users are disabled by default, and a one-time verification email is sent to the email address they provide.<br />
        <br />
        <asp:CreateUserWizard ID="CreateUserWizard1" runat="server" 
            ContinueDestinationPageUrl="~/Default.aspx" DisableCreatedUser="True"
           OnSendingMail="CreateUserWizard1_SendingMail">  
             <MailDefinition From="YourGmailID@gmail.com" 
                Subject="Confirmation mail" 
                BodyFileName="~/TemplateUserVerification.txt">
            </MailDefinition>
            
            <WizardSteps>
                <asp:CreateUserWizardStep ID="CreateUserWizardStep1" runat="server">
                </asp:CreateUserWizardStep>
                <asp:CompleteWizardStep ID="CompleteWizardStep1" runat="server">
                </asp:CompleteWizardStep>
            </WizardSteps>
        </asp:CreateUserWizard>
        <br />
        After creation, you will receive an validation email.<br />
        Please click the link in that email to complete user creation.</div>
        <p>
        <asp:HyperLink ID="HyperLink3" runat="server" NavigateUrl="~/Default.aspx">Home</asp:HyperLink>
        </p>
    </form>
</body>
</html>
