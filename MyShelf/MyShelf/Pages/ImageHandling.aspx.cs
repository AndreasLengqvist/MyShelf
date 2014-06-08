using MyShelf.Model;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.ModelBinding;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace MyShelf.Pages
{
    public partial class ImageHandling : System.Web.UI.Page
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



        private Service _service;

        // Ett Service-objekt skapas med hjälp av Lazy initialization.
        private Service Service
        {
            get { return _service ?? (_service = new Service()); }
        }


        // Tar ID:t från den valda publikationen och hämtar databaseninformationen från denna.
        public MyShelf.Model.Publication PubFormView_GetItem([RouteData]int id)
        {
            try
            {
                return Service.Get_Spec_Pub(id);
            }
            catch (Exception)
            {
                throw;
                //ModelState.AddModelError(String.Empty, "Fel inträffade då publikationen hämtades ut.");
            }
        }

        protected void BackButton2_Click(object sender, EventArgs e)
        {
            Response.Redirect("~/");
        }
    }
}