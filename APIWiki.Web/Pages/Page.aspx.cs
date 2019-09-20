using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Altairis.Sewen.Wiki.Pages {
    public partial class Page : System.Web.UI.Page {
        protected void Page_Load(object sender, EventArgs e) {
            if ("delete".Equals(this.Request.QueryString["exe"], StringComparison.OrdinalIgnoreCase)) {
                var name = this.RouteData.Values["slug"] as string;
                bool result;
                if (this.RouteData.Values["version"] == null) {
                    result = PageStoreManager.DeletePage(name);
                }
                else {
                    var version = DateTime.ParseExact(this.RouteData.Values["version"] as string, "yyyyMMddHHmmssfff", null);
                    result = PageStoreManager.DeletePage(name, version);
                }
                if (result) {
                    if (PageStoreManager.LoadPage(name) == null) {
                        // All page versions were deleted - redirect to home page
                        this.Response.RedirectToRoute("HomePage");
                    }
                    else {
                        // Only one version was deleted - redirect to last known version
                        this.Response.RedirectToRoute("SewenWikiPage", new { slug = name });
                    }
                }
            }
            else if ("delete-old".Equals(this.Request.QueryString["exe"], StringComparison.OrdinalIgnoreCase)) {
                // Delete all versions of page except current
                var name = this.RouteData.Values["slug"] as string;
                var q = from p in PageStoreManager.LoadPageVersions(name)
                        orderby p.Version descending
                        select p.Version;
                q = q.Skip(1);
                foreach (var pageVersion in q) {
                    PageStoreManager.DeletePage(name, pageVersion);
                }
                this.Response.RedirectToRoute("SewenWikiPage", new { slug = name });
            }
        }
    }
}