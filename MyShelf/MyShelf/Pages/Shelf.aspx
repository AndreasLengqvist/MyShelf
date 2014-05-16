<%@ Page Title="" Language="C#" MasterPageFile="~/Pages/SharedPages/MasterPage.Master" AutoEventWireup="true" CodeBehind="Shelf.aspx.cs" Inherits="MyShelf.Pages.Shelf" %>

<asp:Content ID="Shelf" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
   

    <%-- Om skapande/borttagning/ändring blir gjord uppdateras SuccessLabeln(session) till sitt resultatvärde. --%>
    <div>
        <asp:Label CssClass="SuccessLabel" ID="SuccessLabel" runat="server" Text="Label" Visible="false"></asp:Label><br />
    </div>


        <asp:ListView ID="PubListView" runat="server"
                    ItemType="MyShelf.Model.Publication"
                    SelectMethod="PubListView_GetData"
                    InsertMethod="PubListView_InsertItem"
                    DataKeyNames="PubID"
                    InsertItemPosition="FirstItem">
                <LayoutTemplate>
                        <div class="ShelfWrapper">
                                <asp:PlaceHolder ID="itemPlaceholder" runat="server" />
                        </div>

                    <nav id="headmenu">
                        <ul>
                            <li><a id="showButton" class="publish_Button"></a></li>
                        </ul>
                    </nav>

                </LayoutTemplate>
                <ItemTemplate>
                <%-- Mall för nya rader. --%>
                        <div class="ShelfImageWrapper">
<%--                            <asp:Label CssClass="ShelfTitle" ID="Label1" runat="server" Text='<%#  Item.Title %>'></asp:Label>--%>
                            <asp:Image CssClass="ShelfImages" ID="ShelfImages" runat="server" ImageUrl='<%#  "~/content/thumbnails/" + Item.Filename %>' />
                        </div>

                    </ItemTemplate>

                    <EmptyDataTemplate>

                    </EmptyDataTemplate>

                    <InsertItemTemplate>
                        <div class="hideBlur" id="publishPopUp">
                            <div class="BlurryContent"></div>
                            <section class="PublishContent">
                                <h1>Publish</h1>

<%--                                <asp:ValidationSummary Cssclass="ErrorMessages" ID="ValidationSummary1" runat="server" HeaderText="Fel inträffade. Korrigera det som är fel och försök igen."/>--%>

                                        <div class="Title_Field">
                                                <asp:TextBox placeholder="Enter a title" Cssclass="textbox" ID="Title"  runat="server" Text='<%# BindItem.Title %>' MaxLength="40" />                        
                                                <asp:RequiredFieldValidator
                                                    Cssclass="ErrorMessage_Title"
                                                    ID="RequiredFieldValidatorTitle" 
                                                    runat="server" 
                                                    Text="You need to enter a title"
                                                    ControlToValidate="Title">
                                                </asp:RequiredFieldValidator>
                                        </div>

                                        <div class="Edit_Textfield_Field">
                                            <asp:TextBox placeholder="Enter a story" Cssclass="textarea" ID="Textfield"  runat="server" Text='<%# BindItem.Textfield %>' MaxLength="2000" TextMode="MultiLine" />
                                            <asp:RequiredFieldValidator 
                                                    Cssclass="ErrorMessage_Textfield"
                                                    ID="RequiredFieldValidatorTextfield" 
                                                    runat="server" 
                                                    Text="Please, write something about your publication"
                                                    ControlToValidate="Textfield">
                                                </asp:RequiredFieldValidator>
                                        </div>

                                <div class="wrapuploads"><legend>Upload</legend>

                                 <%-- Uploadfält med valideringskontrollrar. --%>
                                <div>
                                    <label class="infolabel">Choose file to upload:</label>
                                    <asp:FileUpload CssClass="uploadfile" ID="FileUploadPic" runat="server"/>
                                    <asp:RequiredFieldValidator 
                                        Cssclass="ErrorMessage_Upload"
                                        ID="RequiredFieldValidator" 
                                        runat="server" 
                                        Text="You must choose a file to upload!"
                                        ControlToValidate="FileUploadPic"></asp:RequiredFieldValidator>
                                    <asp:RegularExpressionValidator 
                                        Cssclass="ErrorMessages"
                                        ID="RegularExpressionValidator" 
                                        runat="server" 
                                        ValidationExpression="^.*\.(gif|GIF|jpg|JPG|png|PNG)$" 
                                        ControlToValidate="FileUploadPic" 
                                        Text="This filetype cannot be uploaded">
                                    </asp:RegularExpressionValidator>
                                </div>

                                <div class="Edit_Dropdowns_Field">
                                    <label class="infolabel">Choose type of upload:</label>
                                    <asp:DropDownList 
                                        ID="DropDownListType" 
                                        runat="server" 
                                        ItemType="MyShelf.Model.Types"
                                        DataTextField="Type"
                                        DataValueField="TypeID"
                                        SelectMethod="DropDownListType_GetData" 
                                        SelectedValue='<%# BindItem.TypeID %>'>
                                    </asp:DropDownList>
                                </div>

                            </div>
                                    


                                    <fieldset><legend>Creator</legend>

                                        <div class="Edit_Creator_Field">
                                                <asp:TextBox placeholder="Who is the creator?" Cssclass="textbox" ID="Creator"  runat="server" Text='<%# BindItem.Creator %>' MaxLength="25" />
                                                <asp:RequiredFieldValidator 
                                                    Cssclass="ErrorMessage_Creator"
                                                    ID="RequiredFieldValidatorCreator" 
                                                    runat="server" 
                                                    Text="You must enter a creator"
                                                    ControlToValidate="Creator">
                                                </asp:RequiredFieldValidator>
                                        </div>

                                       

                                        <div class="Edit_Email_Field">
                                                <asp:TextBox placeholder="What is your email?" Cssclass="textbox" ID="Email" runat="server" Text='<%# BindItem.Email %>' MaxLength="30"/>
                                                <asp:RequiredFieldValidator 
                                                    Cssclass="ErrorMessage_Email"
                                                    ID="RequiredFieldValidatorEmail" 
                                                    runat="server" 
                                                    Text="You must enter a email"
                                                    ControlToValidate="Email">
                                                </asp:RequiredFieldValidator>
                                        </div>
                                    </fieldset>
                                        <nav id="headmenu">
                                            <ul>
                                                <li><asp:LinkButton CssClass="back_Button" ID="LinkButton2" runat="server" OnClick="LinkButton2_Click" CausesValidation="false" /></li>
                                                <li><asp:LinkButton CssClass="realpublish_Button" ID="LinkButton1" runat="server" CommandName="Insert" /></li>
                                            </ul>
                                        </nav>

                            </section>
                        </div>
                    </InsertItemTemplate>

                    <EditItemTemplate>
                    </EditItemTemplate>

                </asp:ListView>


</asp:Content>
