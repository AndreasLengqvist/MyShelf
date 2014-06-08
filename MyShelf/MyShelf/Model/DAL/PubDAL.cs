using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;

namespace MyShelf.Model.DAL
{
    public class PubDAL : DALBase
    {
        /// Hämtar alla publiceringar i databasen.
        public IEnumerable<Publication> Get_All_Pub()
        {
            // Skapar och initierar ett anslutningsobjekt.
            using (var conn = CreateConnection())
            {
                try
                {
                    // Skapar ett List-Objekt med plats för 100 referenser till ett Movie-Objekt.
                    var publications = new List<Publication>(100);

                    // Skapar ett SqlCommand-Objekt kontaktar vald lagrad procedur.
                    var cmd = new SqlCommand("appSchema.usp_Get_All_Pub", conn);
                    cmd.CommandType = CommandType.StoredProcedure;

                    // Öppnar anslutningen till databasen.
                    conn.Open();

                    // Eftersom den lagrade proceduren innehåller en SELECT-sats som retunerar flera poster så tas det om hand av
                    // ett SqlDataReader-Objekt. ExecuteReader-metoden skapar ett SqlDataReaderobjekt och retunerar en referens till objektet.
                    using (var reader = cmd.ExecuteReader())
                    {
                        // Eftersom det är effektivare att ta ut de olika indexerna för varje fält så görs detta innan man börjar hämta
                        // ut posterna. GetOrdinal gör så att det inte spelar någon roll vilken ordning de ligger i.
                        var pubIdIndex = reader.GetOrdinal("PubID");
                        var typeIdIndex = reader.GetOrdinal("TypeID");
                        var creatorIndex = reader.GetOrdinal("Creator");
                        var emailIndex = reader.GetOrdinal("Email");
                        var titleIndex = reader.GetOrdinal("Title");
                        var textfieldIndex = reader.GetOrdinal("Textfield");
                        var filenameIndex = reader.GetOrdinal("Filename");
                        var pubdateeIndex = reader.GetOrdinal("PubDate");
                        var typeIndex = reader.GetOrdinal("Type");


                        // Hämtar ut poster så länge det finns poster att hämta så kör while-loopen.
                        while (reader.Read())
                        {
                            // Hämtar ut data för en post med hjälp av vald Get-metod.
                            publications.Add(new Publication
                            {
                                PubID = reader.GetInt32(pubIdIndex),
                                TypeID = reader.GetInt32(typeIdIndex),
                                Creator = reader.GetString(creatorIndex),
                                Email = reader.GetString(emailIndex),
                                Title = reader.GetString(titleIndex),
                                Textfield = reader.GetString(textfieldIndex),
                                Filename = reader.GetString(filenameIndex),
                                PubDate = reader.GetDateTime(pubdateeIndex),
                                Type = reader.GetString(typeIndex)

                            });
                        }
                    }

                    // Trimmar ner List-Objektet så att det inte ligger extra minne (det är dessa jag väljer när jag deklarerar
                    // hur många referenser jag vill ha högst upp).
                    publications.TrimExcess();

                    // Returnerar publications där alla dess poster ligger.
                    return publications;
                }
                catch
                {
                    throw;
                    //throw new ApplicationException("An error occured while getting all publishes from the database.");
                }
            }
        }


        // Hämtar en specifik pub.
        public Publication Get_Spec_Pub(int pubID)
        {
            // Skapar och initierar ett anslutningsobjekt.
            using (SqlConnection conn = CreateConnection())
            {
                try
                {
                    // Skapar ett SqlCommand-Objekt kontaktar vald lagrad procedur.
                    SqlCommand cmd = new SqlCommand("appSchema.usp_Get_Spec_Pub", conn);
                    cmd.CommandType = CommandType.StoredProcedure;

                    // Lägger till IN-parametrarna till den lagrade proceduren. (Den slöa metoden)
                    cmd.Parameters.AddWithValue("@PubID", pubID);

                    // Öppnar anslutningen till databasen.
                    conn.Open();

                    // Eftersom den lagrade proceduren innehåller en SELECT-sats som retunerar flera poster så tas det om hand av
                    // ett SqlDataReader-Objekt. ExecuteReader-metoden skapar ett SqlDataReaderobjekt och retunerar en referens till objektet.
                    using (SqlDataReader reader = cmd.ExecuteReader())
                    {
                        // Om det finns poster att läsa, börja läsa.
                        if (reader.Read())
                        {
                            // Tar ut index för varje fält. GetOrdinal gör så att det inte spelar någon roll vilken ordning de ligger i.
                            var pubIdIndex = reader.GetOrdinal("PubID");
                            var typeIdIndex = reader.GetOrdinal("TypeID");
                            var creatorIndex = reader.GetOrdinal("Creator");
                            var emailIndex = reader.GetOrdinal("Email");
                            var titleIndex = reader.GetOrdinal("Title");
                            var textfieldIndex = reader.GetOrdinal("Textfield");
                            var filenameIndex = reader.GetOrdinal("Filename");
                            var pubdateeIndex = reader.GetOrdinal("PubDate");

                            // Returnerar referensen till de skapade Publication-objektet.
                            return new Publication
                            {
                                PubID = reader.GetInt32(pubIdIndex),
                                TypeID = reader.GetInt32(typeIdIndex),
                                Creator = reader.GetString(creatorIndex),
                                Email = reader.GetString(emailIndex),
                                Title = reader.GetString(titleIndex),
                                Textfield = reader.GetString(textfieldIndex),
                                Filename = reader.GetString(filenameIndex),
                                PubDate = reader.GetDateTime(pubdateeIndex),

                            };
                        }
                    }

                    return null;
                }
                catch
                {
                    throw;
                    //throw new ApplicationException("An error occured in the data access layer.");
                }
            }
        }

