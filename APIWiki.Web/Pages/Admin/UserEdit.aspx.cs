using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.Security;

namespace Altairis.Sewen.Wiki.Pages.Admin {
    public partial class UserEdit : System.Web.UI.Page {
        MembershipUser user;
        bool itsMe;

        protected void Page_Load(object sender, EventArgs e) {
            this.user = Membership.GetUser(this.RouteData.Values["username"] as string, false);
            this.itsMe = this.user.UserName.Equals(this.User.Identity.Name, StringComparison.OrdinalIgnoreCase);
            this.DeleteButton.Enabled = !itsMe;
            this.AdministratorCheckBox.Enabled = !itsMe;
            if (!this.IsPostBack) {
                this.CommentTextBox.Text = this.user.Comment;
                this.EmailTextBox.Text = this.user.Email;
                this.EnabledCheckBox.Checked = this.user.IsApproved;
                this.AdministratorCheckBox.Checked = Roles.IsUserInRole(this.user.UserName, Global.Configuration.Security.AdminRoleName);
            }
        }

        protected void SubmitButton_Click(object sender, EventArgs e) {
            if (!this.IsValid) return;

            // Save 
            this.user.Comment = this.CommentTextBox.Text;
            this.user.Email = this.EmailTextBox.Text;
            this.user.IsApproved = this.EnabledCheckBox.Checked;
            Membership.UpdateUser(user);

            // Change password
            if (!string.IsNullOrWhiteSpace(this.NewPasswordTextBox.Text)) {
                var tempPassword = user.ResetPassword();
                user.ChangePassword(tempPassword, this.NewPasswordTextBox.Text);
            }

            // Change role membership
            if (!this.itsMe && this.AdministratorCheckBox.Checked != Roles.IsUserInRole(this.user.UserName, Global.Configuration.Security.AdminRoleName)) {
                if (this.AdministratorCheckBox.Checked) {
                    Roles.AddUserToRole(this.user.UserName, Global.Configuration.Security.AdminRoleName);
                }
                else {
                    Roles.RemoveUserFromRole(this.user.UserName, Global.Configuration.Security.AdminRoleName);
                }
            }

            this.Response.RedirectToRoute("AdminUserList");
        }

        protected void DeleteButton_Click(object sender, EventArgs e) {
            Membership.DeleteUser(this.user.UserName);
            this.Response.RedirectToRoute("AdminUserList");
        }
    }
}