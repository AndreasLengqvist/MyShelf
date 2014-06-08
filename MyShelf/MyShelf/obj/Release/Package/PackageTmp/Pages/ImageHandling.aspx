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
                    <div><asp:Label ID="Label1" CssClass="title_image" runat="server" Text='<%# Item.Title %>'></asp:Label></div>
                    <p><asp:Label ID="Label2" CssClass="story_image" runat="server" Text='<%# Item.Textfield %>'></asp:Label></p>
                    <asp:Label ID="Label5" CssClass="creator_image" runat="server" Text='<%# Item.Creator %>'></asp:Label>
                    <asp:Label ID="Label3" CssClass="uploaded_image" runat="server" Text='<%# Item.PubDate %>'></asp:Label>
                </div>
                    <asp:Image CssClass="Image" ID="ShelfImages" runat="server" ImageUrl='<%#  "~/content/pictures/" + Item.Filename %>' />
                </div>
            </ItemTemplate>


    </asp:FormView>

    <nav id="headmenu">
        <ul>
            <li><asp:LinkButton ToolTip="Return to the site" CssClass="back_Button" ID="BackButton2" runat="server" OnClick="BackButton2_Click" CausesValidation="false" /></li>
        </ul>
    </nav>
</asp:Content>