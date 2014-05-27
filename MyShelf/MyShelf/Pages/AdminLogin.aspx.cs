using MyShelf.Model;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Security.Cryptography;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace MyShelf.Pages
{
    public partial class AdminLogin : System.Web.UI.Page
    {

        private Service _service;

        // Ett Service-objekt skapas med hjälp av Lazy initialization.
        private Service Service
        {
            get { return _service ?? (_service = new Service()); }
        }

        protected void Page_Load(object sender, EventArgs e)
        {

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

            //Kolla länken sedan
            //http://stackoverflow.com/questions/4329909/hashing-passwords-with-md5-or-sha-256-c-sharp


            bool result = Service.UserLogin(username, base64);
            if ((result))
            {
                e.Authenticated = true;
                Session["IsAdmin"] = true;
                Response.Redirect("~/");            
            }
            else
            {
                e.Authenticated = false;
            }
        }
    }
}