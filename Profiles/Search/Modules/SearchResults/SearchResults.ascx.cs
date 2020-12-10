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
using System.Web;
using System.Web.UI;
using System.Xml;
using System.Xml.Xsl;
using System.Configuration;

using Profiles.Framework.Utilities;
using Profiles.Search.Utilities;
using Profiles.ORNG.Utilities;

namespace Profiles.Search.Modules.SearchResults
{
    public partial class SearchResults : BaseModule
    {
        protected void Page_Init(object sender, EventArgs e)
        {
            DrawProfilesModule();
        }
        public SearchResults() { }
        public SearchResults(XmlDocument pagedata, List<ModuleParams> moduleparams, XmlNamespaceManager pagenamespaces)
            : base(pagedata, moduleparams, pagenamespaces)
        {
            Utilities.DataIO data = new Profiles.Search.Utilities.DataIO();


            this.SearchData = pagedata;
        }

        public XmlDocument SearchData { get; set; }


        private void DrawProfilesModule()
        {

            XsltArgumentList args = new XsltArgumentList();
            long offset = 0;
            long perpage = 0;
            long totalcount = 0;
            long totalpageremainder = 0;
            long totalpages = 0;
            long startrecord = 0;
            long page = 0;
            string searchfor = "";
            string classgroupuri = "";
            string classuri = "";

            string fname = "";
            string lname = "";
            string institution = "";
            string department = "";
            string division = "";            
            string searchrequest = "";
            XmlDocument xmlsearchrequest;
            xmlsearchrequest = new XmlDocument();


            string otherfilters = "";
            string institutionallexcept = string.Empty;
            string departmentallexcept = "0";
            string divisionallexcept = string.Empty;
            string exactphrase = "false"; // UCSF default value to allow old Mini Search to work


            string country = (Request.QueryString["country"].IsNullOrEmpty() ? "(All)" : Request.QueryString["country"]);
            department = country;
            string keywordOrPerson = "keyword";



            string searchtype = "";

            Search.Utilities.DataIO data = new Profiles.Search.Utilities.DataIO();
                        

            if (String.IsNullOrEmpty(Request.QueryString["searchtype"]) == false)
            {
                searchtype = Request.QueryString["searchtype"];
            }
            else if (String.IsNullOrEmpty(Request.Form["searchtype"]) == false)
            {
                searchtype = Request.Form["searchtype"];
            }


            if (String.IsNullOrEmpty(Request.QueryString["searchfor"]) == false)
            {
                searchfor = Request.QueryString["searchfor"];
                //exactphrase = Request.QueryString["exactphrase"];  This is causing a bug. We test and set this if present later in this block anyway
            }
            else if (String.IsNullOrEmpty(Request.Form["txtSearchFor"]) == false)
            {
                searchfor = Request.Form["txtSearchFor"];
            }
            

            if (searchfor == null)
                searchfor = string.Empty;

            if (String.IsNullOrEmpty(Request.QueryString["lname"]) == false)
                lname = Request.QueryString["lname"];
            else
                lname = Request.Form["txtLname"];

            if (lname == null)
                lname = string.Empty;

            if (String.IsNullOrEmpty(Request.QueryString["fname"]) == false)
                fname = Request.QueryString["fname"];
            else
                fname = Request.Form["txtFname"];

            if (fname == null)
                fname = string.Empty;

        

            if (String.IsNullOrEmpty(Request.QueryString["perpage"]) == false)
            {
                perpage = Convert.ToInt64(Request.QueryString["perpage"]);
                if (!(perpage > 0))
                    perpage = 15;                
            }
            else
            {
                perpage = 15; //default
            }

            if (String.IsNullOrEmpty(Request.QueryString["offset"]) == false)
            {
                offset = Convert.ToInt64(Request.QueryString["offset"]);                
            }
            else
            {
                offset = 0;
            }

            if (String.IsNullOrEmpty(Request.QueryString["page"]) == false)
            {
                page = Convert.ToInt64(Request.QueryString["page"]);
                if (!(page > 0))
                    page = 1;             
            }
            else
            {
                page = 1;
            }


            if (String.IsNullOrEmpty(Request.QueryString["classgroupuri"]) == false)
                classgroupuri = HttpUtility.UrlDecode(Request.QueryString["classgroupuri"]);
            else
                classgroupuri = HttpUtility.UrlDecode(Request.Form["classgroupuri"]);

            if (classgroupuri != null)
            {
                if (classgroupuri.Contains("!"))
                    classgroupuri = classgroupuri.Replace('!', '#');
            }
            else
            {
                classgroupuri = string.Empty;
            }

            if (String.IsNullOrEmpty(Request.QueryString["classuri"]) == false)
                classuri = HttpUtility.UrlDecode(Request.QueryString["classuri"]);
            else
                classuri = HttpUtility.UrlDecode(Request.Form["classuri"]);

            if (classuri != null)
            {
                if (classuri.Contains("!"))
                    classuri = classuri.Replace('!', '#');
            }
            else
            {
                classuri = string.Empty;
            }


            if (String.IsNullOrEmpty(Request.QueryString["otherfilters"]) == false)
            {
                otherfilters = Request.QueryString["otherfilters"];

            }


            try
            {

                totalcount = data.GetTotalSearchConnections(this.SearchData, base.Namespaces);

                if (page < 0)
                {
                    page = 1;
                }


                totalpages = Math.DivRem(totalcount, Convert.ToInt64(perpage), out totalpageremainder);

                if (totalpageremainder > 0) { totalpages = totalpages + 1; }

                if (page > totalpages)
                    page = totalpages;

                startrecord = ((Convert.ToInt32(page) * Convert.ToInt32(perpage)) + 1) - Convert.ToInt32(perpage);

                if (startrecord < 0)
                    startrecord = 1;                

                List<GenericListItem> g = new List<GenericListItem>();
                g = data.GetListOfFilters();

                if (otherfilters.IsNullOrEmpty() && base.BaseData.SelectSingleNode("rdf:RDF/rdf:Description/vivo:overview/SearchOptions/MatchOptions/SearchFiltersList/SearchFilter[@Property='http://profiles.catalyst.harvard.edu/ontology/prns#hasPersonFilter']", base.Namespaces) != null)
                {
                    string s = string.Empty;

                    foreach (XmlNode x in base.BaseData.SelectSingleNode("rdf:RDF/rdf:Description/vivo:overview/SearchOptions/MatchOptions/SearchFiltersList/SearchFilter[@Property='http://profiles.catalyst.harvard.edu/ontology/prns#hasPersonFilter']", base.Namespaces))
                    {
                        s = data.GetConvertedURIListItem(g, x.InnerText);
                        otherfilters += "," + s;
                    }
                }


               
                //added this test for search type so we could split the person keyword search into a split to remove the why col for person
                keywordOrPerson = data.SearchType(searchfor);


                if (keywordOrPerson == "person")
                {

                    xmlsearchrequest = data.CovidPersonSearchRequest(searchfor, (startrecord - 1).ToString(), perpage.ToString(),country);
                }
                else
                {
                    xmlsearchrequest = data.SearchRequest(searchfor, exactphrase, fname, lname, institution, institutionallexcept, department, departmentallexcept, division, divisionallexcept, "http://xmlns.com/foaf/0.1/Person", perpage.ToString(), (startrecord - 1).ToString(), otherfilters, "", true, ref searchrequest);
                    HttpContext.Current.Session["PERSON-SEARCH-ADD"] = "true";
                }

                this.SearchData = data.Search(xmlsearchrequest, false, false);
                this.SearchRequest = xmlsearchrequest.OuterXml;
                base.MasterPage.SearchRequest = this.SearchRequest;
                base.MasterPage.RDFData = this.SearchData;
                base.MasterPage.RDFNamespaces = this.Namespaces;

            }
            catch (DisallowedSearchException se)
            {
                litEverythingResults.Text = se.Message;
                return;
            }
            catch (Exception ex)
            {
                ex = ex;
                DebugLogging.Log("ERROR " + ex.Message);
                //for now just flip it back to the defaults. This is if someone keys some funky divide by zero stuff in the URL
                // to try and break the system.
                startrecord = 1;
                perpage = 15;
            }

            args.AddParam("root", "", Root.Domain);
            args.AddParam("perpage", "", perpage);
            args.AddParam("offset", "", offset);
            args.AddParam("totalpages", "", totalpages);
            args.AddParam("page", "", page);
            args.AddParam("searchfor", "", searchfor);
            args.AddParam("exactphrase", "", exactphrase);
            args.AddParam("classGrpURIpassedin", "", classgroupuri);
            args.AddParam("classURIpassedin", "", classuri);            

            switch (searchtype.ToLower())
            {
                case "everything":
                    litEverythingResults.Text = XslHelper.TransformInMemory(Server.MapPath("~/Search/Modules/SearchResults/EverythingResults.xslt"), args, this.SearchData.OuterXml);
                    break;
                case "people":
       

                    args.AddParam("country", "", country);              

                   
                   if(keywordOrPerson== "keyword")
                        args.AddParam("why", "", true);
                    else
                        args.AddParam("why", "", false);

                    litEverythingResults.Text = HttpUtility.HtmlDecode(XslHelper.TransformInMemory(Server.MapPath("~/Search/Modules/SearchResults/PeopleResults.xslt"), args, this.SearchData.OuterXml));
                    break;
            }
        }


