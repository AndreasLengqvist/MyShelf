using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace MyShelf.Model
{
    public class Login
    {
        public int AdminID { get; set; }

        public string Username { get; set; }

        public string Password { get; set; }

        public string Salt { get; set; }

        public string Hash { get; set; }
    }
}