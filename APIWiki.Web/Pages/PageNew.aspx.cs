using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Altairis.Sewen.Wiki.Pages {
    public partial class PageNew : System.Web.UI.Page {
        protected void Page_Load(object sender, EventArgs e) {
            if (!this.IsPostBack) {
                var tb = this.PageFormView.FindControl("TitleTextBox") as TextBox;
                tb.Text = this.RouteData.Values["slug"] as string;
            }
        }

        protected void PageFormView_ItemCommand(object sender, FormViewCommandEventArgs e) {
            Response.RedirectToRoute("HomePage");
        }

        protected void PageFormView_ItemInserted(object sender, FormViewInsertedEventArgs e) {
            // Get title of newly inserted page
            var newPageSlug = SewenPage.GetSlug(e.Values["Title"] as string);

            // Redirect to the new page
            Response.RedirectToRoute("SewenWikiPage", new { slug = newPageSlug });
        }
    }
}