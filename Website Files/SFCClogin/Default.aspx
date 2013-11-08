<%@ Page Language="VB" AutoEventWireup="false" CodeFile="Default.aspx.vb" Inherits="_Default" %>

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
        
        <asp:LoginView ID="LoginView1" runat="server">
            <LoggedInTemplate>
                This is a landing page for logged-in users<br />
                <br />
                <asp:HyperLink ID="HyperLink1" runat="server" NavigateUrl="~/UnsecuredSite/UnsecuredPage.aspx">Link To Sample Unsecured Page</asp:HyperLink>
                <br />
                <br />
                <asp:HyperLink ID="HyperLink2" runat="server" NavigateUrl="~/SecuredSite/SecuredPage.aspx">Link To Sample Secured Page</asp:HyperLink>
                <br />
                <br />
                Logged in as:
                <asp:LoginName ID="LoginName1" runat="server" />
                &nbsp;|
                <asp:LoginStatus ID="LoginStatus2" runat="server" />
                &nbsp;|
                <asp:HyperLink ID="HyperLink4" runat="server" 
                    NavigateUrl="~/SecuredSite/AccountSettings.aspx">Account Settings</asp:HyperLink>
                <br />
            </LoggedInTemplate>
            <AnonymousTemplate>
                This is a landing page for outside (non-authenticated) users<br />
                <br />
                <asp:HyperLink ID="HyperLink1" runat="server" NavigateUrl="~/UnsecuredSite/UnsecuredPage.aspx">Link To Sample Unsecured Page</asp:HyperLink>
                <br />
                <br />
                <asp:LoginStatus ID="LoginStatus1" runat="server" />
                &nbsp;|
                <asp:HyperLink ID="HyperLink3" runat="server" 
                    NavigateUrl="~/CreateAccount.aspx">Create Account</asp:HyperLink>
                <br />
            </AnonymousTemplate>
        </asp:LoginView>
        
        <br />
        
    </div>
    </form>
</body>
</html>
