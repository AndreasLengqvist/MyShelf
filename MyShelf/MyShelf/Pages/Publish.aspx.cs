using MyShelf.Model;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace MyShelf.Pages
{
    public partial class Publish : System.Web.UI.Page
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



        private Gallery _gallery;               // Privat fält inget värde tilldelas.
        private Service _service;               // Privat fält inget värde tilldelas.

        // Ett Service-objekt skapas med hjälp av Lazy initialization.
        private Service Service
        {
            get { return _service ?? (_service = new Service()); }
        }



        // Egenskap som returnerar det som _gallery refererar till ELLER instansierar ett nytt Gallery-objekt om den inte tidigare refererar till ett.
        private Gallery Gallery
        {
            get { return _gallery ?? (_gallery = new Gallery()); }
        }






        /// Lägger till en film i databasen.
        public void PublishFormView_InsertItem(Publication publication)
        {
            try
            {
                FileUpload FileUploader = (FileUpload)PublishFormView.FindControl("FileUploadPic");
                if (FileUploader.HasFile)
                {
                    var stream = FileUploader.FileContent;
                    var filename = FileUploader.FileName;
                    Gallery save = new Gallery();

                    filename = save.SaveImage(stream, filename);

                    publication.Filename = filename;


                    Service.Publish(publication);
                    Message = String.Format("Nytt verk lades till i databasen.");
                    Response.Redirect("~/");
                }
            }
            catch (Exception)
            {
                throw;
                //ModelState.AddModelError(String.Empty, "Ett oväntat fel inträffade då verket skulle läggas till.");
            }
        }
    }
}