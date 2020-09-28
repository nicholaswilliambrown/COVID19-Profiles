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

namespace Profiles.Profile.Modules.NetworkDetails
{
    public class DataIO : Profiles.Profile.Utilities.DataIO
    {
        public List<NetworkDetailsRow> GetPersonConceptDetails(long nodeID)
        {
            List<NetworkDetailsRow> rows = new List<NetworkDetailsRow>();


                try
                {
                    string connstr = ConfigurationManager.ConnectionStrings["ProfilesDB"].ConnectionString;
                    SqlConnection dbconnection = new SqlConnection(connstr);
                    SqlCommand dbcommand = new SqlCommand("[Profile.Module].[NetworkDetails.Person.GetData]");

                    SqlDataReader dbreader;
                    dbconnection.Open();
                    dbcommand.CommandType = CommandType.StoredProcedure;
                    dbcommand.CommandTimeout = base.GetCommandTimeout();
                    dbcommand.Parameters.Add(new SqlParameter("@nodeid", nodeID));

                    dbcommand.Connection = dbconnection;
                    dbreader = dbcommand.ExecuteReader(CommandBehavior.CloseConnection);

                    while (dbreader.Read())
                    {
                    rows.Add(new NetworkDetailsRow(
                    dbreader.GetString(dbreader.GetOrdinal("MeshHEader")),
                    dbreader.GetInt32(dbreader.GetOrdinal("NumPubsThis")),
                    dbreader.GetInt32(dbreader.GetOrdinal("NumPubsAll")),
                    (int)dbreader.GetDouble(dbreader.GetOrdinal("LastPublicationYear")),
                    dbreader.GetDouble(dbreader.GetOrdinal("Weight")),
                    dbreader.GetInt64(dbreader.GetOrdinal("NodeID")))) ;
                    }

                    if (!dbreader.IsClosed)
                        dbreader.Close();

                }
                catch (Exception ex)
                {
                    Framework.Utilities.DebugLogging.Log(ex.Message + " ++ " + ex.StackTrace);
                }

            return rows;
        }

        public class NetworkDetailsRow
        {
            public NetworkDetailsRow(string name, int numPubsThis, int numPubsAll, int lastPublicationsYear, double weight, long nodeID)
            {
                this.Name = name;
                this.NumPubsThis = numPubsThis;
                this.NumPubsAll = numPubsAll;
                this.LastPublicationYear = lastPublicationsYear;
                this.Weight = weight;
                this.NodeID = nodeID;
            }

            public string Name { get; set; }
            public int NumPubsThis { get; set; }
            public int NumPubsAll { get; set; }
            public int LastPublicationYear { get; set; }
            public double Weight { get; set; }
            public long NodeID { get; set; }
        }

    }
}
