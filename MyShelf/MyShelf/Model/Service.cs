using MyShelf.Model.DAL;
using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
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



        // Kombinerad uppdaterings och lägga till-metod för filmer med validering.
        public void Publish(Publication publication)
        {

            // Om objektet inte uppfyller affärsreglerna
            ICollection<ValidationResult> validationResults;
            if (!publication.Validate(out validationResults)) // Använder "extension method" för valideringen!
            {
                // Klassen finns under App_Infrastructure.
                // ...kastas ett undantag med ett allmänt felmeddelande samt en referens 
                // till samlingen med resultat av valideringen.
                var ex = new ValidationException("Objektet klarade inte valideringen.");
                ex.Data.Add("ValidationResults", validationResults);
                throw ex;
            }

            PubDAL.Publish(publication);
        }

    }
}