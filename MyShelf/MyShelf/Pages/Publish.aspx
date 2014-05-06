<%@ Page Title="" Language="C#" MasterPageFile="~/Pages/SharedPages/MasterPage.Master" AutoEventWireup="true" CodeBehind="Publish.aspx.cs" Inherits="MyShelf.Pages.Publish" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">



      <h1>Publish.</h1>


    <%-- FormView för att lägga till en ny film. --%>
     <asp:FormView ID="PublishFormView" runat="server"
                ItemType="MyShelf.Model.Publication"
                DefaultMode="Insert"
                RenderOuterTable="false"
                InsertMethod="PublishFormView_InsertItem">

                <%-- InsertItemTemplate binder det som man skriver in när man trycker på Spara. Varje TextBox innehåller validering. --%>
                <InsertItemTemplate>

                <section class="Publish_Wrapper">

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
                                    <asp:TextBox Cssclass="TextBoxTextfield" ID="Textfield" runat="server" Text='<%# BindItem.Textfield %>' MaxLength="2000" Rows="10"  TextMode="MultiLine" Columns="72" />
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


<%--                            <div class="Edit_Dropdowns_Field">
                                <label class="edit_label">Type:</label>
                                <asp:DropDownList 
                                    ID="DropDownListGenre" 
                                    runat="server" 
                                    ItemType="MyShelf.Model.Type"
                                    DataTextField="Type"
                                    DataValueField="TypeID"
                                    SelectMethod="DropDownListGenre_GetData" 
                                    SelectedValue='<%# BindItem.TypeID %>'>
                                </asp:DropDownList>
                            </div>--%>


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

                            <div class="Edit_TypeID_Field">
                                <label class="edit_label" for="TypeID">Creator</label>
                            </div>
                            <div class="Edit_Creator_Field">
                                    <asp:TextBox Cssclass="TextBox_TypeID" ID="TypeID" runat="server" Text='<%# BindItem.TypeID %>' MaxLength="25" />
                                    <asp:RequiredFieldValidator 
                                        Cssclass="ErrorMessages"
                                        ID="RequiredFieldValidatorTypeID" 
                                        runat="server" 
                                        ErrorMessage="En skapare av verket måste anges."
                                        Text="*"
                                        ControlToValidate="TypeID">
                                    </asp:RequiredFieldValidator>
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


                            <div>
                                <asp:LinkButton CssClass="links" ID="LinkButton1" runat="server" Text="Spara" CommandName="Insert" />
                            </div>

                </section>
                </InsertItemTemplate>
    </asp:FormView>

</asp:Content>
