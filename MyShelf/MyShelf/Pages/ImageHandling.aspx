<%@ Page Title="" Language="C#" MasterPageFile="~/Pages/SharedPages/MasterPage.Master" AutoEventWireup="true" CodeBehind="ImageHandling.aspx.cs" Inherits="MyShelf.Pages.ImageHandling" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">


    <asp:FormView ID="PubFormView" runat="server"
        ItemType="MyShelf.Model.Publication"
        DataKeyNames="PubID"
        RenderOuterTable="false"
        SelectMethod="PubFormView_GetItem">
            <ItemTemplate>
                <div class="ImageSite">
                <div class="ImageInfo">
                    <asp:Label ID="Label1" runat="server" Text='<%# Item.Title %>'></asp:Label>
                    <asp:Label ID="Label2" runat="server" Text='<%# Item.Textfield %>'></asp:Label>
                    <asp:Label ID="Label3" runat="server" Text='<%# Item.PubDate %>'></asp:Label>
                </div>
                    <asp:Image CssClass="Image" ID="ShelfImages" runat="server" ImageUrl='<%#  "~/content/pictures/" + Item.Filename %>' />
                </div>
            </ItemTemplate>


    </asp:FormView>

    <nav id="headmenu">
        <ul>
            <li><asp:LinkButton CssClass="back_Button2" ID="BackButton2" runat="server" OnClick="BackButton2_Click" CausesValidation="false" /></li>
        </ul>
    </nav>
</asp:Content>