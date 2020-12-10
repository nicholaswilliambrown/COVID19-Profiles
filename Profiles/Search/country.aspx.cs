using System;
using System.Xml;
using Profiles.Framework.Utilities;
using Profiles.Search.Utilities;

namespace Profiles.Search
{
    public partial class country : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            Search.Utilities.DataIO dataIO = new Search.Utilities.DataIO();

            string searchrequest ="";
            string searchfor = "";
            string country = (Request.QueryString["country"].IsNullOrEmpty() ? "" : Request.QueryString["country"]);
            XmlDocument xmlsearch = new XmlDocument();
            xmlsearch = dataIO.SearchRequest(searchfor, "false", "", "", "", "", country, "", "", "", "http://xmlns.com/foaf/0.1/Person", "15", "0", "", "", true, ref searchrequest); ;
            
            Response.Redirect(Root.Domain + $"/search/default.aspx?searchtype=people&new=true&country={country}&searchfor={searchfor}", true);
            Response.End();
        }
    }
}