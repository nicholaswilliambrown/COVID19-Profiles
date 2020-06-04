using Profiles.Framework.Utilities;


namespace Profiles.Search.Utilities
{
    public class TopResearchers
    {
        private string _nodeid;
        public string Name { get; set; }
        public string Country { get; set; }
        public string URI { get { return string.Format("{0}/profile/{1}", Root.Domain, _nodeid); } set { _nodeid = value; } }
    }
}