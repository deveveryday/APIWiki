using System.Configuration;

namespace Altairis.Sewen.Wiki.Configuration {
    public class SewenWikiConfigurationSection : ConfigurationSection {

        [ConfigurationProperty("security")]
        public SecurityElement Security {
            get { return (SecurityElement)this["security"]; }
            set { this["security"] = value; }
        }

    }
}