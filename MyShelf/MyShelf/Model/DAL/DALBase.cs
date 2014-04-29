using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.Configuration;

namespace MyShelf.Model.DAL
{
    public class DALBase
    {

        private static string _connectionString;    // Anslutningssträng som används för att ansluta till databasen.


        // Bas-konstruktorn som anropas först, innan någon av de unika DALarna anropas. Hämtar ut anslutningssträngen från web.config.
        static DALBase()
        {
            _connectionString = WebConfigurationManager.ConnectionStrings["ContactConnectionString"].ConnectionString;
        }


        // Skapar ett nytt anslutningsobjekt och retunerar detta.
        protected SqlConnection CreateConnection()
        {
            return new SqlConnection(_connectionString);
        }
    }
}