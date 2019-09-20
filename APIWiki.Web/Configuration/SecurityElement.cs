using System.Configuration;

namespace Altairis.Sewen.Wiki.Configuration {
    public class SecurityElement : ConfigurationElement {

        [ConfigurationProperty("enableUserManager", IsRequired = false, DefaultValue = true)]
        public bool EnableUserManager {
            get { return (bool)this["enableUserManager"]; }
            set { this["enableUserManager"] = value; }
        }

        [ConfigurationProperty("adminRoleName", IsRequired = false, DefaultValue = "administrators")]
        public string AdminRoleName {
            get { return (string)this["adminRoleName"]; }
            set { this["adminRoleName"] = value; }
        }

    }
}