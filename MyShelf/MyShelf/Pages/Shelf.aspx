<%@ Page Title="" Language="C#" MasterPageFile="~/Pages/SharedPages/MasterPage.Master" AutoEventWireup="true" CodeBehind="Shelf.aspx.cs" Inherits="MyShelf.Pages.Shelf" %>

<asp:Content ID="Shelf" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
   

    <%-- Om skapande/borttagning/ändring blir gjord uppdateras SuccessLabeln(session) till sitt resultatvärde. --%>
    <div>
        <asp:Label CssClass="SuccessLabel" ID="SuccessLabel" runat="server" Text="Label" Visible="false"></asp:Label><br />
    </div>


        <asp:ListView ID="PubListView" runat="server"
                    ItemType="MyShelf.Model.Publication"
                    SelectMethod="PubListView_GetData"
                    DataKeyNames="PubID"
                    InsertItemPosition="LastItem">
                <LayoutTemplate>
                    <div class="page-wrap">
                        <table>
                            <tr>
                            <asp:PlaceHolder ID="itemPlaceholder" runat="server" />
                            </tr>
                        </table>
                    </div>
                </LayoutTemplate>
                    <ItemTemplate>
                    <%-- Mall för nya rader. --%>
                        <td>
                            <asp:Image CssClass="ShelfImage" ID="ShelfImages" runat="server" ImageUrl='<%#  "~/content/thumbnails/" + Item.Filename %>' />
                        </td>
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



</asp:Content>
