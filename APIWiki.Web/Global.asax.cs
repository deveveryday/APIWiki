using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.SessionState;
using System.Web.Routing;
using Altairis.Sewen.Wiki.Configuration;
using System.Configuration;

namespace Altairis.Sewen.Wiki {
    public class Global : System.Web.HttpApplication {

        public static string VersionString { get; private set; }
        public static SewenWikiConfigurationSection Configuration { get; private set; }

        protected void Application_Start(object sender, EventArgs e) {
            // Read version
            VersionString = System.Reflection.Assembly.GetExecutingAssembly().GetName().Version.ToString();

            // Read configuration
            Configuration = ConfigurationManager.GetSection("altairis.sewenWiki") as SewenWikiConfigurationSection;
            if (Configuration == null) throw new ConfigurationErrorsException("The altairis.sewenWiki configuration section is missing or invalid.");

            // Setup routing
            RouteTable.Routes.MapPageRoute("HomePage", "", "~/Pages/Page.aspx", false, new RouteValueDictionary(new { slug = "home-page" }));
            RouteTable.Routes.MapPageRoute("SewenWikiPage", "page/{slug}", "~/Pages/Page.aspx");
            RouteTable.Routes.MapPageRoute("SewenWikiPageVersion", "page/{slug}/{version}", "~/Pages/Page.aspx", false, null, new RouteValueDictionary(new { version = new VersionRouteConstraint() }));
            RouteTable.Routes.MapPageRoute("SewenWikiPageEditPreview", "edit/preview", "~/Pages/Preview.aspx");
            RouteTable.Routes.MapPageRoute("SewenWikiPageEdit", "edit/{slug}", "~/Pages/PageEdit.aspx");
            RouteTable.Routes.MapPageRoute("SewenWikiPageHistory", "history/{slug}", "~/Pages/History.aspx");
            RouteTable.Routes.MapPageRoute("SewenWikiPageNew", "new/{slug}", "~/Pages/PageNew.aspx", false, new RouteValueDictionary(new { slug = "" }));
            RouteTable.Routes.MapPageRoute("SewenWikiSearch", "search", "~/Pages/Search.aspx");
            RouteTable.Routes.MapPageRoute("AccountLogin", "login", "~/Pages/Account/Login.aspx");
            RouteTable.Routes.MapPageRoute("AccountLogout", "logout", "~/Pages/Account/Login.aspx", false, null, null, new RouteValueDictionary(new { exe = "logout" }));
            RouteTable.Routes.MapPageRoute("AccountPassword", "my/password", "~/Pages/Account/Password.aspx");
            if (Configuration.Security.EnableUserManager) {
                // Enable user manager
                RouteTable.Routes.MapPageRoute("AdminUserList", "admin/users", "~/Pages/Admin/UserList.aspx");
                RouteTable.Routes.MapPageRoute("AdminUserNew", "admin/users/new", "~/Pages/Admin/UserNew.aspx");
                RouteTable.Routes.MapPageRoute("AdminUserDetail", "admin/users/{username}", "~/Pages/Admin/UserEdit.aspx");
            }
            else {
                // Disable user manager, but still define the routes, pointing nowhere
                // (required for RouteUrl expression builder)
                RouteTable.Routes.MapPageRoute("AdminUserList", string.Empty, "~/");
                RouteTable.Routes.MapPageRoute("AdminUserNew", string.Empty, "~/");
                RouteTable.Routes.MapPageRoute("AdminUserDetail", string.Empty, "~/");
            }
        }

        private class VersionRouteConstraint : IRouteConstraint {
            public bool Match(HttpContextBase httpContext, Route route, string parameterName, RouteValueDictionary values, RouteDirection routeDirection) {
                var val = values[parameterName] as string;
                DateTime dt;
                return DateTime.TryParseExact(val, "yyyyMMddHHmmssfff", null, System.Globalization.DateTimeStyles.AssumeLocal, out dt);
            }
        }

    }
}