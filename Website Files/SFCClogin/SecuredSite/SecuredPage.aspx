<%@ Page Language="VB" AutoEventWireup="false" CodeFile="SecuredPage.aspx.vb" Inherits="SecuredSite_SecuredPage" %>

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
        <br />
        <br />
        Only logged-in users can access content which appears in this section of the site (anything in or below the ~/SecuredSite/ directory).
        <br />
        <br />
    </div>
        <p>
            &nbsp;</p>
        <p>
        <asp:HyperLink ID="HyperLink3" runat="server" NavigateUrl="~/Default.aspx">Home</asp:HyperLink>
        </p>
    </form>
</body>
</html>
