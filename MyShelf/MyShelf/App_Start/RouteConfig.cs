using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Routing;

namespace MyShelf
{
    public static class RouteConfig
    {
        public static void RegisterRoutes(RouteCollection routes)
        {

            routes.MapPageRoute("Shelf",
            "",
            "~/Pages/Shelf.aspx");

            routes.MapPageRoute("ImageHandling",
            "Image/{id}",
            "~/Pages/ImageHandling.aspx");

            //routes.MapPageRoute("Image",
            //    "Shelf/Image",
            //    "~/Pages/Image.aspx");



            //routes.MapPageRoute("GenreHandling",
            //    "Genre/Hantering",
            //    "~/Pages/MoviePages/GenreHandling.aspx");


            //routes.MapPageRoute("GenreCreator",
            //    "Genre/Hantering/Ny",
            //    "~/Pages/MoviePages/GenreCreator.aspx");

        }
    }
}