using MyShelf.Model.DAL;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace MyShelf.Model
{

    // Anropas av Presentationslogiklagret (code-behind) och anropar i sin tur Dataåtkomstlagret efter att viss validering gjorts.
    public class Service
    {

        private PubDAL _pubDAL;


        // Ett PubDAL-objekt skapas med hjälp av Lazy initialization.
        private PubDAL PubDAL
        {
            get { return _pubDAL ?? (_pubDAL = new PubDAL()); }
        }




        // Hämtar alla filmer som finns lagrade i databasen.
        public IEnumerable<Publication> Get_All_Pub()
        {
            return PubDAL.Get_All_Pub();
        }

    }
}