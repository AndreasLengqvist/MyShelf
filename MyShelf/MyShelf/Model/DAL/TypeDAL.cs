using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;

namespace MyShelf.Model.DAL
{
    public class TypeDAL : DALBase
    {


        // Hämtar alla typer.
        public IEnumerable<Types> Get_All_Types()
        {
            // Skapar och initierar ett anslutningsobjekt.
            using (var conn = CreateConnection())
            {
                try
                {
                    // Skapar ett List-Objekt med plats för 100 referenser till ett Genre-Objekt.
                    var types = new List<Types>(100);

                    // Skapar ett SqlCommand-Objekt kontaktar vald lagrad procedur.
                    var cmd = new SqlCommand("appSchema.usp_Get_All_Types", conn);
                    cmd.CommandType = CommandType.StoredProcedure;

                    // Öppnar anslutningen till databasen.
                    conn.Open();

                    // Eftersom den lagrade proceduren innehåller en SELECT-sats som retunerar flera poster så tas det om hand av
                    // ett SqlDataReader-Objekt. ExecuteReader-metoden skapar ett SqlDataReaderobjekt och retunerar en referens till objektet.
                    using (var reader = cmd.ExecuteReader())
                    {
                        // Eftersom det är effektivare att ta ut de olika indexerna för varje fält så görs detta innan man börjar hämta
                        // ut posterna. GetOrdinal gör så att det inte spelar någon roll vilken ordning de ligger i.
                        var typeIdIndex = reader.GetOrdinal("TypeID");
                        var typeIndex = reader.GetOrdinal("Type");


                        // Hämtar ut poster så länge det finns poster att hämta så kör while-loopen.
                        while (reader.Read())
                        {
                            // Hämtar ut data för en post med hjälp av vald Get-metod.
                            types.Add(new Types
                            {
                                TypeID = reader.GetInt32(typeIdIndex),
                                Type = reader.GetString(typeIndex),

                            });
                        }
                    }

                    // Trimmar ner List-Objektet så att det inte ligger extra minne (det är dessa jag väljer när jag deklarerar
                    // hur många referenser jag vill ha högst upp).
                    types.TrimExcess();

                    // Returnerar types där alla dess poster ligger.
                    return types;
                }
                catch
                {
                    throw new ApplicationException("An error occured while getting types from the database.");
                }
            }
        }
    }
}