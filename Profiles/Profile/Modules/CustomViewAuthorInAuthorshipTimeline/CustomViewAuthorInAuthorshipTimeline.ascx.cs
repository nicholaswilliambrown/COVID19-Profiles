using System;
using System.Collections.Generic;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Xml;
using System.Web.UI.HtmlControls;

using Profiles.Framework.Utilities;


namespace Profiles.Profile.Modules.CustomViewAuthorInAuthorshipTimeline
{
    public partial class CustomViewAuthorInAuthorshipTimeline : BaseModule
    {
        protected string svcURL { get { return Root.Domain + "/profile/modules/CustomViewAuthorInAuthorship/BibliometricsSvc.aspx?p="; } }

        protected long nodeID { get { return base.RDFTriple.Subject; } }
        protected void Page_Load(object sender, EventArgs e)
        {
            DrawProfilesModule();
        }

        public CustomViewAuthorInAuthorshipTimeline() : base() { }
        public CustomViewAuthorInAuthorshipTimeline(XmlDocument pagedata, List<ModuleParams> moduleparams, XmlNamespaceManager pagenamespaces)
            : base(pagedata, moduleparams, pagenamespaces)
        {
            base.RDFTriple = new RDFTriple(Convert.ToInt64(Request.QueryString["Subject"]));
        }
        private void DrawProfilesModule()
        {
            Utilities.DataIO.ClassType type = Utilities.DataIO.ClassType.Unknown;
            Framework.Utilities.Namespace xmlnamespace = new Profiles.Framework.Utilities.Namespace();
            XmlNamespaceManager namespaces = xmlnamespace.LoadNamespaces(BaseData);
            if (BaseData.SelectSingleNode("rdf:RDF/rdf:Description[1]/rdf:type[@rdf:resource='http://xmlns.com/foaf/0.1/Person']", namespaces) != null)
                type = Utilities.DataIO.ClassType.Person;
            if (BaseData.SelectSingleNode("rdf:RDF/rdf:Description[1]/rdf:type[@rdf:resource='http://xmlns.com/foaf/0.1/Group']", namespaces) != null)
                type = Utilities.DataIO.ClassType.Group;

            DateTime d = DateTime.Now;
            Profiles.Profile.Modules.CustomViewAuthorInAuthorshipTimeline.DataIO data = new Profiles.Profile.Modules.CustomViewAuthorInAuthorshipTimeline.DataIO();

            // Get timeline bar chart
            string storedproc = "[Profile.Module].[NetworkAuthorshipTimeline.Person.GetCovidData]";
            if (type == Utilities.DataIO.ClassType.Group) storedproc = "[Profile.Module].[NetworkAuthorshipTimeline.Group.GetData]";

            Profiles.Profile.Modules.CustomViewAuthorInAuthorshipTimeline.DataIO.VisualizationImageLink vil = data.GetGoogleTimeline(base.RDFTriple, storedproc);
            covidTimelineBar.Src = vil.src;
            covidTimelineBar.Alt = vil.alt;
            litTimelineTable.Text = vil.asText;


            storedproc = "[Profile.Module].[NetworkAuthorshipTimeline.Person.GetData]";
            if (type == Utilities.DataIO.ClassType.Group) storedproc = "[Profile.Module].[NetworkAuthorshipTimeline.Group.GetData]";
            vil = data.GetGoogleTimeline(base.RDFTriple, storedproc);

            timelineBar.Src = vil.src;
            timelineBar.Alt = vil.alt;
            litTimelineTable.Text = vil.asText;

            if (timelineBar.Src == "")
            {
                timelineBar.Visible = false;
            }

            Framework.Utilities.DebugLogging.Log("PUBLICATION MODULE end Milliseconds:" + (DateTime.Now - d).TotalSeconds);
        }

    }
}