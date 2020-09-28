using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Text;
using System.Xml;
using System.Configuration;

using Profiles.Framework.Utilities;
using System.Text.RegularExpressions;

namespace Profiles.Profile.Modules.NetworkDetails
{
    public partial class NetworkDetails : BaseModule
    {

        protected void Page_Load(object sender, EventArgs e)
        {

            DrawProfilesModule();
        }
        public NetworkDetails() { }
        public NetworkDetails(XmlDocument data, List<ModuleParams> moduleparams, XmlNamespaceManager namespaces)
            : base(data, moduleparams, namespaces)
        {

        }


        public void DrawProfilesModule()
        {
            Profiles.Profile.Modules.NetworkDetails.DataIO data = new Profiles.Profile.Modules.NetworkDetails.DataIO();
            string baseuri = Root.Domain + "/profile/"; 
            if (Request.QueryString["Subject"] == null || Request.QueryString["Predicate"] == null)
                return;
            Int64 subject = Convert.ToInt64(Request.QueryString["Subject"]);
            Int64 predicate = Convert.ToInt64(Request.QueryString["Predicate"]);
            RDFTriple request = new RDFTriple(subject, predicate);
            string str = "";
            if (Framework.Utilities.Cache.FetchObject(request.Key + "NetworkDetailsTableData") == null)
            {

                List<Profiles.Profile.Modules.NetworkDetails.DataIO.NetworkDetailsRow> rows = data.GetPersonConceptDetails(subject);


                int position = 0;
                /*
                foreach (Profiles.Profile.Modules.NetworkDetails.DataIO.NetworkDetailsRow row in rows)
                {
                    str += "<tr class=\"" + (position == 0 ? "evenRow" : "oddRow") + "\" onclick=\"doURL('" + basepath + "/profile/" + row.NodeID + "')\" onkeypress=\"if (event.keyCode == 13) doURL('" + basepath + "/profile/" + row.NodeID + "')\" onmouseover=\"doListTableRowOver(this)\" onfocus=\"doListTableRowOver(this)\" " +
                        "onmouseout=\"doListTableRowOut(this," + position + ")\" onblur=\"doListTableRowOut(this," + position + ")\" tabindex=\"0\"" +
                        ">" +
                        "<td><a href=\"" + basepath + "/profile/" + row.NodeID + "\">" + row.Name + "</a></td>" +
                        "<td>" + row.NumPubsThis + "</td>" +
                        "<td>" + row.LastPublicationYear + "</td>" +
                        "<td>" + row.NumPubsAll + "</td>" +
                        "<td>" + String.Format("{0:0.00}", row.Weight) + "</td>" +
                        "<td><a class=\"listTableLink\" href=\"" + basepath + "/profile/" + subject + "/" + predicate + "/" + row.NodeID + "\" style=\"cursor: pointer; color: rgb(51, 102, 204);\">Why?</a></td></tr>";

                    if (position == 0) position = 1; else position = 0;
                }
                */
                StringBuilder sb = new StringBuilder();

                foreach (Profiles.Profile.Modules.NetworkDetails.DataIO.NetworkDetailsRow row in rows)
                {
                    sb.Append("<tr class=\"");
                    sb.Append(position == 0 ? "evenRow" : "oddRow");
                    sb.Append("\" onclick=\"doURL('");
                    sb.Append(baseuri);
                    sb.Append(row.NodeID);
                    sb.Append("')\" onkeypress=\"if (event.keyCode == 13) doURL('");
                    sb.Append(baseuri);
                    sb.Append(row.NodeID);
                    sb.Append("')\" onmouseover=\"doListTableRowOver(this)\" onfocus=\"doListTableRowOver(this)\" onmouseout=\"doListTableRowOut(this,");
                    sb.Append(position);
                    sb.Append(")\" onblur=\"doListTableRowOut(this,");
                    sb.Append(position);
                    sb.Append(")\" tabindex=\"0\"><td><a href=\"");
                    sb.Append(baseuri);
                    sb.Append(row.NodeID);
                    sb.Append("\">");
                    sb.Append(row.Name);
                    sb.Append("</a></td><td>");
                    sb.Append(row.NumPubsThis);
                    sb.Append("</td><td>");
                    sb.Append(row.LastPublicationYear);
                    sb.Append("</td><td>");
                    sb.Append(row.NumPubsAll);
                    sb.Append("</td><td>");
                    sb.Append(String.Format("{0:0.00}", row.Weight));
                    sb.Append("</td><td><a class=\"listTableLink\" href=\"");
                    sb.Append(baseuri);
                    sb.Append(subject);
                    sb.Append("/");
                    sb.Append(predicate);
                    sb.Append("/");
                    sb.Append(row.NodeID);
                    sb.Append("\" style=\"cursor: pointer; color: rgb(51, 102, 204);\">Why?</a></td></tr>");

                    if (position == 0) position = 1; else position = 0;
                }
                str = sb.ToString();
                Framework.Utilities.Cache.Set(request.Key + "NetworkDetailsTableData", str);
            }
            else
            {
                str = (string)Framework.Utilities.Cache.FetchObject(request.Key + "NetworkDetailsTableData");
            }

            litDetailsTableData.Text = str;
            /*
                        if (base.GetModuleParamString("MapType") == "CoAuthor")
                        {

                            //reader = data.GetGMapUserCoAuthors(base.RDFTriple.Subject, 0, session.Session().SessionID);
                            //reader2 = data.GetGMapUserCoAuthors(base.RDFTriple.Subject, 1, session.Session().SessionID);

                        }

                        if (base.GetModuleParamString("MapType") == "SimilarTo")
                        {
                            //reader = data.GetGMapUserSimilarPeople(base.RDFTriple.Subject, false, session.Session().SessionID);
                            //reader2 = data.GetGMapUserSimilarPeople(base.RDFTriple.Subject, true, session.Session().SessionID);
                        }

                        if (base.GetModuleParamString("MapType") == "Group")
                        {
                            //litCoauthorGroup.Text = "group members";
                            //reader = data.GetGMapUserGroup(base.RDFTriple.Subject, 0, session.Session().SessionID);
                            //reader2 = data.GetGMapUserGroup(base.RDFTriple.Subject, 1, session.Session().SessionID);
                        }
            */

        }

    }
}