<%@ Page Title="" Language="C#" MasterPageFile="~/Pages/SharedPages/MasterPage.Master" AutoEventWireup="true" CodeBehind="Shelf.aspx.cs" Inherits="MyShelf.Pages.Shelf" %>

<asp:Content ID="Shelf" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
   

    <%-- Om skapande/borttagning/ändring blir gjord uppdateras SuccessLabeln(session) till sitt resultatvärde. --%>
<%--    <div>
        <asp:Label CssClass="SuccessLabel" ID="SuccessLabel" runat="server" Text="Label" Visible="false"></asp:Label><br />
    </div>--%>


        <asp:ListView ID="PubListView" runat="server"
                    ItemType="MyShelf.Model.Publication"
                    SelectMethod="PubListView_GetData"
                    DataKeyNames="PubID"
                    InsertItemPosition="LastItem">
                <LayoutTemplate>
                    <div class="ShelfWrapper">
<%--                        <table>
                            <tr>--%>
                            <asp:PlaceHolder ID="itemPlaceholder" runat="server" />
<%--                            </tr>
                        </table>--%>
                    </div>
                </LayoutTemplate>
                    <ItemTemplate>
                    <%-- Mall för nya rader. --%>
                        <div class="ShelfImageWrapper">
                            <asp:Label CssClass="ShelfTitle" ID="Label1" runat="server" Text='<%#  Item.Title %>'></asp:Label>
                            <asp:Image CssClass="ShelfImages" ID="ShelfImages" runat="server" ImageUrl='<%#  "~/content/thumbnails/" + Item.Filename %>' />
                        </div>
                    </ItemTemplate>

                    <EmptyDataTemplate>

                    </EmptyDataTemplate>

                    <InsertItemTemplate>
                        <asp:PlaceHolder ID="PlaceHolder1" runat="server" Visible="false">
                            HEJ
                        </asp:PlaceHolder>
                    </InsertItemTemplate>

                    <EditItemTemplate>
                    </EditItemTemplate>

                </asp:ListView>

        <nav id="headmenu">
            <ul>
                <li><asp:HyperLink CssClass="Button" ID="HyperLink1" runat="server" NavigateUrl='<%$ RouteUrl:routename=Publish %>' /></li>
            </ul>
        </nav>


</asp:Content>
