/*  
 
    Copyright (c) 2008-2011 by the President and Fellows of Harvard College. All rights reserved.  
    Profiles Research Networking Software was developed under the supervision of Griffin M Weber, MD, PhD.,
    and Harvard Catalyst: The Harvard Clinical and Translational Science Center, with support from the 
    National Center for Research Resources and Harvard University.


    Code licensed under a BSD License. 
    For details, see: LICENSE.txt 
  
*/
using System;
using System.Collections.Generic;
using System.Collections;
using System.Data;
using System.Web;
using System.Net;
using System.IO;
using System.Text;

using System.Data.SqlClient;
using System.Xml;
using System.Configuration;


using Profiles.Framework.Utilities;

namespace Profiles.Profile.Modules.CustomViewAuthorInAuthorshipTimeline
{
    public class DataIO : Profiles.Profile.Utilities.DataIO
    {
        public VisualizationImageLink GetGoogleTimeline(RDFTriple request, string storedproc)
        {
            VisualizationImageLink vil;

            if (Framework.Utilities.Cache.FetchObject(request.Key + "GetGoogleTimeline" + storedproc) == null)
            {
                SessionManagement sm = new SessionManagement();
                string connstr = ConfigurationManager.ConnectionStrings["ProfilesDB"].ConnectionString;
                var db = new SqlConnection(connstr);

                db.Open();

                SqlCommand dbcommand = new SqlCommand(storedproc, db);
                dbcommand.CommandType = CommandType.StoredProcedure;
                dbcommand.CommandTimeout = base.GetCommandTimeout();
                // Add parameters
                dbcommand.Parameters.Add(new SqlParameter("@NodeId", request.Subject));

                using (SqlDataReader reader = dbcommand.ExecuteReader(CommandBehavior.CloseConnection))
                {
                    reader.Read();
                    vil = new VisualizationImageLink(reader["gc"].ToString(), reader["alt"].ToString(), reader["asText"].ToString());
                    Framework.Utilities.Cache.Set(request.Key + "GetGoogleTimeline" + storedproc, vil);
                    reader.Close();
                }
            }
            else
            {
                vil = (VisualizationImageLink)Framework.Utilities.Cache.FetchObject(request.Key + "GetGoogleTimeline" + storedproc);
            }

            return vil;
        }


        public VisualizationImageLink GetGoogleTimelineCOVID(RDFTriple request, string storedproc)
        {
            VisualizationImageLink vil;

            if (Framework.Utilities.Cache.FetchObject(request.Key + "GetGoogleTimelineCOVID" + storedproc) == null)
            {
                SessionManagement sm = new SessionManagement();
                string connstr = ConfigurationManager.ConnectionStrings["ProfilesDB"].ConnectionString;
                var db = new SqlConnection(connstr);

                db.Open();

                SqlCommand dbcommand = new SqlCommand(storedproc, db);
                dbcommand.CommandType = CommandType.StoredProcedure;
                dbcommand.CommandTimeout = base.GetCommandTimeout();
                // Add parameters
                dbcommand.Parameters.Add(new SqlParameter("@NodeId", request.Subject));
                dbcommand.Parameters.Add(new SqlParameter("@GraphType", "COVID"));
                using (SqlDataReader reader = dbcommand.ExecuteReader(CommandBehavior.CloseConnection))
                {
                    reader.Read();
                    vil = new VisualizationImageLink(reader["gc"].ToString(), reader["alt"].ToString(), reader["asText"].ToString());
                    Framework.Utilities.Cache.Set(request.Key + "GetGoogleTimelineCOVID" + storedproc, vil);
                    reader.Close();
                }
            }
            else
            {
                vil = (VisualizationImageLink)Framework.Utilities.Cache.FetchObject(request.Key + "GetGoogleTimelineCOVID" + storedproc);
            }

            return vil;
        }

        public class VisualizationImageLink
        {
            public VisualizationImageLink(string src, string alt, string asText)
            {
                this.src = src;
                this.alt = alt;
                this.asText = asText;
            }

            public string src { get; set; }
            public string alt { get; set; }
            public string asText { get; set; }
        }

    }
}
