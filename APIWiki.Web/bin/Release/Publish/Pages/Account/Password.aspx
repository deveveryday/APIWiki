<%@ Page Title="<%$ Resources: UI, pages_account_password_title %>" Language="C#" MasterPageFile="~/Pages/Site.Master" AutoEventWireup="true" CodeBehind="Password.aspx.cs" Inherits="Altairis.Sewen.Wiki.Pages.Account.Password" %>
<asp:Content ContentPlaceHolderID="MainCPH" runat="server">
    <article>
        <header>
            <h1>
                <asp:Localize runat="server" Text="<%$ Resources: UI, pages_account_password_title %>" />
            </h1>
        </header>
        <asp:ChangePassword runat="server" RenderOuterTable="false" ChangePasswordFailureText="<%$ Resources: UI, pages_account_password_changepassword_changepasswordfailuretext_0000 %>">
            <ChangePasswordTemplate>
                <div>
                    <asp:Literal ID="FailureText" runat="server" EnableViewState="False"></asp:Literal>
                    <p>
                        <asp:Label ID="CurrentPasswordLabel" runat="server" AssociatedControlID="CurrentPassword" Text="<%$ Resources: UI, pages_account_password_label_text_0000 %>" />
                        <asp:RequiredFieldValidator ID="CurrentPasswordRequired" runat="server" ControlToValidate="CurrentPassword" ErrorMessage="<%$ Resources: UI, pages_account_login_requiredfieldvalidator_errormessage_0001 %>" ValidationGroup="password" Text="*" Display="Dynamic" />
                        <br />
                        <asp:TextBox ID="CurrentPassword" runat="server" TextMode="Password" />
                    </p>
                    <p>
                        <asp:Label ID="NewPasswordLabel" runat="server" AssociatedControlID="NewPassword" Text="<%$ Resources: UI, pages_account_password_label_text_0001 %>" />
                        <asp:RequiredFieldValidator ID="NewPasswordRequired" runat="server" ControlToValidate="NewPassword" ErrorMessage="<%$ Resources: UI, pages_account_password_requiredfieldvalidator_errormessage_0000 %>" ValidationGroup="password" Text="*" Display="Dynamic" />
                        <br />
                        <asp:TextBox ID="NewPassword" runat="server" TextMode="Password" />
                    </p>
                    <p>
                        <asp:Label ID="ConfirmNewPasswordLabel" runat="server" AssociatedControlID="ConfirmNewPassword" Text="<%$ Resources: UI, pages_account_password_label_text_0002 %>" />
                        <asp:RequiredFieldValidator ID="ConfirmNewPasswordRequired" runat="server" ControlToValidate="ConfirmNewPassword" ErrorMessage="<%$ Resources: UI, pages_account_password_requiredfieldvalidator_errormessage_0001 %>" ValidationGroup="password" Text="*" Display="Dynamic" />
                        <asp:CompareValidator ID="NewPasswordCompare" runat="server" ControlToCompare="NewPassword" ControlToValidate="ConfirmNewPassword" Display="Dynamic" ErrorMessage="<%$ Resources: UI, pages_account_password_comparevalidator_errormessage_0000 %>" ValidationGroup="password" Text="*" />
                        <br />
                        <asp:TextBox ID="ConfirmNewPassword" runat="server" TextMode="Password" />
                    </p>
                </div>
                <footer>
                    <asp:ValidationSummary runat="server" ValidationGroup="password" />
                    <asp:Button ID="ChangePasswordPushButton" runat="server" CommandName="ChangePassword" Text="<%$ Resources: UI, _Submit %>" ValidationGroup="password" />
                </footer>
            </ChangePasswordTemplate>
            <SuccessTemplate>
                <div>
                    <p>
                        <asp:Localize runat="server" Text="<%$ Resources: UI, pages_account_password_localize_text_0000 %>" />
                    </p>
                </div>
            </SuccessTemplate>
        </asp:ChangePassword>
    </article>
</asp:Content>
