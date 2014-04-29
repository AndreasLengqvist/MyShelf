using MyShelf.Model;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace MyShelf.Pages
{
    public partial class Shelf : System.Web.UI.Page
    {

        // Sessionsvariabel konstruktion. Om HasMessage så visas sessionsvariabeln, annars inte. Message sätts när uppladdningen lyckas.    
        private bool HasMessage
        {
            get
            {
                return Session["Message"] != null;
            }
        }

        private string Message
        {
            get
            {
                var Message = Session["Message"] as string;
                Session.Remove("Message");
                return Message;
            }

            set
            {
                Session["Message"] = value;
            }
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            //if (HasMessage)
            //{
            //    SuccessLabel.Text = Message;
            //    SuccessPlaceHolder.Visible = true;
            //}
        }


        private Service _service;

        // Ett Service-objekt skapas med hjälp av Lazy initialization.
        private Service Service
        {
            get { return _service ?? (_service = new Service()); }
        }


        /// Hämtar alla filmer som finns lagrade i databasen.
        public IEnumerable<Publication> PubListView_GetData()
        {
            return Service.Get_All_Pub();
        }
    }
}