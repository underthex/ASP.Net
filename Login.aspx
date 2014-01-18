<%@ Page Title="" Language="C#" MasterPageFile="~/_public-ssl.master" AutoEventWireup="true"
    CodeFile="Login.aspx.cs" Inherits="Login" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:content id="Content2" contentplaceholderid="slides" runat="Server">
    <iframe style="width: 100%; height: 359px; margin: 37px 0 0 0; padding: 0; border: 0"
        id="flexslider" frameborder="0" name="flexslider" scrolling="no" src="slides/signup/images/01.png">
        Your browser does not support inline frames or is currently configured not to display
        inline frames.</iframe>
</asp:content>
<asp:content id="Content3" contentplaceholderid="ContentPlaceHolder1" runat="Server">
    <div class="clearfix">
        <div class="col_1_Left">
            <asp:panel id="pnlLoginInfo" runat="server" defaultbutton="btn_submit">
                <p class="header1">
                    Member Log-In</p>
                <p>
                    Please login below to access your info.
                </p>
                <asp:validationsummary id="ValidationSummary2" runat="server" style="font-size: 11px;
                    color: Red;" validationgroup="formLoginInfo" />
                <table cellpadding="2">
                    <tr>
                        <td style="padding-right: 6px" colspan="2">
                            <p class="label">
                                Email: <span style="color: Red;">*</span><asp:requiredfieldvalidator id="valEmail"
                                    runat="server" controltovalidate="txtEmail" errormessage="Email Required" forecolor="Red"
                                    validationgroup="formLoginInfo" display="None">*</asp:requiredfieldvalidator>
                                <asp:regularexpressionvalidator id="RegularExpressionValidator1" runat="server" controltovalidate="txtEmail"
                                    errormessage="Invalid email format" forecolor="Red" validationexpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*"
                                    validationgroup="formLoginInfo">*</asp:regularexpressionvalidator>
                            </p>
                            <asp:textbox id="txtEmail" runat="server" validationgroup="formLoginInfo" cssclass="textBox"
                                width="350px">
                            </asp:textbox>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <p class="label">
                                Password: <span style="color: Red;">*<asp:requiredfieldvalidator id="valPass2"
                                    runat="server" controltovalidate="txtPassword2" errormessage="Password Confirmation Required"
                                    forecolor="Red" validationgroup="formLoginInfo" display="None">*</asp:requiredfieldvalidator>
                                </span>
                            </p>
                            <asp:textbox id="txtPassword2" runat="server" validationgroup="formLoginInfo" textmode="Password">
                            </asp:textbox>
                        </td>
                        <td valign="bottom" align="right">
                            <asp:button id="btn_submit" style="padding: 4px 15px; margin: 0 0 10px 30px;" runat="server"
                                text="Submit" validationgroup="formLoginInfo" onclick="btn_submit_Click" />
                        </td>
                    </tr>
                </table>
            </asp:panel>
        </div>
        <div class="col_1_Right">
        <br />
            <asp:Literal ID="litMsgBody" runat="server"></asp:Literal>
            <asp:panel id="pnlGeneric" runat="server">
                
                <p style="text-align: center;">
                    <br />
                    <b>IPM Customer Service</b><br />
                    via email at <a href="mailto:info@rxipm.com">info@rxipm.com</a>
                    <br />
                    or call 1.877.860.8846</p>
                <p style="text-align: center;">
                    &nbsp;</p>
            </asp:panel>
        </div>
    </div>
</asp:content>
<asp:content id="Content4" contentplaceholderid="foot" runat="Server">
</asp:content>
