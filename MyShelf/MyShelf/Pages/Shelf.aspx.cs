using MyShelf.Model;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Security.Cryptography;
using System.Web;
using System.Web.ModelBinding;
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
        PlaceHolder PlaceHolder_Admin;
        // Ett Service-objekt skapas med hjälp av Lazy initialization.
        private Service Service
        {
            get { return _service ?? (_service = new Service()); }
        }



        protected void Page_Load(object sender, EventArgs e)
        {
            bool admin = Convert.ToBoolean(Session["IsAdmin"]);

            if (admin == true)
            {
                LinkButton3.Visible = false;
                LinkButton7.Visible = true;
            }
            if (HasMessage)
            {
                SuccessLabel.Text = Message;
                SuccessLabel.Visible = true;
            }

        }


        /// Hämtar alla publikationer som finns lagrade i databasen.
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



        /// Lägger till en publikation i databasen.
        public void PubListView_InsertItem(Publication publication)
        {
            if (ModelState.IsValid)
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
                        Message = String.Format("New publication was added to the database.");
                        Response.Redirect("~/");
                    }
                }
                catch (Exception)
                {
                    ModelState.AddModelError(String.Empty, "Ett oväntat fel inträffade då verket skulle läggas till.");
                }
            }
        }

        protected void LinkButton2_Click(object sender, EventArgs e)
        {
            Response.Redirect("~/");
        }

        
        protected void Login1_Authenticate(object sender, AuthenticateEventArgs e)
        {
            
            string username = Login1.UserName;
            string password = Login1.Password;

            var salt = Service.GetSalt(username);

            var stringDataToHash = String.Format(password + salt);

            HashAlgorithm hashAlg = new SHA256CryptoServiceProvider();

            byte[] byteValue = System.Text.Encoding.UTF8.GetBytes(stringDataToHash);

            byte[] byteHash = hashAlg.ComputeHash(byteValue);

            string base64 = Convert.ToBase64String(byteHash);

            bool result = Service.UserLogin(username, base64);
            if ((result))
            {
                e.Authenticated = true;
                Session["IsAdmin"] = true;
                Message = String.Format("You are now logged in as admin.");
                Response.Redirect("~/");            
            }
            else
            {
                e.Authenticated = false;
            }
        }

        protected void LinkButton3_Click(object sender, EventArgs e)
        {
            PlaceHolder1.Visible = true;
            PubListView.FindControl("LinkButton2").Visible = false;
        }

        protected void LinkButton2_Click1(object sender, EventArgs e)
        {
            PubListView.InsertItem.FindControl("PlaceHolder2").Visible = true;
            PubListView.FindControl("LinkButton2").Visible = false;
        }

        protected void LinkButton9_Click1(object sender, EventArgs e)
        {
            PubListView.FindControl("LinkButton2").Visible = false;
        }

        protected void LinkButton7_Click(object sender, EventArgs e)
        {
            Session["IsAdmin"] = false;
            Message = String.Format("You are now not longer admin.");
            Response.Redirect("~/");            
        }


        // Tar ID:t från den valda publikationen och uppdaterar databaseninformationen till denna.
        public void PubListView_UpdateItem(int pubID)
        {
            if (ModelState.IsValid)
            {

                try
                {

                    var pub = Service.Get_Spec_Pub(pubID);
                    if (pub == null)
                    {
                        // Hittade inte kunden.
                        ModelState.AddModelError(String.Empty,
                            String.Format("The publication with PubID {0} doesn't exists.", pubID));
                        return;
                    }

                    if (TryUpdateModel(pub))
                    {
                        Service.Publish(pub);
                        Message = String.Format("Publication is up to date.");
                        Response.Redirect("~/");
                    }
                }
                catch (Exception)
                {
                    throw;
                }
            }
        }

        // Tar ID:t från den valda publikationen och tar bort denna från databasen.
        public void PubListView_DeleteItem(int PubID, string Filename)
        {
            try
            {
                Gallery delete = new Gallery();

                delete.DeleteImage(Filename);


                Service.Delete_Pub(PubID);
                Message = String.Format("The publication was deleted from the database");
                Response.Redirect("~/");
            }
            catch (Exception)
            {
                ModelState.AddModelError(String.Empty, "Ett oväntat fel inträffade då publiceringen skulle tas bort.");
            }
        }

        protected void PlaceHolder_Admin_Init(object sender, EventArgs e)
        {

            //Här Kollar jag om en admin är inloggad. Är admin inloggad så kommer det att finnas lite extra funktionalitet på sidan.
            bool admin = Convert.ToBoolean(Session["IsAdmin"]);

            if (admin == true)
            {
                PlaceHolder_Admin = (PlaceHolder)sender;
                PlaceHolder_Admin.Visible = true;
            }
            else
            {
                PlaceHolder_Admin = (PlaceHolder)sender;
                PlaceHolder_Admin.Visible = false;
            }
        }
    }
}
