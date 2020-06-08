/*  
 
    Copyright (c) 2008-2012 by the President and Fellows of Harvard College. All rights reserved.  
    Profiles Research Networking Software was developed under the supervision of Griffin M Weber, MD, PhD.,
    and Harvard Catalyst: The Harvard Clinical and Translational Science Center, with support from the 
    National Center for Research Resources and Harvard University.


    Code licensed under a BSD License. 
    For details, see: LICENSE.txt 
  
*/
using System;
using System.Collections.Generic;
using System.Configuration;
using System.IO;
using System.Xml;
using Profiles.Framework.Utilities;
using Profiles.Search.Utilities;


namespace Profiles.Search.Modules.SearchMap
{
    public partial class SearchMap : BaseModule
    {

        protected void Page_Load(object sender, EventArgs e)
        {
            DrawProfilesModule();
        }

        public SearchMap() { }

        public SearchMap(XmlDocument pagedata, List<ModuleParams> moduleparams, XmlNamespaceManager pagenamespaces)
            : base(pagedata, moduleparams, pagenamespaces)
        {
        }
        public void DrawProfilesModule()
        {
            string countrycodes = string.Empty;
            DataIOMap dataIO = new Search.Utilities.DataIOMap();

            string researchers = Newtonsoft.Json.JsonConvert.SerializeObject(dataIO.GetTopGeoResearchers());
            string countries = Newtonsoft.Json.JsonConvert.SerializeObject(dataIO.GetCountryCounts());


            using (StreamReader sr = new StreamReader(Server.MapPath("~/Search/Modules/SearchMap/countries.json")))
            {
                countrycodes = sr.ReadToEnd();
            }

            litJS.Text = string.Format("<script>var countries = {0}; var researchers = {1};var countrycodes = {2};</script>", countries,researchers,countrycodes);
        }

        protected string googleKey
        {
            get
            {
                if (ConfigurationManager.AppSettings["GoogleMapsKey"] != null)
                {
                    if (ConfigurationManager.AppSettings["GoogleMapsKey"].ToString().Trim().Length > 0)
                        return "?key=" + ConfigurationManager.AppSettings["GoogleMapsKey"].ToString().Trim();
                }
                return "";
            }
        }

    }
}