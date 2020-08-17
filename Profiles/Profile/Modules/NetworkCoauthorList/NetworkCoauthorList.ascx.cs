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
using System.Linq;
using System.Web.UI.WebControls;
using System.Xml;
using System.Xml.Xsl;

using Profiles.Framework.Utilities;
using Profiles.Profile.Modules.NetworkCoauthorList;

namespace Profiles.Framework.Modules.NetworkCoauthorList
{
    public partial class NetworkCoauthorList : BaseModule
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            DrawProfilesModule();
        }
        public NetworkCoauthorList() { }
        public NetworkCoauthorList(XmlDocument pagedata, List<ModuleParams> moduleparams, XmlNamespaceManager pagenamespaces)
            : base(pagedata, moduleparams, pagenamespaces)
        {

        }

        public void DrawProfilesModule()
        {
            Profiles.Profile.Modules.NetworkCoauthorList.DataIO data = new Profiles.Profile.Modules.NetworkCoauthorList.DataIO();
            //GetNetworkCoauthorList
            litListView.Text = data.GetNetworkCoauthorList(new RDFTriple(Convert.ToInt64(Request.QueryString["Subject"])));

        }


    }

}