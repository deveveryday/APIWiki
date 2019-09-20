<%@ Page Title="<%$ Resources: UI, pages_admin_userlist_title %>" Language="C#" MasterPageFile="~/Pages/Site.Master" AutoEventWireup="true" CodeBehind="UserList.aspx.cs" Inherits="Altairis.Sewen.Wiki.Pages.Admin.UserList" %>
<asp:Content ContentPlaceHolderID="MainCPH" runat="server">
    <article>
        <header>
            <asp:Localize runat="server" Text="<%$ Resources: UI, pages_admin_userlist_title %>" />
        </header>
        <nav>
            <ul>
                <li>
                    <a href="#newuser" data-dialog-open="newuser">
                        <asp:Localize runat="server" Text="<%$ Resources: UI, pages_admin_userlist_localize_text_0000 %>" />
                    </a>
                </li>
            </ul>
        </nav>
        <div>
            <asp:Literal ID="LiteralSucess" Visible="false" Text="<%$ Resources: UI, pages_admin_userlist_literal_text_0000 %>" runat="server" />
            <asp:Literal ID="LiteralError" Visible="false" Text="<%$ Resources: UI, pages_admin_userlist_literal_text_0001 %>" runat="server" />
            <asp:ListView runat="server" DataSourceID="UsersDataSource">
                <LayoutTemplate>
                    <table>
                        <thead>
                            <tr>
                                <th>
                                    <asp:Localize runat="server" Text="<%$ Resources: UI, pages_admin_userlist_localize_text_0001 %>" />
                                </th>
                                <th>
                                    <asp:Localize runat="server" Text="<%$ Resources: UI, pages_admin_userlist_localize_text_0002 %>" />
                                </th>
                                <th>
                                    <asp:Localize runat="server" Text="<%$ Resources: UI, pages_admin_userlist_localize_text_0003 %>" />
                                </th>
                                <th>
                                    <asp:Localize runat="server" Text="<%$ Resources: UI, pages_admin_userlist_localize_text_0004 %>" />
                                </th>
                                <th>
                                    <asp:Localize runat="server" Text="<%$ Resources: UI, pages_history_localize_text_0003 %>" />
                                </th>
                            </tr>
                        </thead>
                        <tbody>
                            <asp:PlaceHolder ID="ItemPlaceHolder" runat="server" />
                        </tbody>
                    </table>
                </LayoutTemplate>
                <ItemTemplate>
                    <tr>
                        <td>
                            <altairis:IconHyperLink runat="server" Icon="UserEdit" Text='<%# Eval("UserName") %>' NavigateUrl='<%# this.GetRouteUrl("AdminUserDetail", new { username = Eval("UserName") } ) %>' />
                        </td>
                        <td>
                            <altairis:IconHyperLink runat="server" Icon="Email" Text='<%# Eval("Email") %>' NavigateUrl='<%# Eval("Email", "mailto:{0}") %>' />
                        </td>
                        <td>
                            <altairis:DateLabel runat="server" DateValue='<%# Eval("CreationDate") %>' />
                        </td>
                        <td>
                            <altairis:DateLabel runat="server" DateValue='<%# Eval("LastLoginDate") %>' />
                        </td>
                        <td>
                            <asp:Literal Text='<%# Eval("Comment") %>' runat="server" />
                        </td>
                    </tr>
                </ItemTemplate>
            </asp:ListView>
            <altairis:UsersDataSource ID="UsersDataSource" runat="server" />
            <asp:Panel ID="newuser" runat="server" title="Create user" data-dialog-options="minWidth:450" DefaultButton="CreateUserButton" ClientIDMode="Static">
                <p>
                    <asp:Label runat="server" Text="<%$ Resources: UI, pages_account_login_label_text_0000 %>" AssociatedControlID="UserNameTextBox" />
                    <asp:RequiredFieldValidator runat="server" ControlToValidate="UserNameTextBox" Display="Dynamic" Text="*" ErrorMessage="<%$ Resources: UI, pages_account_login_requiredfieldvalidator_errormessage_0000 %>" />
                    <br />
                    <asp:TextBox ID="UserNameTextBox" runat="server" />
                </p>
                <p>
                    <asp:Label runat="server" Text="<%$ Resources: UI, pages_admin_useredit_label_text_0000 %>" AssociatedControlID="EmailTextBox" />
                    <asp:RequiredFieldValidator runat="server" ControlToValidate="EmailTextBox" Display="Dynamic" Text="*" ErrorMessage="<%$ Resources: UI, pages_admin_useredit_requiredfieldvalidator_errormessage_0000 %>" />
                    <asp:RegularExpressionValidator runat="server" ControlToValidate="EmailTextBox" Display="Dynamic" Text="*" ErrorMessage="<%$ Resources: UI, pages_admin_useredit_regularexpressionvalidator_errormessage_0000 %>" ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*" />
                    <br />
                    <asp:TextBox ID="EmailTextBox" runat="server" />
                </p>
                <p>
                    <asp:Label runat="server" Text="<%$ Resources: UI, pages_admin_userlist_label_text_0000 %>" AssociatedControlID="PasswordTextBox" />
                    <asp:RequiredFieldValidator runat="server" ControlToValidate="PasswordTextBox" Display="Dynamic" Text="*" ErrorMessage="<%$ Resources: UI, pages_admin_userlist_requiredfieldvalidator_errormessage_0000 %>" />
                    <br />
                    <asp:TextBox ID="PasswordTextBox" runat="server" />
                </p>
                <asp:ValidationSummary runat="server" />
                <p>
                    <asp:Button ID="CreateUserButton" Text="<%$ Resources: UI, _Submit %>" runat="server" OnClick="CreateUserButton_Click" />
                </p>
            </asp:Panel>
        </div>
    </article>
</asp:Content>
