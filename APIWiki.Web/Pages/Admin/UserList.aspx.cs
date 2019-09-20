using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.Security;

namespace Altairis.Sewen.Wiki.Pages.Admin {
    public partial class UserList : System.Web.UI.Page {

        protected void Page_Load(object sender, EventArgs e) {
            var createUserStatus = this.Request.QueryString["status"];
            if (!string.IsNullOrEmpty(createUserStatus)) {
                if (createUserStatus.Equals("Success", StringComparison.OrdinalIgnoreCase)) {
                    this.LiteralSucess.Visible = true;
                }
                else {
                    this.LiteralError.Text = string.Format(this.LiteralError.Text, HttpUtility.HtmlEncode(createUserStatus));
                    this.LiteralError.Visible = true;
                }
            }
        }

        protected void CreateUserButton_Click(object sender, EventArgs e) {
            if (!this.IsValid) return;

            MembershipCreateStatus status;
            Membership.CreateUser(
                this.UserNameTextBox.Text.ToLower(),
                this.PasswordTextBox.Text,
                this.EmailTextBox.Text.ToLower(),
                null, null, true,
                out status);
            Response.Redirect(this.GetRouteUrl("AdminUserList", null) + "?status=" + status.ToString());
        }

    }
}