Imports System.Net.Mail
Partial Class CreateAccount
    Inherits System.Web.UI.Page
    'Most of the code below courtesy of a template by Amit Jain
    Protected Sub CreateUserWizard1_SendingMail(ByVal sender As Object, ByVal e As MailMessageEventArgs)

        Dim newUserAccount As MembershipUser = Membership.GetUser(CreateUserWizard1.UserName)
        Dim newUserAccountId As Guid = DirectCast(newUserAccount.ProviderUserKey, Guid)
        Dim domainName As String = Request.Url.GetLeftPart(UriPartial.Authority) + Request.ApplicationPath
        Dim confirmationPage As String = "/EmailConfirmation.aspx?ID=" & newUserAccountId.ToString()

        Dim url As String = domainName & confirmationPage
        e.Message.Body = e.Message.Body.Replace("<%VerificationUrl%>", url)
        Dim smtp As New SmtpClient()
        smtp.Host = "smtp.REDACTED.com"
        smtp.Port = REDACTED
        smtp.UseDefaultCredentials = False
        smtp.Credentials = New System.Net.NetworkCredential("REDACTED@REDACTED.com", "REDACTED")
        smtp.EnableSsl = True
        smtp.Send(e.Message)
        e.Cancel = True
    End Sub
End Class
