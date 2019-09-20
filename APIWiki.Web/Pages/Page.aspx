<%@ Page Title="<%$ Resources: UI, pages_page_title %>" Language="C#" MasterPageFile="Site.Master" AutoEventWireup="true" CodeBehind="Page.aspx.cs" Inherits="Altairis.Sewen.Wiki.Pages.Page" %>
<asp:Content ContentPlaceHolderID="MainCPH" runat="server">
    <article>
        <asp:FormView ID="PageFormView" runat="server" DataSourceID="PageObjectDataSource">
            <EmptyDataTemplate>
                <header>
                    <h1>
                        <asp:Localize runat="server" Text="<%$ Resources: UI, pages_page_localize_text_0000 %>" />
                    </h1>
                </header>
                <nav>
                    <ul>
                        <li>
                            <asp:HyperLink runat="server" NavigateUrl="<%$ RouteUrl: RouteName=SewenWikiPageNew %>" Text="<%$ Resources: UI, pages_page_hyperlink_text_0000 %>" />
                        </li>
                        <li>
                            <asp:HyperLink runat="server" NavigateUrl="<%$ RouteUrl: RouteName=SewenWikiSearch %>" Text="<%$ Resources: UI, pages_page_hyperlink_text_0001 %>" />
                        </li>
                    </ul>
                </nav>
                <div>
                    <p>
                        <asp:Localize runat="server" Text="<%$ Resources: UI, pages_page_localize_text_0001 %>" />
                    </p>
                </div>
            </EmptyDataTemplate>
            <ItemTemplate>
                <header>
                    <h1>
                        <asp:Literal runat="server" Text='<%# Eval("Title") %>' />
                    </h1>
                </header>
                <nav>
                    <ul>
                        <li>
                            <asp:HyperLink runat="server" NavigateUrl="<%$ RouteUrl: RouteName=SewenWikiPageHistory %>" Text="<%$ Resources: UI, pages_page_hyperlink_text_0002 %>" data-dialog-open="history" />
                        </li>
                        <li>
                            <asp:HyperLink runat="server" NavigateUrl="<%$ RouteUrl: RouteName=SewenWikiPageEdit %>" Text="<%$ Resources: UI, pages_page_hyperlink_text_0003 %>" />
                        </li>
                        <li>
                            <asp:HyperLink runat="server" NavigateUrl="<%$ RouteUrl: RouteName=SewenWikiPageNew, slug= %>" Text="<%$ Resources: UI, pages_page_hyperlink_text_0000 %>" />
                        </li>
                        <li>
                            <asp:HyperLink runat="server" NavigateUrl="<%$ RouteUrl: RouteName=SewenWikiSearch %>" Text="<%$ Resources: UI, pages_page_hyperlink_text_0001 %>" />
                        </li>
                    </ul>
                </nav>
                <div>
                    <sewen:WikiMarkup runat="server" CssClass="body" Text='<%# Eval("Body") %>' />
                </div>
            </ItemTemplate>
        </asp:FormView>
        <asp:ListView runat="server" DataSourceID="HistoryObjectDataSource">
            <LayoutTemplate>
                <asp:Panel ID="history" runat="server" ClientIDMode="Static" title="<%$ Resources: UI, pages_history_title %>" data-dialog-options="minWidth:700;maxWidth:1000;minHeight:300">
                    <table>
                        <thead>
                            <tr>
                                <th>
                                    <asp:Localize runat="server" Text="<%$ Resources: UI, pages_history_localize_text_0000 %>" />
                                </th>
                                <th>
                                    <asp:Localize runat="server" Text="<%$ Resources: UI, pages_history_localize_text_0001 %>" />
                                </th>
                                <th>
                                    <asp:Localize runat="server" Text="<%$ Resources: UI, pages_history_localize_text_0002 %>" />
                                </th>
                                <th>
                                    <asp:Localize runat="server" Text="<%$ Resources: UI, pages_history_localize_text_0003 %>" />
                                </th>
                            </tr>
                        </thead>
                        <tbody>
                            <asp:PlaceHolder ID="ItemPlaceHolder" runat="server" />
                        </tbody>
                        <asp:LoginView runat="server">
                            <RoleGroups>
                                <asp:RoleGroup Roles="<%$ SewenConfig: Security.AdminRoleName %>">
                                    <ContentTemplate>
                                        <tfoot>
                                            <tr>
                                                <td colspan="4">
                                                    <altairis:IconHyperLink runat="server" Icon="Cross" NavigateUrl='<%$ RouteUrl: RouteName=SewenWikiPage, exe=delete-old %>' Text="<%$ Resources: UI, pages_page_iconhyperlink_text_0001 %>" data-confirm-buttons="<%$ Resources: UI, _ConfirmButtons %>" data-confirm-title="<%$ Resources: UI, _ConfirmTitle %>" data-confirm-prompt="<%$ Resources: UI, pages_history_hyperlink_confirm_0001 %>" />
                                                </td>
                                            </tr>
                                            <tr>
                                                <td colspan="4">
                                                    <altairis:IconHyperLink runat="server" Icon="Cross" NavigateUrl='<%$ RouteUrl: RouteName=SewenWikiPage, exe=delete %>' Text="<%$ Resources: UI, pages_page_iconhyperlink_text_0000 %>" data-confirm-buttons="<%$ Resources: UI, _ConfirmButtons %>" data-confirm-title="<%$ Resources: UI, _ConfirmTitle %>" data-confirm-prompt="<%$ Resources: UI, pages_history_hyperlink_confirm_0000 %>" />
                                                </td>
                                            </tr>
                                        </tfoot>
                                    </ContentTemplate>
                                </asp:RoleGroup>
                            </RoleGroups>
                        </asp:LoginView>
                    </table>
                </asp:Panel>
            </LayoutTemplate>
            <ItemTemplate>
                <tr>
                    <td>
                        <altairis:IconHyperLink runat="server" Icon="PageDelete" Mode="IconOnly" ToolTip="<%$ Resources: UI, pages_history_iconhyperlink_tooltip_0000 %>" NavigateUrl='<%# this.GetRouteUrl("SewenWikiPageVersion", new { slug = Eval("Slug"), version = Eval("Version", "{0:yyyyMMddHHmmssfff}") }) + "?exe=delete" %>' Visible='<%# this.User.IsInRole(Global.Configuration.Security.AdminRoleName) %>' data-confirm-buttons="<%$ Resources: UI, _ConfirmButtons %>" data-confirm-title="<%$ Resources: UI, _ConfirmTitle %>" data-confirm-prompt="<%$ Resources: UI, pages_history_iconhyperlink_confirm_0000 %>" />
                        <asp:HyperLink runat="server" NavigateUrl='<%# this.GetRouteUrl("SewenWikiPageVersion", new { slug = Eval("Slug"), version = Eval("Version", "{0:yyyyMMddHHmmssfff}") }) %>' Text='<%# Eval("Version", "{0:d} {0:T}") %>' />
                    </td>
                    <td>
                        <asp:Literal runat="server" Text='<%# Eval("UserName") %>' />
                    </td>
                    <td>
                        <asp:Literal runat="server" Text='<%# Eval("IpAddress") %>' />
                    </td>
                    <td>
                        <asp:Literal runat="server" Text='<%# Eval("Comment") %>' />
                    </td>
                </tr>
            </ItemTemplate>
        </asp:ListView>
        <asp:ObjectDataSource ID="HistoryObjectDataSource" runat="server" SelectMethod="LoadPageVersions" TypeName="Altairis.Sewen.PageStoreManager">
            <SelectParameters>
                <asp:RouteParameter Name="name" RouteKey="slug" Type="String" DefaultValue="home-page" />
            </SelectParameters>
        </asp:ObjectDataSource>
        <asp:ObjectDataSource ID="PageObjectDataSource" runat="server" TypeName="Altairis.Sewen.PageStoreManager" DataObjectTypeName="Altairis.Sewen.SewenPage" SelectMethod="LoadPage">
            <SelectParameters>
                <asp:RouteParameter Name="name" RouteKey="slug" Type="String" DefaultValue="home-page" />
                <asp:RouteParameter Name="versionString" RouteKey="version" Type="String" />
            </SelectParameters>
        </asp:ObjectDataSource>
    </article>
</asp:Content>
