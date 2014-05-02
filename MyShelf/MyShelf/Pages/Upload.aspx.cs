using MyShelf.Model;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace MyShelf.Pages
{
    public partial class Upload : System.Web.UI.Page
    {
        private Gallery _gallery;               // Privat fält inget värde tilldelas.



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





        // Egenskap som returnerar det som _gallery refererar till ELLER instansierar ett nytt Gallery-objekt om den inte tidigare refererar till ett.
        private Gallery Gallery
        {
            get { return _gallery ?? (_gallery = new Gallery()); }
        }


        protected void Page_Load(object sender, EventArgs e)
        {
            //if (HasMessage)
            //{
            //    Uploadsuccess.Text = Message;
            //    Uploadsuccess.Visible = true;
            //}

            //var image = Request.QueryString["name"];
            //ImageControl.ImageUrl = "~/content/pictures/" + image;
        }


        protected void UploadButton_Click(object sender, EventArgs e)
        {
            if (IsValid)
            {
                if (FileUploadPic.HasFile)
                {
                    try
                    {
                        var stream = FileUploadPic.FileContent;
                        var filename = FileUploadPic.FileName;
                        Gallery save = new Gallery();

                        filename = save.SaveImage(stream, filename);
                        Uploadsuccess.Visible = true;


                        Message = String.Format("Bilden lades till.");
                        Response.Redirect("~/Pages/Shelf.aspx?name=" + filename);
                    }

                    catch (Exception ex)
                    {
                        ModelState.AddModelError(String.Empty, ex.Message);

                        //var customValidator = new CustomValidator
                        //{
                        //    ErrorMessage = ex.Message,
                        //    IsValid = false
                        //};
                        //Page.Validators.Add(customValidator);
                    }
                }
            }
        }


        public IEnumerable<string> ImageRepeater_GetData()
        {
            return Gallery.GetImageNames();
        }

    }
}