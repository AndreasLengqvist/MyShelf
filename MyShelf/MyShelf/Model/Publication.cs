using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Web;

namespace MyShelf.Model
{
    /// Klass för hantering av pubuppgifter.
    public class Publication
    {
        // Egenskapernas namn och typ ges av tabellen Pub i databasen.

        public int PubID { get; set; }

        public int TypeID { get; set; }

        [Required(ErrorMessage = "You need to enter a creator.")]
        [StringLength(20, ErrorMessage = "Too many letters.")]
        public string Creator { get; set; }

        [Required(ErrorMessage = "You need to enter a email.")]
        [StringLength(30, ErrorMessage = "Too many letters.")]
        public string Email { get; set; }

        [Required(ErrorMessage = "You need to enter a title.")]
        [StringLength(20, ErrorMessage = "Too many letters.")]
        public string Title { get; set; }

        [Required(ErrorMessage = "You need to enter a story.")]
        [StringLength(500, ErrorMessage = "Too many letters.")]
        public string Textfield { get; set; }

        public string Filename { get; set; }

        public DateTime PubDate { get; set; }

        public string Type { get; set; }
    }
}