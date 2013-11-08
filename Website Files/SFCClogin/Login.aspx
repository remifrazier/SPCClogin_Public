<%@ Page Language="VB" AutoEventWireup="false" CodeFile="Login.aspx.vb" Inherits="Default2" %>

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
        The login on this page authenticates against a MSSQL 2008R2 database.<br />
        <br />
        <asp:Login ID="Login1" runat="server" DestinationPageUrl="~/Default.aspx">
        </asp:Login>
        
        
        <asp:ValidationSummary ID="ValidationSummary1" runat="server" ValidationGroup="Login1" />
   
        New user?&nbsp; Maybe you should
        <asp:HyperLink ID="HyperLink5" runat="server" NavigateUrl="~/CreateAccount.aspx">create an account</asp:HyperLink>
        !<br />
   
    </div>
        <p>
            <br />
        <asp:HyperLink ID="HyperLink3" runat="server" NavigateUrl="~/Default.aspx">Home</asp:HyperLink>
        </p>
    </form>
</body>
</html>
