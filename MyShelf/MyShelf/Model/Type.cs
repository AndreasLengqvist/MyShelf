using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace MyShelf.Model
{
    /// Klass för hantering av genreuppgifter.
    public class Types
    {
        // Egenskapernas namn och typ ges av tabellen Type i databasen.

        public int TypeID { get; set; }

        public string Type { get; set; }
    }
}