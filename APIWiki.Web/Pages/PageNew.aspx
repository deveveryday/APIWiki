<%@ Page Title="<%$ Resources: UI, pages_pagenew_title %>" Language="C#" MasterPageFile="Site.Master" AutoEventWireup="true" CodeBehind="PageNew.aspx.cs" Inherits="Altairis.Sewen.Wiki.Pages.PageNew" %>
<asp:Content ContentPlaceHolderID="MainCPH" runat="server">
    <article>
        <asp:FormView ID="PageFormView" runat="server" DataSourceID="PageObjectDataSource" DefaultMode="Insert" OnItemCommand="PageFormView_ItemCommand" OnItemInserted="PageFormView_ItemInserted">
            <InsertItemTemplate>
                <header>
                    <h1>
                        <asp:Localize runat="server" Text="<%$ Resources: UI, pages_pagenew_title %>" />
                    </h1>
                </header>
                <div>
                    <p>
                        <asp:Label runat="server" Text="<%$ Resources: UI, pages_pagenew_label_text_0000 %>" AssociatedControlID="TitleTextBox" />
                        <br />
                        <asp:TextBox ID="TitleTextBox" runat="server" Text='<%# Bind("Title") %>' />
                    </p>
                    <p>
                        <asp:Label runat="server" Text="<%$ Resources: UI, pages_pagenew_label_text_0001 %>" AssociatedControlID="BodyTextBoxHtml" />
                        <br />
                        <asp:TextBox ID="BodyTextBoxHtml" runat="server" Text='<%# Bind("Body") %>' TextMode="MultiLine" Height="300px" data-seweneditor-toolbar="<%$ Resources: UI, _WikiEditToolbar %>" />
                    </p>
                </div>
                <footer>
                    <asp:RequiredFieldValidator runat="server" ControlToValidate="TitleTextBox" ErrorMessage="<%$ Resources: UI, pages_pagenew_requiredfieldvalidator_errormessage_0000 %>" Display="None" />
                    <asp:RequiredFieldValidator runat="server" ControlToValidate="BodyTextBoxHtml" ErrorMessage="<%$ Resources: UI, pages_pageedit_requiredfieldvalidator_errormessage_0000 %>" Display="None" />
                    <asp:ValidationSummary runat="server" />
                    <asp:Button ID="InsertButton" runat="server" CausesValidation="True" CommandName="Insert" Text="<%$ Resources: UI, _Insert %>" />
                    <asp:Button ID="InsertCancelButton" runat="server" CausesValidation="False" CommandName="Cancel" Text="<%$ Resources: UI, _Cancel %>" />
                </footer>
            </InsertItemTemplate>
        </asp:FormView>
    </article>
    <asp:ObjectDataSource ID="PageObjectDataSource" runat="server" TypeName="Altairis.Sewen.PageStoreManager" DataObjectTypeName="Altairis.Sewen.SewenPage" InsertMethod="SavePage" />
</asp:Content>
