using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.Configuration;
using System.Web.UI.WebControls;

namespace MyShelf.Model.DAL
{
    public class AdminDAL : DALBase
    {

        private Login _login;
        private Login Login
        {
            get { return _login ?? (_login = new Login()); }
        }



        public bool UserLogin(string username, string password)
        {

            using (SqlConnection connection = CreateConnection())
            {
                SqlCommand cmd = new SqlCommand("appSchema.AdminLogin", connection);
                cmd.CommandType = CommandType.StoredProcedure;

                // Skickar in lösenord och anvnamn i den lagrade proceduren.
                cmd.Parameters.Add("@Username", SqlDbType.VarChar).Value = username;
                cmd.Parameters.Add("@Hash", SqlDbType.VarChar).Value = password;

                connection.Open();

                string result = Convert.ToString(cmd.ExecuteScalar());

                if (string.IsNullOrEmpty(result))
                {
                    //Om lösenordet är fel returnera falskt
                    return false;
                }
                else
                {
                    // annars true
                    return true;
                }
            }
        }

        public string GetSalt(string username)
        {
            using (SqlConnection conn = CreateConnection())
            {
                try
                {
                    SqlCommand cmd = new SqlCommand("appSchema.GetSalt", conn);
                    cmd.CommandType = CommandType.StoredProcedure;

                    cmd.Parameters.AddWithValue("@UserName", username);

                    conn.Open();

                    using (SqlDataReader reader = cmd.ExecuteReader())
                    {
                        if (reader.Read())
                        {
                            var salt = reader.GetOrdinal("Salt");

                            string hej = reader.GetString(salt);
                            Login.Salt = hej;

                            return hej;

                        }
                        return null;

                    }
                }
                catch
                {
                    throw new ApplicationException("Ett fel inträffade i dataåtkomstlagret");
                }
            }
        }
    }
}