        private string SearchRequest { get; set; }

        // OpenSocial http://localhost:55956/Search/Modules/SearchResults/SearchResults.ascx.cs
        public class ORNGSearchRPCService : PeopleListRPCService
        {
            private static int searchLimit;

            static ORNGSearchRPCService()
            {
                // should make this able to take a Dictionary of things
                searchLimit = ORNGSettings.getSettings().SearchLimit;
            }

            XmlDocument searchData;
            XmlDocument searchRequest;
            XmlNamespaceManager namespaceManager;

            public ORNGSearchRPCService(Page page, XmlDocument searchData, XmlDocument searchRequest, XmlNamespaceManager namespaceManager)
                : base(null, page, false)
            {
                this.searchData = searchData;
                this.searchRequest = searchRequest;
                this.namespaceManager = namespaceManager;
            }

            public override string getPeopleListMetadata()
            {
                try
                {
                    XmlNode node = searchData.SelectSingleNode("rdf:RDF/rdf:Description/prns:numberOfConnections", namespaceManager);
                    Int32 resultSize = Convert.ToInt32(node.InnerText);
                    if (resultSize == 1)
                    {
                        return "" + resultSize + " profile";
                    }
                    else if (resultSize <= searchLimit)
                    {
                        return "" + resultSize + " profiles";
                    }
                    else
                    {
                        return "top " + searchLimit + " profiles";
                    }
                }
                catch (Exception e)
                {
                    DebugLogging.Log(e.Message);
                }
                return "Error reading results";
            }

