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
            // Rot till startsidan.
            routes.MapPageRoute("Shelf",
            "",
            "~/Pages/Shelf.aspx");

            // Rot till bildsidan med unikt id.
            routes.MapPageRoute("ImageHandling",
            "Image/{id}",
            "~/Pages/ImageHandling.aspx");

        }
    }
}