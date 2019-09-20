using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.Security;

namespace Altairis.Sewen.Wiki.Pages.Account {
    public partial class Login : System.Web.UI.Page {
        protected void Page_Load(object sender, EventArgs e) {
            if ("logout".Equals(this.RouteData.DataTokens["exe"] as string)) {
                FormsAuthentication.SignOut();
                this.Response.RedirectToRoute("HomePage");
            }
        }
    }
}