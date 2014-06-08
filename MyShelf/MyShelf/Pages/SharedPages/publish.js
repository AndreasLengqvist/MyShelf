
var Namespace ={

    init: function () {


        var showbutton = document.querySelector(".publish_Button");

        // Om Publiceringsknappen inte finns så blurra allt.
        if (showbutton == null) {
            var logo = document.getElementById("ContentPlaceHolder1_PubListView_Image1");
            var login = document.getElementById("ContentPlaceHolder1_LinkButton3");
            var logoff = document.getElementById("ContentPlaceHolder1_LinkButton7");
            var facebook = document.getElementById("facebookbutton");

            logo.className = 'logoblur';
            facebook.className = 'facebookblur';

            if (login == null) {
                logoff.className = 'logoffblur';
            }
            if (logoff == null) {
                login.className = 'loginblur';
            }

            var images = document.querySelectorAll(".ShelfImageWrapper");




            for (var i = 0; i < images.length; i++) {
                images[i].className = 'blur';
            
            }
        }

    }

}
window.onload = Namespace.init;