        // Publicerar och sparar ner en ny pub till databasen.
        public void Publish(Publication publication)
        {
            // Skapar och initierar ett anslutningsobjekt.
            using (SqlConnection conn = CreateConnection())
            {
                try
                {
                    // Skapar ett SqlCommand-Objekt kontaktar vald lagrad procedur.
                    SqlCommand cmd = new SqlCommand("usp_Publish", conn);
                    cmd.CommandType = CommandType.StoredProcedure;

                    // Lägger till IN-parametrarna till den lagrade proceduren. (Den slöa metoden)
                    cmd.Parameters.Add("@PubID", SqlDbType.Int, 4).Value = publication.PubID;
                    cmd.Parameters.Add("@TypeID", SqlDbType.Int).Value = publication.TypeID;
                    cmd.Parameters.Add("@Creator", SqlDbType.VarChar, 40).Value = publication.Creator;
                    cmd.Parameters.Add("@Email", SqlDbType.VarChar, 40).Value = publication.Email;
                    cmd.Parameters.Add("@Title", SqlDbType.VarChar, 40).Value = publication.Title;
                    cmd.Parameters.Add("@Textfield", SqlDbType.VarChar, 2000).Value = publication.Textfield;
                    cmd.Parameters.Add("@Filename", SqlDbType.VarChar, 200).Value = publication.Filename;


                    // Öppnar anslutningen till databasen.
                    conn.Open();

                    // Eftersom det är en INSERT-sats så behövs det inte retunera några poster. Därför använder jag ExecuteNonQuery.
                    cmd.ExecuteNonQuery();

                    // Hämtar primärnyckelns värde för den nya posten och tilldelar Publication-objektet värdet.
                    publication.PubID = (int)cmd.Parameters["@PubID"].Value;
                }
                catch
                {
                    // Kastar ett eget undantag om ett undantag kastas.
                    throw;
                    //throw new ApplicationException("An error occured in the data access layer.");
                }
            }
        }


        /// Uppdaterar en publicering.
        public void Edit_Pub(Publication publication)
        {
            // Skapar och initierar ett anslutningsobjekt.
            using (SqlConnection conn = CreateConnection())
            {
                try
                {
                    // Skapar ett SqlCommand-Objekt kontaktar vald lagrad procedur.
                    SqlCommand cmd = new SqlCommand("appSchema.usp_Edit_Pub", conn);
                    cmd.CommandType = CommandType.StoredProcedure;

                    // Lägger till IN-parametrarna till den lagrade proceduren. (Den slöa metoden)
                    cmd.Parameters.Add("@PubID", SqlDbType.Int, 4).Value = publication.PubID;
                    cmd.Parameters.Add("@TypeID", SqlDbType.Int).Value = publication.TypeID;
                    cmd.Parameters.Add("@Creator", SqlDbType.VarChar, 40).Value = publication.Creator;
                    cmd.Parameters.Add("@Email", SqlDbType.VarChar, 40).Value = publication.Email;
                    cmd.Parameters.Add("@Title", SqlDbType.VarChar, 40).Value = publication.Title;
                    cmd.Parameters.Add("@Textfield", SqlDbType.VarChar, 2000).Value = publication.Textfield;

                    // Öppnar anslutningen till databasen.
                    conn.Open();

                    // Eftersom det är en UPDATE-sats så behövs det inte retunera några poster. Därför använder jag ExecuteNonQuery.
                    cmd.ExecuteNonQuery();
                }
                catch
                {
                    throw new ApplicationException("An error occured in the data dataaccesslayer.");
                }
            }
        }

        /// Tar bort en publicering.
        public void Delete_Pub(int pubID)
        {
            // Skapar och initierar ett anslutningsobjekt.
            using (SqlConnection conn = CreateConnection())
            {
                try
                {
                    // Skapar ett SqlCommand-Objekt kontaktar vald lagrad procedur.
                    SqlCommand cmd = new SqlCommand("appSchema.usp_Delete_Pub", conn);
                    cmd.CommandType = CommandType.StoredProcedure;

                    // Lägger till IN-parametern till den lagrade proceduren.
                    cmd.Parameters.Add("@PubID", SqlDbType.Int, 4).Value = pubID;

                    // Öppnar anslutningen till databasen.
                    conn.Open();

                    // Eftersom det är en DELETE-sats så behövs det inte retunera några poster. Därför använder jag ExecuteNonQuery.
                    cmd.ExecuteNonQuery();
                }
                catch
                {
                    throw new ApplicationException("An error occured in the data access layer.");
                }
            }
        }
    }
}
    


    