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
using System.Xml;
using Profiles.Framework.Utilities;

namespace Profiles.Framework.Modules.TopText
{
    /// <summary>
    /// This module is used to test a presentation XML for proper module placement.
    /// </summary>
    public partial class TopText : BaseModule
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            Activity.Utilities.DataIO data = new Activity.Utilities.DataIO();
            lblNumOfProfiles.Text = data.GetProfilesCount().ToString();
            lblNumOfPublications.Text = data.GetCovidPublicationCount().ToString();
        }
        public TopText() { }
        public TopText(XmlDocument pagedata, List<ModuleParams> moduleparams, XmlNamespaceManager pagenamespaces)
            : base(pagedata, moduleparams, pagenamespaces) { }
    }
}