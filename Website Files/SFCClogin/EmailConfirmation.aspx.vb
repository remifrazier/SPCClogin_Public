
Partial Class EmailConfirmation
    Inherits System.Web.UI.Page
    Protected Sub Button1_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles Button1.Click
        Dim newUserId As New Guid(Request.QueryString("ID"))
        Dim newUser As MembershipUser = Membership.GetUser(newUserId)
        If newUser Is Nothing Then
            Label1.Text = "User account not found"
        Else
            newUser.IsApproved = True
            Membership.UpdateUser(newUser)
            Label1.Text = "Account approved, please log in to continue"
            Button1.Visible = False
            HyperLink4.Visible = True
        End If
    End Sub
End Class
