<%@ Page Title="<%$ Resources: UI, pages_admin_useredit_title %>" Language="C#" MasterPageFile="~/Pages/Site.Master" AutoEventWireup="true" CodeBehind="UserEdit.aspx.cs" Inherits="Altairis.Sewen.Wiki.Pages.Admin.UserEdit" %>
<asp:Content ContentPlaceHolderID="MainCPH" runat="server">
    <article>
        <header>
            <h1>
                <asp:Localize runat="server" Text="<%$ Resources: UI, pages_admin_useredit_title %>" />
            </h1>
        </header>
        <div>
            <p>
                <asp:Label runat="server" Text="<%$ Resources: UI, pages_admin_useredit_label_text_0000 %>" AssociatedControlID="EmailTextBox" />
                <asp:RequiredFieldValidator runat="server" ControlToValidate="EmailTextBox" Display="Dynamic" Text="*" ErrorMessage="<%$ Resources: UI, pages_admin_useredit_requiredfieldvalidator_errormessage_0000 %>" />
                <asp:RegularExpressionValidator runat="server" ControlToValidate="EmailTextBox" Display="Dynamic" Text="*" ErrorMessage="<%$ Resources: UI, pages_admin_useredit_regularexpressionvalidator_errormessage_0000 %>" ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*" />
                <br />
                <asp:TextBox ID="EmailTextBox" runat="server" />
            </p>
            <p>
                <asp:Label runat="server" Text="<%$ Resources: UI, pages_pageedit_label_text_0000 %>" AssociatedControlID="CommentTextBox" />
                <br />
                <asp:TextBox ID="CommentTextBox" runat="server" />
            </p>
            <p>
                <asp:Label runat="server" Text="<%$ Resources: UI, pages_admin_useredit_label_text_0001 %>" AssociatedControlID="NewPasswordTextBox" />
                <br />
                <asp:TextBox ID="NewPasswordTextBox" runat="server" />
            </p>
            <p>
                <asp:CheckBox ID="EnabledCheckBox" Text="<%$ Resources: UI, pages_admin_useredit_checkbox_text_0000 %>" runat="server" /><br />
                <asp:CheckBox ID="AdministratorCheckBox" Text="<%$ Resources: UI, pages_admin_useredit_checkbox_text_0001 %>" runat="server" />
            </p>
        </div>
        <footer>
            <asp:ValidationSummary runat="server" />
            <asp:Button ID="SubmitButton" Text="<%$ Resources: UI, _Submit %>" runat="server" OnClick="SubmitButton_Click" />
            <asp:Button ID="DeleteButton" Text="<%$ Resources: UI, pages_admin_useredit_button_text_0000 %>" runat="server" CausesValidation="false" OnClick="DeleteButton_Click" data-confirm-buttons="<%$ Resources: UI, _ConfirmButtons %>" data-confirm-title="<%$ Resources: UI, _ConfirmTitle %>" data-confirm-prompt="Are you sure you want to delete this user?" />
        </footer>
    </article>
</asp:Content>
