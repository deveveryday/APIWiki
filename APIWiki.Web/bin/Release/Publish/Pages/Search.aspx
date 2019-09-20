<%@ Page Title="<%$ Resources: UI, pages_search_title %>" Language="C#" MasterPageFile="Site.Master" AutoEventWireup="true" CodeBehind="Search.aspx.cs" Inherits="Altairis.Sewen.Wiki.Pages.Search" %>
<asp:Content ContentPlaceHolderID="MainCPH" runat="server">
    <article>
        <header>
            <h1>
                <asp:Localize runat="server" Text="<%$ Resources: UI, pages_search_title %>" />
            </h1>
        </header>
        <div>
            <asp:ListView ID="ResultsListView" runat="server">
                <LayoutTemplate>
                    <h2>
                        <asp:Localize runat="server" Text="<%$ Resources: UI, pages_search_localize_text_0000 %>" />
                    </h2>
                    <ul>
                        <asp:PlaceHolder ID="ItemPlaceHolder" runat="server" />
                    </ul>
                </LayoutTemplate>
                <ItemTemplate>
                    <li>
                        <asp:HyperLink runat="server" NavigateUrl='<%# this.GetRouteUrl("SewenWikiPage", new { slug = Eval("Slug") }) %>' Text='<%# Eval("Title") %>' />
                    </li>
                </ItemTemplate>
                <EmptyDataTemplate>
                    <h2>
                        <asp:Localize runat="server" Text="<%$ Resources: UI, pages_search_localize_text_0000 %>" />
                    </h2>
                    <p>
                        <asp:Localize runat="server" Text="<%$ Resources: UI, pages_search_localize_text_0001 %>" />
                    </p>
                </EmptyDataTemplate>
            </asp:ListView>
            <asp:TextBox ID="TextBoxQuery" runat="server" />
        </div>
        <footer>
            <asp:RequiredFieldValidator runat="server" ControlToValidate="TextBoxQuery" ErrorMessage="<%$ Resources: UI, pages_search_requiredfieldvalidator_errormessage_0000 %>" Display="None" />
            <asp:ValidationSummary runat="server" />
            <asp:Button ID="SearchButton" runat="server" Text="<%$ Resources: UI, pages_search_title %>" OnClick="SearchButton_Click" />
        </footer>
    </article>
</asp:Content>
