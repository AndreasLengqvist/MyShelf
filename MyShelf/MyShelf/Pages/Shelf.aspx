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

                                <asp:ValidationSummary Cssclass="ErrorMessages" ID="ValidationSummary1" runat="server" HeaderText="Fel inträffade. Korrigera det som är fel och försök igen."/>

                                    <div class="Edit_Title_Field">
                                        <label class="edit_label" for="Title">Title</label>
                                        </div>
                                        <div class="Edit_Title_Field">
                                                <asp:TextBox Cssclass="TextBox" ID="Title" runat="server" Text='<%# BindItem.Title %>' MaxLength="40" />                        
                                                <asp:RequiredFieldValidator
                                                    Cssclass="ErrorMessages"
                                                    ID="RequiredFieldValidatorTitle" 
                                                    runat="server" 
                                                    ErrorMessage="En titel måste anges."
                                                    Text="*"
                                                    ControlToValidate="Title">
                                                </asp:RequiredFieldValidator>
                                        </div>
                                        <div class="Edit_Textfield_Field">
                                            <label class="edit_label" for="Textfield">Textfield</label>
                                                <asp:TextBox Cssclass="TextBoxTextfield" ID="Textfield" runat="server" Text='<%# BindItem.Textfield %>' MaxLength="2000" Rows="10"  TextMode="MultiLine" Columns="30" />
                                                <asp:RequiredFieldValidator 
                                                    Cssclass="ErrorMessages"
                                                    ID="RequiredFieldValidatorTextfield" 
                                                    runat="server" 
                                                    ErrorMessage="En text måste anges."
                                                    Text="*"
                                                    ControlToValidate="Textfield">
                                                </asp:RequiredFieldValidator>
                                        </div>

                                 <%-- Uploadfält med valideringskontrollrar. --%>
                                <div>
                                    <asp:FileUpload ID="FileUploadPic" runat="server"/>
                                    <asp:RequiredFieldValidator 
                                        Cssclass="ErrorMessages"
                                        ID="RequiredFieldValidator" 
                                        runat="server" 
                                        ErrorMessage="En bild måste väljas"
                                        Text="*"
                                        ControlToValidate="FileUploadPic"></asp:RequiredFieldValidator>
                                    <asp:RegularExpressionValidator 
                                        Cssclass="ErrorMessages"
                                        ID="RegularExpressionValidator" 
                                        runat="server" 
                                        ErrorMessage="Endast bilder av typerna gif, jpg eller png är tillåtna."
                                        ValidationExpression="^.*\.(gif|GIF|jpg|JPG|png|PNG)$" 
                                        ControlToValidate="FileUploadPic" 
                                        Text="*">
                                    </asp:RegularExpressionValidator>
                                </div>


                                        <div class="Edit_Dropdowns_Field">
                                            <label class="edit_label">Type:</label>
                                            <asp:DropDownList 
                                                ID="DropDownListType" 
                                                runat="server" 
                                                ItemType="MyShelf.Model.Types"
                                                DataTextField="Type"
                                                DataValueField="TypeID"
                                                SelectMethod="DropDownListType_GetData" 
                                                SelectedValue='<%# BindItem.TypeID %>'>
                                            </asp:DropDownList>


                                        <div class="Edit_Creator_Field">
                                            <label class="edit_label" for="Creator">Creator</label>
                                        </div>
                                        <div class="Edit_Creator_Field">
                                                <asp:TextBox Cssclass="TextBox_Creator" ID="Creator" runat="server" Text='<%# BindItem.Creator %>' MaxLength="25" />
                                                <asp:RequiredFieldValidator 
                                                    Cssclass="ErrorMessages"
                                                    ID="RequiredFieldValidatorCreator" 
                                                    runat="server" 
                                                    ErrorMessage="En skapare av verket måste anges."
                                                    Text="*"
                                                    ControlToValidate="Creator">
                                                </asp:RequiredFieldValidator>
                                        </div>

                                        </div>

                                        <div class="Edit_Email_Field">
                                            <label class="edit_label" for="Email">Email</label>
                                        </div>
                                        <div class="Edit_Email_Field">
                                                <asp:TextBox Cssclass="TextBox_Email" ID="Email" runat="server" Text='<%# BindItem.Email %>' MaxLength="30"/>
                                                <asp:RequiredFieldValidator 
                                                    Cssclass="ErrorMessages"
                                                    ID="RequiredFieldValidatorEmail" 
                                                    runat="server" 
                                                    ErrorMessage="En email måste anges."
                                                    Text="*"
                                                    ControlToValidate="Email">
                                                </asp:RequiredFieldValidator>
                                        </div>

                                        <nav id="headmenu">
                                            <ul>
                                                <li><a id="hideButton" class="back_Button"></a></li>
                                                <asp:LinkButton CssClass="links" ID="LinkButton1" runat="server" Text="Spara" CommandName="Insert" />
                                            </ul>
                                        </nav>

                            </section>
                        </div>
                    </InsertItemTemplate>

                    <EditItemTemplate>
                    </EditItemTemplate>

                </asp:ListView>


</asp:Content>
