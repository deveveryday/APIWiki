<%@ Page Title="<%$ Resources: UI, pages_history_title %>" Language="C#" MasterPageFile="Site.Master" AutoEventWireup="true" CodeBehind="History.aspx.cs" Inherits="Altairis.Sewen.Wiki.Pages.History" %>
<asp:Content ContentPlaceHolderID="MainCPH" runat="server">
    <article>
        <asp:ListView runat="server" DataSourceID="HeaderObjectDataSource">
            <ItemTemplate>
                <header>
                    <h1>
                        <asp:Literal Text='<%# Eval("Title", "History of page {0}") %>' runat="server" />
                    </h1>
                </header>
                <nav>
                    <ul>
                        <li>
                            <asp:HyperLink runat="server" NavigateUrl="<%$ RouteUrl: RouteName=SewenWikiPage %>" Text="<%$ Resources: UI, pages_history_hyperlink_text_0000 %>" />
                        </li>
                    </ul>
                </nav>
            </ItemTemplate>
        </asp:ListView>
        <asp:ObjectDataSource ID="HeaderObjectDataSource" runat="server" SelectMethod="LoadPage" TypeName="Altairis.Sewen.PageStoreManager">
            <SelectParameters>
                <asp:RouteParameter Name="name" RouteKey="slug" Type="String" DefaultValue="home-page" />
            </SelectParameters>
        </asp:ObjectDataSource>
        <asp:ListView runat="server" DataSourceID="HistoryObjectDataSource">
            <LayoutTemplate>
                <div>
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
                </div>
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
    </article>
</asp:Content>
