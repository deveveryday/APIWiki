using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Altairis.Sewen.Wiki.Pages {
    public partial class PageEdit : System.Web.UI.Page {
        protected void Page_Load(object sender, EventArgs e) {

        }

        protected void PageFormView_ItemCommand(object sender, FormViewCommandEventArgs e) {
            if (e.CommandName.Equals("Cancel", StringComparison.OrdinalIgnoreCase)) {
                Response.RedirectToRoute("SewenWikiPage");
            }
        }

        protected void PageFormView_ItemUpdated(object sender, FormViewUpdatedEventArgs e) {
            Response.RedirectToRoute("SewenWikiPage");
        }
    }
}