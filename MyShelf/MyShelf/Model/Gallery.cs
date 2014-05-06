using System;
using System.Collections.Generic;
using System.Drawing;
using System.IO;
using System.Linq;
using System.Text.RegularExpressions;
using System.Web;

namespace MyShelf.Model
{
    public class Gallery
    {
        private static Regex ApprovedExenstions;                // "Readonly", Undersöker om en fil har en tillåten ändelse. Init i den statiska konstruktorn.
        private static string PhysicalUploadedImagesPath;       // Innehåller den fysiska sökvägen till katalogen där de uppladdade bilder sparas.
        private static string PhysicalUploadedThumbnailsPath;   // Innehåller den fysiska sökvägen till katalogen där de uppladdade tumbnagelbilderna sparas.
        private static Regex SantizePath;                       // "Readonly", Ser till så att filnamnet innehåller godkända tecken.



        // Returnerar en referens av typen IEnumerable<string> till ett List-objekt innehållande bildernas filnamn sorterade i 
        // bokstavsordning. Klassen DirectoryInfo med metoden GetFiles är användbar. Det kan vara en god idé att se till att bara filer 
        // med filändelserna gif, jpg och png finns i listan.
        public IEnumerable<string> GetImageNames()
        {
            var di = new DirectoryInfo((PhysicalUploadedImagesPath));

            return (from fi in di.GetFiles()
                    where ApprovedExenstions.IsMatch(fi.Name)
                    orderby (fi.Name)
                    select fi.Name
                    ).AsEnumerable();
        }


        // En statisk metod som returnerar true om en bild med angivet namn finns katalogen för uppladdade bilder; annars false.
        public static bool ImageExists(string filename)
        {
            return File.Exists(Path.Combine(PhysicalUploadedImagesPath + filename));
        }

        //Returnerar true om den uppladdade filens innehåll verkligen är av typen gif, jpeg eller png.
        public static bool IsValidImage(Image image)
        {
            return image.RawFormat.Guid == System.Drawing.Imaging.ImageFormat.Gif.Guid ||
                    image.RawFormat.Guid == System.Drawing.Imaging.ImageFormat.Jpeg.Guid ||
                    image.RawFormat.Guid == System.Drawing.Imaging.ImageFormat.Png.Guid;
        }

        // Verifierar att filen är av rätt MIME-typ (annars kastas ett undantag), säkerställer att filnamnet är unik, 
        // sparar bilden samt skapar och sparar en tumnagelbild. Filnamnet bilden sparas under returneras.
        public string SaveImage(Stream stream, string filename)
        {

            var image = System.Drawing.Image.FromStream(stream); // stream -> ström med bild

            if (IsValidImage(image))
            {
                int i = 1;

                    var filenameonly = Path.GetFileNameWithoutExtension(filename);
                    var extension = Path.GetExtension(filename);


                    // Sålänge filnamnet finns Do.. efter det spara ner bilden.
                    do
                    {
                        filename = String.Format("{0}({1}){2}", filenameonly, i, extension);
                        i += 1;
                    }
                    while (ImageExists(filename));

                image.Save(Path.Combine(PhysicalUploadedImagesPath + filename));
                var thumbnail = image.GetThumbnailImage(100, 150, null, System.IntPtr.Zero);
                thumbnail.Save(Path.Combine(PhysicalUploadedThumbnailsPath + filename)); // path -> fullständig fysisk filnamn inklusive sökväg.

                i = 0;
                return filename;
            }
            else
            {
                throw new ArgumentException("Filnamnet har felaktig ändelse.");
            }


        }


        static Gallery()
        {
            ApprovedExenstions = new Regex(@"^.*\.(gif|jpg|png)$");
            PhysicalUploadedImagesPath = Path.Combine(AppDomain.CurrentDomain.GetData("APPBASE").ToString(), @"C:\Users\Irene Lenqvist\Documents\GitHub\MyShelf\MyShelf\MyShelf\content");
            PhysicalUploadedThumbnailsPath = Path.Combine(AppDomain.CurrentDomain.GetData("APPBASE").ToString(), @"C:\Users\Irene Lenqvist\Documents\GitHub\MyShelf\MyShelf\MyShelf\content");

            var invalidChars = new string(Path.GetInvalidFileNameChars());
            SantizePath = new Regex(string.Format("[{0}]", Regex.Escape(invalidChars)));
        }

    }
}