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
using AjaxControlToolkit;

namespace Profiles.Profile.Modules.CustomViewPersonGeneralInfo
{
    public class DataIO : Profiles.Profile.Utilities.DataIO
    {
        public string GetMapData(string country)
        {
            string str = "";


            //           if (Framework.Utilities.Cache.FetchObject(request.Key + "GetPublicationByPMID") == null)
            //          {
            try
            {
                string connstr = ConfigurationManager.ConnectionStrings["ProfilesDB"].ConnectionString;
                SqlConnection dbconnection = new SqlConnection(connstr);
                SqlCommand dbcommand = new SqlCommand("[Profile.Data].[Organization.GetMapData]");

                SqlDataReader dbreader;
                dbconnection.Open();
                dbcommand.CommandType = CommandType.StoredProcedure;
                dbcommand.CommandTimeout = base.GetCommandTimeout();
                dbcommand.Parameters.Add(new SqlParameter("@country", country));

                dbcommand.Connection = dbconnection;
                dbreader = dbcommand.ExecuteReader(CommandBehavior.CloseConnection);

                while (dbreader.Read())
                    str = dbreader[0].ToString();

                //Framework.Utilities.DebugLogging.Log(str);

                if (!dbreader.IsClosed)
                    dbreader.Close();

                //                   Framework.Utilities.Cache.Set(request.Key + "GetJournalHeadingsForProfile", str);
            }
            catch (Exception ex)
            {
                Framework.Utilities.DebugLogging.Log(ex.Message + " ++ " + ex.StackTrace);
            }
            //           }
            //           else
            //           {
            //               str = (string)Framework.Utilities.Cache.FetchObject(request.Key + "GetJournalHeadingsForProfile");
            //           }

            return str;
        }
    }
}
