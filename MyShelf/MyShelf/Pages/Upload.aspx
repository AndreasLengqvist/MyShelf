<%@ Page Title="" Language="C#" MasterPageFile="~/Pages/SharedPages/MasterPage.Master" AutoEventWireup="true" CodeBehind="Upload.aspx.cs" Inherits="MyShelf.Pages.Upload" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">



    <%-- Valideringssummering för felmeddelanden. --%>
    <div>
        <asp:ValidationSummary class="ErrorMessages" ID="ValidationSummary" runat="server" HeaderText="Fel inträffade. Korrigera felet och försök igen." />
    </div>


    <%-- Uploadfält med valideringskontrollrar. --%>
    <div>
        <asp:FileUpload ID="FileUploadPic" runat="server"/>
        <asp:Label ID="Uploadsuccess" runat="server" Text="" Visible="false"></asp:Label>
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
            ErrorMessage="Endast bilder av typerna gif, jpeg eller png är tillåtna."
            ValidationExpression="^.*\.(gif|jpg|png)$" 
            ControlToValidate="FileUploadPic" 
            Text="*">
        </asp:RegularExpressionValidator>
    </div>

    <div>
        <%-- Upload-knapp som startar uppladdningen. --%>
        <asp:Button ID="UploadButton" runat="server" Text="Ladda upp" OnClick="UploadButton_Click" />
    </div>


</asp:Content>
