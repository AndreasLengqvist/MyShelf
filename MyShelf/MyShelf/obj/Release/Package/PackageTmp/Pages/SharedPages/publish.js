
var Namespace ={

    init: function () {


        var showbutton = document.getElementById("showButton");
        var hidebutton = document.getElementById("hideButton");

        showbutton.onclick = function () {
            var diven = document.getElementById("publishPopUp");
            diven.className = "showBlur";
            showbutton.style.display = "none";

            var images = document.querySelectorAll(".ShelfImageWrapper");
            for (var i = 0; i < images.length; i++) {
                    images[i].className = 'blur';
            }
        }

        hidebutton.onclick = function () {
            var diven = document.getElementById("publishPopUp");
            diven.className = "hideBlur";
            showbutton.style.display = "block";


            var images = document.querySelectorAll(".blur");
            for (var i = 0; i < images.length; i++) {
                images[i].className = 'ShelfImageWrapper';
            }
        }
    }



}
window.onload = Namespace.init;