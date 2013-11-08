<%@ Page Language="VB" AutoEventWireup="false" CodeFile="UnsecuredPage.aspx.vb" Inherits="UnsecuredSite_UnsecuredPage" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
        San Francisco Coordinating Center<br />
        Secured Login Demonstration<br />
        <hr />
        <br />
    <form id="form1" runat="server">
    <div>
        <br />
        Non-authenticated users can see any content which appears in this section of the site (anything in or below the ~/UnsecuredSite/ directory).
    </div>
        <p>
            &nbsp;</p>
        <p>
        <asp:HyperLink ID="HyperLink3" runat="server" NavigateUrl="~/Default.aspx">Home</asp:HyperLink>
        <br />
        </p>
    </form>
</body>
</html>
