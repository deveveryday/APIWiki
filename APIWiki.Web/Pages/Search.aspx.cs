using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Altairis.Sewen.Wiki.Pages {
    public partial class Search : System.Web.UI.Page {
        protected void Page_Load(object sender, EventArgs e) {
            if (this.IsPostBack || string.IsNullOrWhiteSpace(Request.QueryString["query"])) return;

            this.TextBoxQuery.Text = Request.QueryString["query"];
            this.ResultsListView.DataSource = PageStoreManager.FindPagesByTitle(Request.QueryString["query"]);
            this.ResultsListView.DataBind();
        }

        protected void SearchButton_Click(object sender, EventArgs e) {
            if (!this.IsValid) return;
            Response.Redirect("~/search?query=" + HttpUtility.UrlEncode(this.TextBoxQuery.Text));
        }
    }
}