            public override List<string> getPeople()
            {
                //try
                //{
                //    List<string> peopleURIs = new List<string>();
                //    int offSet = 0;
                //    Boolean hasMorePeople = true;
                //    while (peopleURIs.Count < searchLimit && hasMorePeople)
                //    {
                //        searchRequest.SelectSingleNode("/SearchOptions/OutputOptions/Offset").InnerText = "" + offSet;
                //        searchRequest.SelectSingleNode("/SearchOptions/OutputOptions/Limit").InnerText = "" + searchLimit;
                //        XmlDocument searchData = new Profiles.Search.Utilities.DataIO().Search(searchRequest, false, false);

                //        DebugLogging.Log("SeachCallbackResponse :" + searchRequest.ToString());

                //        XmlNodeList people = searchData.GetElementsByTagName("rdf:object");
                //        for (int i = 0; i < people.Count; i++)
                //        {
                //            peopleURIs.Add(people[i].Attributes["rdf:resource"].Value);
                //        }
                //        // increase offset by amount found
                //        XmlNode node = searchData.SelectSingleNode("rdf:RDF/rdf:Description/prns:numberOfConnections", namespaceManager);
                //        offSet += people.Count;
                //        hasMorePeople = Convert.ToInt32(node.InnerText) > peopleURIs.Count;
                //    }
                //    if (peopleURIs.Count > 0)
                //    {
                //        return peopleURIs;
                //    }
                //}
                //catch (Exception e)
                //{
                //    DebugLogging.Log(e.Message);
                //}

                return null;
            }
        }

    }
}