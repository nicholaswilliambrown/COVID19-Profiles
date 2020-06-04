using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Xml;

namespace Profiles.Search.Utilities
{
    public class DataIOMap : Framework.Utilities.DataIO
    {

        public XmlDocument SearchRequest(string country)
        {
            XmlDocument rtn = new XmlDocument();
            rtn.LoadXml(string.Format("<SearchOptions><MatchOptions><SearchString ExactMatch=\"false\">Coronavirus</SearchString><SearchFiltersList><SearchFilter IsExclude=\"0\" Property=\"http://vivoweb.org/ontology/core#mailingAddress\" Property2 =\"http://vivoweb.org/ontology/core#address3\" MatchType=\"Exact\">{0}</SearchFilter></SearchFiltersList><ClassURI>http://xmlns.com/foaf/0.1/Person</ClassURI></MatchOptions><OutputOptions><Offset>0</Offset><Limit>15</Limit><SortByList></SortByList></OutputOptions></SearchOptions>", country));
            return rtn;
        }
        public List<CountryViz> GetCountryCounts()
        {
            List<CountryViz> cv = new List<CountryViz>();

            try
            {
                string connstr = base.GetConnectionString();

                SqlConnection dbconnection = new SqlConnection(connstr);
                SqlCommand dbcommand = new SqlCommand();

                dbconnection.Open();
                dbcommand.CommandType = CommandType.StoredProcedure;

                dbcommand.CommandText = "[Profile.Data].[Person.GetCountries]";
                dbcommand.CommandTimeout = base.GetCommandTimeout();

                dbcommand.Connection = dbconnection;




                using (SqlDataReader dbreader = dbcommand.ExecuteReader(CommandBehavior.CloseConnection))
                {

                    while (dbreader.Read())
                    {
                        cv.Add(new CountryViz { Country = dbreader[0].ToString(), Count = dbreader[1].ToString() });
                    }

                    if (!dbreader.IsClosed) dbreader.Close();

                }

            }
            catch (Exception e)
            {
                Framework.Utilities.DebugLogging.Log(e.Message + " " + e.StackTrace);
                throw new Exception(e.Message);
            }

            return cv;

        }
        public List<TopResearchers> GetTopGeoResearchers()
        {

            List<TopResearchers> tr = new List<TopResearchers>();

            try
            {
                string connstr = base.GetConnectionString();

                SqlConnection dbconnection = new SqlConnection(connstr);
                SqlCommand dbcommand = new SqlCommand();

                dbconnection.Open();
                dbcommand.CommandType = CommandType.StoredProcedure;

                dbcommand.CommandText = "[Profile.Data].[Person.GetTopResearchers]";
                dbcommand.CommandTimeout = base.GetCommandTimeout();

                dbcommand.Connection = dbconnection;




                using (SqlDataReader dbreader = dbcommand.ExecuteReader(CommandBehavior.CloseConnection))
                {

                    while (dbreader.Read())
                    {
                        tr.Add(new TopResearchers { Name = dbreader["DisplayName"].ToString(), Country = dbreader["Country"].ToString(), URI = dbreader["NodeID"].ToString() });
                    }

                    if (!dbreader.IsClosed) dbreader.Close();

                }

            }
            catch (Exception e)
            {
                Framework.Utilities.DebugLogging.Log(e.Message + " " + e.StackTrace);
                throw new Exception(e.Message);
            }

            return tr;

        }
    }
}