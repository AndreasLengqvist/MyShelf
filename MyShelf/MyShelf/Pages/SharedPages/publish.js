
var Namespace ={

    init: function () {


        var showbutton = document.querySelector(".publish_Button");
        var hidebutton = document.getElementById("hideButton");

        // Om Publiceringsknappen inte finns så blurra allt.
        if (showbutton == null) {
            var images = document.querySelectorAll(".ShelfImageWrapper");
            for (var i = 0; i < images.length; i++) {
                images[i].className = 'blur';
            }

        }

        showbutton.onclick = function () {

            showbutton.style.display = "none";

            var images = document.querySelectorAll(".ShelfImageWrapper");
            for (var i = 0; i < images.length; i++) {
                images[i].className = 'blur';
            }
        }
    }



}
window.onload = Namespace.init;