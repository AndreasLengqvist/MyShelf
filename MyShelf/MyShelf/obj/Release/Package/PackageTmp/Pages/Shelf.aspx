<%@ Page Title="" Language="C#" MasterPageFile="~/Pages/SharedPages/MasterPage.Master" AutoEventWireup="true" CodeBehind="Shelf.aspx.cs" Inherits="MyShelf.Pages.Shelf" %>

<asp:Content ID="Shelf" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
   
        <div class="floor">

    <%-- Om skapande/borttagning/ändring blir gjord uppdateras SuccessLabeln(session) till sitt resultatvärde. --%>
    <div>
        <asp:Label CssClass="SuccessLabel" ID="SuccessLabel" runat="server" Text="Label" Visible="false"></asp:Label><br />
    </div>

            <asp:PlaceHolder ID="PlaceHolder1" runat="server" Visible="false">
                <div class="BlurryContent"></div>
                    <section class="LoginContent">
                        <h3>Administration Login</h3>
                        <asp:Login ID="Login1" runat="server" OnAuthenticate="Login1_Authenticate">
                            <LayoutTemplate>
                                <asp:TextBox Placeholder="Username" ID="UserName" runat="server" CssClass="username" />
                                <asp:RequiredFieldValidator
                                    Cssclass="ErrorMessage_Username"
                                    ID="RequiredFieldValidatorUsername" 
                                    runat="server" 
                                    Text="You need to enter a username"
                                    ControlToValidate="UserName">
                                </asp:RequiredFieldValidator>
                                <asp:TextBox Placeholder="Password" ID="Password" runat="server" CssClass="password" TextMode="Password" />
                                <asp:RequiredFieldValidator
                                    Cssclass="ErrorMessage_Password"
                                    ID="RequiredFieldValidatorPassword" 
                                    runat="server" 
                                    Text="You need to enter a password"
                                    ControlToValidate="Password">
                                </asp:RequiredFieldValidator>
                                <nav class="Login_menu">
                                    <ul>
                                        <li><asp:LinkButton ToolTip="Click to login" CssClass="login_Button" ID="LinkButton4" runat="server" CommandName="Login"/></li>
                                    </ul>
                                </nav>
                            </LayoutTemplate>
                        </asp:Login>
                    </section>
            <nav class="Back_menu">
                <ul>
                    <li><asp:LinkButton ToolTip="Return to the site" CssClass="back_Button" ID="LinkButton2" runat="server" OnClick="LinkButton2_Click" CausesValidation="false" /></li>
                </ul>
            </nav>
            </asp:PlaceHolder>

            <nav>
                <ul>
                    <li><a id="facebookbutton" title="Head to our Facebook" class="facebook"></a></li>
                        <li><asp:LinkButton ToolTip="Login" CssClass="login" ID="LinkButton3" runat="server" OnClick="LinkButton3_Click" CausesValidation="false" /></li>
                        <li><asp:LinkButton ToolTip="Logout" CssClass="logoff" Visible="false" ID="LinkButton7" runat="server" OnClick="LinkButton7_Click" CausesValidation="false"/></li>
                </ul>
            </nav>

        <asp:ListView ID="PubListView" runat="server"
                    ItemType="MyShelf.Model.Publication"
                    SelectMethod="PubListView_GetData"
                    InsertMethod="PubListView_InsertItem"
                    UpdateMethod="PubListView_UpdateItem"
                    DeleteMethod="PubListView_DeleteItem"
                    DataKeyNames="PubID, Filename"
                    InsertItemPosition="FirstItem">
                <LayoutTemplate>
                                                    <asp:Image Cssclass="logo" ID="Image1" runat="server" ImageUrl="SharedPages/logo.png" />

                        <div class="ShelfWrapper">
                                <asp:PlaceHolder ID="itemPlaceholder" runat="server" />
                        </div>

                    <nav id="headmenu">
                        <ul>
                            <li><asp:LinkButton ToolTip="Click here get to the form for publishing" CssClass="publish_Button" ID="LinkButton2" runat="server" CausesValidation="false" OnClick="LinkButton2_Click1"/></li>
                        </ul>
                    </nav>

                </LayoutTemplate>
                <ItemTemplate>
                        <div class="ShelfImageWrapper">
                            <asp:PlaceHolder ID="PlaceHolder_Admin" runat="server" OnInit="PlaceHolder_Admin_Init">
                                <div class="admin-content">   
                                    <asp:LinkButton ToolTip="Delete this publication" ID="LinkButton1" CssClass="admin_del" runat="server" CommandName="Delete" Text="Delete" CausesValidation="false" OnClientClick='<%# String.Format("return confirm(\"Confirm if you want to delete {0}?\")", Item.Title) %>' />
                                    <asp:LinkButton ToolTip="Edit this publication" ID="LinkButton9" CssClass="admin_edit" runat="server" CommandName="Edit" Text="Edit" CausesValidation="false" OnClick="LinkButton9_Click1"/>
                                </div> 
                            </asp:PlaceHolder>

                            <asp:HyperLink ToolTip="Click on the image to get to the imagesite" CssClass="ShelfLinks" ID="HyperLink1" runat="server" NavigateUrl='<%# GetRouteUrl("ImageHandling", new {id = Item.PubID}) %>' >
                                <span class="text-content">
                                    <asp:Label CssClass="ShelfTitle" ID="Label2" runat="server" Text='<%#  Item.Title %>'></asp:Label>
                                </span>
                                <asp:Image CssClass="ShelfImages" ID="ShelfImages" runat="server" ImageUrl='<%#  "~/content/thumbnails/" + Item.Filename %>' />
                            </asp:HyperLink>

                        </div>
                </ItemTemplate>

                    <EmptyDataTemplate>

                    </EmptyDataTemplate>

                    <InsertItemTemplate>
                        <asp:PlaceHolder ID="PlaceHolder2" runat="server" Visible="false">
                            <div class="BlurryContent"></div>
                            <section class="PublishContent">
                                <h1>Publish</h1>


                            <div class="first_div">
                                <div class="filediv">
                                    <label class="infolabel">Choose file to upload:</label><br />
                                    <asp:FileUpload ToolTip="Click here to choose a file" CssClass="uploadfile" ID="FileUploadPic" runat="server"/>
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

                                <div class="typediv">
                                    <label class="infolabel">What are you uploading?</label><br />
                                    <asp:DropDownList 
                                        CssClass="TypeList"
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

                                <fieldset><legend>Publication</legend>
