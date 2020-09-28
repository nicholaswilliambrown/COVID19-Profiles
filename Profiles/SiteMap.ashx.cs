using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Profiles
{
    /// <summary>
    /// Summary description for SiteMap
    /// </summary>
    public class SiteMap : IHttpHandler
    {

        public void ProcessRequest(HttpContext context)
        {
            string output;
            if (!string.IsNullOrEmpty(context.Request.QueryString["Pagetype"]))
            {
                string pageType = context.Request.QueryString["Pagetype"].ToString();
                int offset = 0;
                if (!string.IsNullOrEmpty(context.Request.QueryString["Offset"]))
                    offset = Convert.ToInt32(context.Request.QueryString["Offset"]);

                output = new Framework.Utilities.DataIO().GetSiteMap(pageType, offset);
            }
            else
            {
                output = new Framework.Utilities.DataIO().GetSiteMapIndex();
            }
            context.Response.ContentType = "text/xml";
            context.Response.Write(output);
        }

        public bool IsReusable
        {
            get
            {
                return false;
            }
        }
    }
}