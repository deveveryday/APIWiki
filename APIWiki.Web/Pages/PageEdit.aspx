<%@ Page Title="<%$ Resources: UI, pages_pageedit_title %>" Language="C#" MasterPageFile="Site.Master" AutoEventWireup="true" CodeBehind="PageEdit.aspx.cs" Inherits="Altairis.Sewen.Wiki.Pages.PageEdit" %>
<asp:Content ContentPlaceHolderID="MainCPH" runat="server">
    <article>
        <asp:FormView ID="PageFormView" runat="server" DataSourceID="PageObjectDataSource" DefaultMode="Edit" OnItemCommand="PageFormView_ItemCommand" OnItemUpdated="PageFormView_ItemUpdated" DataKeyNames="Title">
            <EmptyDataTemplate>
                <header>
                    <h1>
                        <asp:Localize runat="server" Text="<%$ Resources: UI, pages_pageedit_localize_text_0000 %>" />
                    </h1>
                </header>
                <div>
                    <p>
                        <asp:Localize runat="server" Text="<%$ Resources: UI, pages_page_localize_text_0001 %>" />
                    </p>
                </div>
            </EmptyDataTemplate>
            <EditItemTemplate>
                <header>
                    <h1>
                        <asp:Literal ID="LiteralTitle" runat="server" Text='<%# Eval("Title", Resources.UI.pages_pageedit_title) %>' />
                    </h1>
                </header>
                <nav>
                    <ul>
                        <li>
                            <asp:Literal runat="server" Text='<%# Eval("Version", Resources.UI.pages_page_info_version ) %>' />
                        </li>
                        <li>
                            <asp:Literal runat="server" Text='<%# Eval("UserName", Resources.UI.pages_page_info_user) %>' />
                        </li>
                        <li>
                            <asp:Literal runat="server" Text='<%# Eval("IpAddress", Resources.UI.pages_page_info_ip) %>' />
                        </li>
                    </ul>
                </nav>
                <div>
                    <asp:TextBox ID="BodyTextBoxHtml" runat="server" Text='<%# Bind("Body") %>' TextMode="MultiLine" Height="400px" data-seweneditor-toolbar="<%$ Resources: UI, _WikiEditToolbar %>" />
                    <p>
                        <asp:Label runat="server" Text="<%$ Resources: UI, pages_pageedit_label_text_0000 %>" AssociatedControlID="CommentTextBox" />
                        <br />
                        <asp:TextBox ID="CommentTextBox" runat="server" Text='<%# Bind("Comment") %>' />
                    </p>
                </div>
                <footer>
                    <asp:RequiredFieldValidator runat="server" ControlToValidate="BodyTextBoxHtml" ErrorMessage="<%$ Resources: UI, pages_pageedit_requiredfieldvalidator_errormessage_0000 %>" Display="None" />
                    <asp:ValidationSummary runat="server" />
                    <asp:Button runat="server" CausesValidation="True" CommandName="Update" Text="<%$ Resources: UI, _Update %>" />
                    <asp:Button runat="server" CausesValidation="False" CommandName="Cancel" Text="<%$ Resources: UI, _Cancel %>" />
                </footer>
            </EditItemTemplate>
        </asp:FormView>
    </article>
    <asp:ObjectDataSource ID="PageObjectDataSource" runat="server" TypeName="Altairis.Sewen.PageStoreManager" DataObjectTypeName="Altairis.Sewen.SewenPage" SelectMethod="LoadPage" UpdateMethod="SavePage">
        <SelectParameters>
            <asp:RouteParameter Name="name" RouteKey="slug" Type="String" DefaultValue="home-page" />
        </SelectParameters>
    </asp:ObjectDataSource>
</asp:Content>
