﻿using System;
using System.Collections.Generic;
using System.Text;
using System.Xml;

using Profiles.Framework.Utilities;


namespace Profiles.Profile.Modules
{
    public partial class CustomViewConceptPublication : BaseModule
	{
		protected void Page_Load(object sender, EventArgs e)
		{
			DrawProfilesModule();
			ConceptName = this.BaseData.SelectSingleNode("rdf:RDF[1]/rdf:Description[1]/rdfs:label[1]", this.Namespaces).InnerText;
			
			// Add plus image
			plusImage.Src = Root.Domain + "/Profile/Modules/PropertyList/images/minusSign.gif";
		}

		public CustomViewConceptPublication() : base() { }
		public CustomViewConceptPublication(XmlDocument pagedata, List<ModuleParams> moduleparams, XmlNamespaceManager pagenamespaces)
			: base(pagedata, moduleparams, pagenamespaces)
		{
			base.RDFTriple = new RDFTriple(Convert.ToInt64(Request.QueryString["Subject"]));

		}

		public void DrawProfilesModule()
		{
			Profiles.Profile.Modules.CustomViewAuthorInAuthorshipTimeline.DataIO dataIO = new Profiles.Profile.Modules.CustomViewAuthorInAuthorshipTimeline.DataIO();

			// Get concept publication timeline
			Profiles.Profile.Modules.CustomViewAuthorInAuthorshipTimeline.DataIO.VisualizationImageLink vil = dataIO.GetGoogleTimeline(base.RDFTriple, "[Profile.Module].[NetworkAuthorshipTimeline.Concept.GetData]");
			timeline.Src = vil.src;
			timeline.Alt = vil.alt;
			litTimelineTable.Text = vil.asText;


			/* Reader returns multiple result sets in the following order
			 * 1) Cited publications
			 * 2) Newest publication
			 * 3) Oldest publications
			 */
			using (var reader = dataIO.GetConceptPublications(base.RDFTriple))
			{
				List<string> htmlList = new List<string>();
				StringBuilder html = null;
				int resultsetCnt = 0; 
				do
				{
					resultsetCnt++;
					html = new StringBuilder();
					while (reader.Read())
					{
						if(resultsetCnt==3)								// cited
							html.AppendFormat(@"
								<li>
								<div>{0}</div>
								<div class='viewIn'>View in: <a href='//www.ncbi.nlm.nih.gov/pubmed/{1}' target='_new'>PubMed</a></div>	
								<div>Cited: {2}</div>						
								</li>
							",
								reader["reference"].ToString(),
								reader["pmid"].ToString(),
								reader["n"].ToString()
							);
						else if(resultsetCnt==1 || resultsetCnt==2)		// newest and oldest
							html.AppendFormat(@"
								<li>
								<div>{0}</div>
								<div class='viewIn'>View in: <a href='//www.ncbi.nlm.nih.gov/pubmed/{1}' target='_new'>PubMed</a></div>							
								</li>
							", 
								reader["reference"].ToString(), 
								reader["pmid"].ToString()
							);
						
					}
					htmlList.Add(html.ToString());
					
				} while(reader.NextResult()); // Next resultset
				
				reader.Close();

				if(htmlList.Count==1)
				{
					ShowOtherPub = false;
					newest.Text = htmlList[0];
				}
				else
				{
					// For Catalyst site only until speed issue is resolved
					ShowOtherPub = true;
					newest.Text = htmlList[0];
					oldest.Text = htmlList[1];				
					cited.Text = htmlList[2];
				}
			}
		}

		public bool ShowOtherPub { get; set; }
		public string ConceptName { get; set; }
	}
}