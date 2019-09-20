<%@ Page Title="<%$ Resources: UI, pages_account_login_title %>" Language="C#" MasterPageFile="~/Pages/Site.Master" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="Altairis.Sewen.Wiki.Pages.Account.Login" %>
<asp:Content ContentPlaceHolderID="MainCPH" runat="server">
    <article>
        <asp:LoginView runat="server">
            <AnonymousTemplate>
                <asp:Login runat="server" RenderOuterTable="false" FailureText="<%$ Resources: UI, pages_account_login_login_failuretext_0000 %>">
                    <LayoutTemplate>
                        <header>
                            <h1>
                                <asp:Localize runat="server" Text="<%$ Resources: UI, pages_site_master_iconhyperlink_text_0000 %>" />
                            </h1>
                        </header>
                        <div>
                            <asp:Literal ID="FailureText" runat="server" />
                            <p>
                                <asp:Label ID="UserNameLabel" runat="server" AssociatedControlID="UserName" Text="<%$ Resources: UI, pages_account_login_label_text_0000 %>" />
                                <asp:RequiredFieldValidator ID="UserNameRequired" runat="server" ControlToValidate="UserName" ErrorMessage="<%$ Resources: UI, pages_account_login_requiredfieldvalidator_errormessage_0000 %>" ValidationGroup="login" Text="*" Display="Dynamic" />
                                <br />
                                <asp:TextBox ID="UserName" runat="server" />
                            </p>
                            <p>
                                <asp:Label ID="PasswordLabel" runat="server" AssociatedControlID="Password" Text="<%$ Resources: UI, pages_account_login_label_text_0001 %>" />
                                <asp:RequiredFieldValidator ID="PasswordRequired" runat="server" ControlToValidate="Password" ErrorMessage="<%$ Resources: UI, pages_account_login_requiredfieldvalidator_errormessage_0001 %>" ValidationGroup="login" Text="*" Display="Dynamic" />
                                <br />
                                <asp:TextBox ID="Password" runat="server" TextMode="Password" />
                            </p>
                            <p>
                                <asp:CheckBox ID="RememberMe" runat="server" Text="<%$ Resources: UI, pages_account_login_checkbox_text_0000 %>" Checked="true" />
                            </p>
                        </div>
                        <footer>
                            <asp:ValidationSummary runat="server" ValidationGroup="login" />
                            <asp:Button ID="LoginButton" runat="server" CommandName="Login" Text="<%$ Resources: UI, _Submit %>" ValidationGroup="login" />
                        </footer>
                    </LayoutTemplate>
                </asp:Login>
            </AnonymousTemplate>
            <LoggedInTemplate>
                <header>
                    <h1>
                        <asp:Localize runat="server" Text="<%$ Resources: UI, pages_account_login_localize_text_0000 %>" />
                    </h1>
                </header>
                <div>
                    <p>
                        <asp:Localize runat="server" Text="<%$ Resources: UI, pages_account_login_localize_text_0001 %>" />
                    </p>
                </div>
            </LoggedInTemplate>
        </asp:LoginView>
    </article>
</asp:Content>
