using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Web;

namespace MyShelf.Model
{
    /// Klass för hantering av filmuppgifter.
    public class Publication
    {
        // Egenskapernas namn och typ ges av tabellen Pub i databasen.

        public int PubID { get; set; }

        public int TypeID { get; set; }

        public string Creator { get; set; }

        public string Email { get; set; }

        public string Title { get; set; }

        public string Textfield { get; set; }

        public string Filename { get; set; }

        public DateTime PubDate { get; set; }

        public string Type { get; set; }
    }
}