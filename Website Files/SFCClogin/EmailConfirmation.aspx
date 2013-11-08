<%@ Page Language="VB" AutoEventWireup="false" CodeFile="EmailConfirmation.aspx.vb" Inherits="EmailConfirmation" %>

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
    
        <asp:Label ID="Label1" runat="server" Text="Thank you!  Your account is ready to be verified."></asp:Label>
    
        <br />
    
    </div>
    <asp:Button ID="Button1" runat="server" Text="Verify" />
        <asp:HyperLink ID="HyperLink4" runat="server" NavigateUrl="~/Login.aspx" Visible="False">Login</asp:HyperLink>
        <p>
    
        <asp:HyperLink ID="HyperLink3" runat="server" NavigateUrl="~/Default.aspx">Home</asp:HyperLink>
        </p>
    </form>
</body>
</html>
