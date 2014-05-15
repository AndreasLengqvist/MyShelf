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


        private Service _service;
        private Gallery _gallery;

        // Ett Service-objekt skapas med hjälp av Lazy initialization.
        private Service Service
        {
            get { return _service ?? (_service = new Service()); }
        }



        protected void Page_Load(object sender, EventArgs e)
        {
            if (HasMessage)
            {
                SuccessLabel.Text = Message;
                SuccessLabel.Visible = true;
            }
        }


        /// Hämtar alla filmer som finns lagrade i databasen.
        public IEnumerable<Publication> PubListView_GetData()
        {
            return Service.Get_All_Pub();
        }





        // Egenskap som returnerar det som _gallery refererar till ELLER instansierar ett nytt Gallery-objekt om den inte tidigare refererar till ett.
        private Gallery Gallery
        {
            get { return _gallery ?? (_gallery = new Gallery()); }
        }


        public IEnumerable<Types> DropDownListType_GetData()
        {
            try
            {
                return Service.Get_All_Types();
            }
            catch (Exception)
            {
                ModelState.AddModelError(String.Empty, "Fel inträffade då typerna hämtades ut.");
                return null;
            }
        }



        /// Lägger till en film i databasen.
        public void PubListView_InsertItem(Publication publication)
        {
            try
            {
                FileUpload FileUploader = (FileUpload)PubListView.InsertItem.FindControl("FileUploadPic");
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
                ModelState.AddModelError(String.Empty, "Ett oväntat fel inträffade då verket skulle läggas till.");
            }
        }

        //protected void showButton_Click(object sender, EventArgs e)
        //{
        //    PubListView.InsertItemPosition = InsertItemPosition.LastItem;

        //}

        //protected void hideButton_Click(object sender, EventArgs e)
        //{
        //    PubListView.InsertItem.FindControl("showInsert").Visible = false;
        //}
        }
    }
