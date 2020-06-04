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
            XmlDocument xmlsearch = new XmlDocument();
            xmlsearch = dataIO.SearchRequest("Coronavirus", "false", "", "", Request.QueryString["country"], "", "", "", "", "", "http://xmlns.com/foaf/0.1/Person", "15", "0", "", "", "", "", true, ref searchrequest); ;
            //Session["searchrequest"] = searchrequest;
            //Session["dontencrypt"] = true;
            Response.Redirect(Root.Domain + "/search/default.aspx?searchtype=people&searchrequest=" + searchrequest + "&new=true", true);
            Response.End();
        }
    }
}