<%--                                <asp:ValidationSummary Cssclass="ErrorMessages" ID="ValidationSummary1" runat="server" HeaderText="Fel inträffade. Korrigera det som är fel och försök igen."/>--%>
                                        <div class="Title_Field">
                                                <asp:TextBox ToolTip="Enter the title here" PlaceHolder="What's the title?" Cssclass="textbox" ID="Title"  runat="server" Text='<%# BindItem.Title %>' MaxLength="20" />                        
                                                <asp:RequiredFieldValidator
                                                    Cssclass="ErrorMessage_Title"
                                                    ID="RequiredFieldValidatorTitle" 
                                                    runat="server" 
                                                    Text="You need to enter a title"
                                                    ControlToValidate="Title">
                                                </asp:RequiredFieldValidator>
                                        </div>

                                        <div class="Edit_Textfield_Field">
                                            <asp:TextBox ToolTip="Enter the story here" PlaceHolder="What's the story?" Cssclass="textarea" ID="Textfield"  runat="server" Text='<%# BindItem.Textfield %>' MaxLength="500"  TextMode="MultiLine" />
                                            <asp:RequiredFieldValidator 
                                                    Cssclass="ErrorMessage_Textfield"
                                                    ID="RequiredFieldValidatorTextfield" 
                                                    runat="server" 
                                                    Text="Please, write something about your publication"
                                                    ControlToValidate="Textfield">
                                                </asp:RequiredFieldValidator>
                                        </div>
                                    </fieldset>
                               

                                <fieldset><legend>Creator</legend>
                                        <div class="Edit_Creator_Field">
                                                <asp:TextBox ToolTip="Enter the creator here" PlaceHolder="Who is the creator?" Cssclass="textbox" ID="Creator"  runat="server" Text='<%# BindItem.Creator %>' MaxLength="20" />
                                                <asp:RequiredFieldValidator 
                                                    Cssclass="ErrorMessage_Creator"
                                                    ID="RequiredFieldValidatorCreator" 
                                                    runat="server" 
                                                    Text="Please, enter a creator"
                                                    ControlToValidate="Creator">
                                                </asp:RequiredFieldValidator>
                                        </div>

                                       

                                        <div class="Edit_Email_Field">
                                                <asp:TextBox ToolTip="Enter your email here" PlaceHolder="What's your email?" Cssclass="textbox" ID="Email" runat="server" Text='<%# BindItem.Email %>' MaxLength="30" TextMode="Email" />
                                                <asp:RequiredFieldValidator 
                                                    Cssclass="ErrorMessage_Email"
                                                    ID="RequiredFieldValidatorEmail" 
                                                    runat="server" 
                                                    Text="Please, enter a email"
                                                    ControlToValidate="Email">
                                                </asp:RequiredFieldValidator>
                                        </div>
                                    </fieldset>
                                        <nav id="headmenu">
                                            <ul>
                                                <li><asp:LinkButton ToolTip="Return to the site" CssClass="back_Button" ID="LinkButton2" runat="server" OnClick="LinkButton2_Click" CausesValidation="false" /></li>
                                                <li><asp:LinkButton  ToolTip="Click here to publish" CssClass="real_publish_Button" ID="LinkButton1" runat="server" CommandName="Insert" /></li>
                                            </ul>
                                        </nav>

                            </section>
                    </asp:PlaceHolder>
                    </InsertItemTemplate>

                    <EditItemTemplate>

                            <div class="BlurryContent"></div>
                            <section class="PublishContent">
                                <h1>Edit</h1>


                                <fieldset><legend>Edit publication</legend>
                                        <div class="Title_Field">
                                                <asp:TextBox ToolTip="Change the title here" PlaceHolder="Enter a title" Cssclass="textbox" ID="Title"  runat="server" Text='<%# BindItem.Title %>' MaxLength="20" />                        
                                                <asp:RequiredFieldValidator
                                                    Cssclass="ErrorMessage_Title"
                                                    ID="RequiredFieldValidatorTitle" 
                                                    runat="server" 
                                                    Text="You need to enter a title"
                                                    ControlToValidate="Title">
                                                </asp:RequiredFieldValidator>
                                        </div>

                                        <div class="Edit_Textfield_Field">
                                            <asp:TextBox ToolTip="Change the story here" PlaceHolder="Enter a story" Cssclass="textarea" ID="Textfield"  runat="server" Text='<%# BindItem.Textfield %>' MaxLength="500"  TextMode="MultiLine" />
                                            <asp:RequiredFieldValidator 
                                                    Cssclass="ErrorMessage_Textfield"
                                                    ID="RequiredFieldValidatorTextfield" 
                                                    runat="server" 
                                                    Text="Please, write something about your publication"
                                                    ControlToValidate="Textfield">
                                                </asp:RequiredFieldValidator>
                                        </div>
                                    </fieldset>
                                


                                <fieldset><legend>Edit creator</legend>
                                        <div class="Edit_Creator_Field">
                                            <asp:TextBox ToolTip="Change the creator here" PlaceHolder="Enter a creator" Cssclass="textbox" ID="Creator"  runat="server" Text='<%# BindItem.Creator %>' MaxLength="20" />
                                                <asp:RequiredFieldValidator 
                                                    Cssclass="ErrorMessage_Creator"
                                                    ID="RequiredFieldValidatorCreator" 
                                                    runat="server" 
                                                    Text="Please, enter  a creator"
                                                    ControlToValidate="Creator">
                                                </asp:RequiredFieldValidator>
                                        </div>

                                       

                                        <div class="Edit_Email_Field">
                                            <asp:TextBox ToolTip="Change the email here" PlaceHolder="Enter a email" Cssclass="textbox" ID="Email" runat="server" Text='<%# BindItem.Email %>' MaxLength="30" TextMode="Email" />
                                                <asp:RequiredFieldValidator 
                                                    Cssclass="ErrorMessage_Email"
                                                    ID="RequiredFieldValidatorEmail" 
                                                    runat="server" 
                                                    Text="Please, enter  a email"
                                                    ControlToValidate="Email">
                                                </asp:RequiredFieldValidator>
                                        </div>
                                    </fieldset>
                                        <nav id="headmenu">
                                            <ul>
                                                <li><asp:LinkButton ToolTip="Return to the site" CssClass="back_Button" ID="LinkButton2" runat="server" OnClick="LinkButton2_Click" CausesValidation="false" /></li>
                                                <li><asp:LinkButton ToolTip="Click here to save your changes" CssClass="save_Button" ID="LinkButton1" runat="server" CommandName="Update" /></li>
                                            </ul>
                                        </nav>

                            </section>

                    </EditItemTemplate>

                </asp:ListView>

            </div>
</asp:Content>
