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


        // Kontaktas när en admin vill logga in.
        public bool UserLogin(string username, string password)
        {

            using (SqlConnection connection = CreateConnection())
            {
                SqlCommand cmd = new SqlCommand("appSchema.usp_AdminLogin", connection);
                cmd.CommandType = CommandType.StoredProcedure;

                // Skickar in lösenord och användarnamn i den lagrade proceduren.
                cmd.Parameters.Add("@Username", SqlDbType.VarChar).Value = username;
                cmd.Parameters.Add("@Hash", SqlDbType.VarChar).Value = password;

                connection.Open();

                string result = Convert.ToString(cmd.ExecuteScalar());

                if (string.IsNullOrEmpty(result))
                {
                    return false;
                }
                else
                {
                    return true;
                }
            }
        }

        // Hämtar salt för att kunna göra en kryptering av lösenordet.
        public string GetSalt(string username)
        {
            using (SqlConnection conn = CreateConnection())
            {
                try
                {
                    SqlCommand cmd = new SqlCommand("appSchema.usp_GetSalt", conn);
                    cmd.CommandType = CommandType.StoredProcedure;

                    cmd.Parameters.AddWithValue("@UserName", username);

                    conn.Open();

                    using (SqlDataReader reader = cmd.ExecuteReader())
                    {
                        if (reader.Read())
                        {
                            var salt = reader.GetOrdinal("Salt");

                            string SaltasString = reader.GetString(salt);
                            Login.Salt = SaltasString;

                            return SaltasString;

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