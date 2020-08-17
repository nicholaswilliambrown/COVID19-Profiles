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

namespace Profiles.Profile.Modules.NetworkCoauthorList
{
    public class DataIO : Profiles.Profile.Utilities.DataIO
    {
        public string GetNetworkCoauthorList(RDFTriple request)
        {
            string str = string.Empty;


            if (Framework.Utilities.Cache.FetchObject(request.Key + "GetNetworkCoauthorList") == null)
            {
                try
                {
                    string connstr = ConfigurationManager.ConnectionStrings["ProfilesDB"].ConnectionString;
                    SqlConnection dbconnection = new SqlConnection(connstr);
                    SqlCommand dbcommand = new SqlCommand("[Profile.Module].[NetworkCoauthorList.GetCoauthors]");

                    SqlDataReader dbreader;
                    dbconnection.Open();
                    dbcommand.CommandType = CommandType.StoredProcedure;
                    dbcommand.CommandTimeout = base.GetCommandTimeout();
                    dbcommand.Parameters.Add(new SqlParameter("@nodeid", request.Subject));
                    //dbcommand.Parameters.Add(new SqlParameter("@sessionid", request.Session.SessionID));

                    dbcommand.Connection = dbconnection;
                    dbreader = dbcommand.ExecuteReader(CommandBehavior.CloseConnection);
                    str = "<table class=\"NetworkList\"  ><tbody><tr><td style=\"padding - right:25px; width: 320px\"><ul style=\"columns: 2; -webkit-columns: 2; -moz-columns: 2; list - style - type:disc\">";
                    while (dbreader.Read())
                        str += "<li><a href=\"" + dbreader[1].ToString() + "\">" + dbreader[0].ToString() + "</a></li>";

                    str = str + "</ul></td></tr></tbody></table>";
                    Framework.Utilities.DebugLogging.Log(str);

                    if (!dbreader.IsClosed)
                        dbreader.Close();


                    Framework.Utilities.Cache.Set(request.Key + "GetNetworkCoauthorList", str);
                }
                catch (Exception ex)
                {
                    Framework.Utilities.DebugLogging.Log(ex.Message + " ++ " + ex.StackTrace);
                }
            }
            else
            {
                str = (string)Framework.Utilities.Cache.FetchObject(request.Key + "GetNetworkCoauthorList");
            }

            return str;
        }


    }
}
