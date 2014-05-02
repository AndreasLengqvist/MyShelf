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

                    <%-- Platshållare för nya rader --%>
                        <asp:PlaceHolder ID="itemPlaceholder" runat="server" />
                </LayoutTemplate>
                    <ItemTemplate>
                    <%-- Mall för nya rader. --%>
                        <section class="movieposters">
                            
                            <h2>
                                <%#: Item.Creator %>
                            </h2>

                            <asp:Image ID="ShelfImage" runat="server" ImageUrl='<%#  "~/content/pictures/" + Item.Filename %>' />


                        </section>
                    </ItemTemplate>

                    <EmptyDataTemplate>
                        <%-- Detta visas då kunduppgifter saknas i databasen. --%>
                        <table class="grid">
                            <tr>
                                <td>
                                    Det finns inga filmer i databasen.
                                </td>
                            </tr>
                        </table>
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
                <li>
                    <asp:LinkButton CssClass="PublishButton" ID="LinkButton1" runat="server" OnClick="Button1_Click">Publish</asp:LinkButton>
                    <a class="PublishButton" href="3biljett.html">Publish</a>
                </li>
            </ul>
        </nav>

</asp:Content>
