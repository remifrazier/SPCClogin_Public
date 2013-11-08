<%@ Page Language="VB" AutoEventWireup="false" CodeFile="AccountSettings.aspx.vb" Inherits="SecuredSite_AccountSettings" %>

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
        <asp:ChangePassword ID="ChangePassword1" runat="server" 
            CancelDestinationPageUrl="~/Default.aspx" 
            ContinueDestinationPageUrl="~/Default.aspx">
        </asp:ChangePassword>
    
    </div>
        <p>
    
        <asp:HyperLink ID="HyperLink3" runat="server" NavigateUrl="~/Default.aspx">Home</asp:HyperLink>
        </p>
    </form>
</body>
</html>
