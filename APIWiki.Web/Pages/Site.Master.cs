using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.HtmlControls;
using System.Text.RegularExpressions;

namespace Altairis.Sewen.Wiki.Pages {
    public partial class Site : System.Web.UI.MasterPage {

        protected void Page_Load(object sender, EventArgs e) {

        }

        protected void Page_PreRender(object sender, EventArgs e) {
            // Add UI culture header
            this.Page.Header.Controls.Add(new HtmlMeta {
                Name = "x-ui-culture",
                Content = System.Threading.Thread.CurrentThread.CurrentUICulture.TwoLetterISOLanguageName
            });

            // Add build version to stylesheet references
            var stylesheetLinks = from c in this.Page.Header.Controls.OfType<HtmlLink>()
                                  where "stylesheet".Equals(c.Attributes["rel"], StringComparison.OrdinalIgnoreCase)
                                  && !Regex.IsMatch(c.Href, "^(http(s)?:)?//") && !c.Href.Contains("?")
                                  select c;
            foreach (var link in stylesheetLinks) {
                link.Href += "?" + Global.VersionString;
            }

            // Add build version to script references
            var scriptManager = ScriptManager.GetCurrent(this.Page);
            if (scriptManager != null) {
                var scriptRefs = from sr in scriptManager.Scripts
                                 where sr.Path != null && !Regex.IsMatch(sr.Path, "^(http(s)?:)?//") && !sr.Path.Contains("?")
                                 select sr;
                foreach (var sr in scriptRefs) {
                    sr.Path += "?" + Global.VersionString;
                }
            }
        }

    }
}