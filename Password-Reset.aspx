<%@ Page Title="" Language="C#" MasterPageFile="~/_public-ssl.master" AutoEventWireup="true" CodeFile="Password-Reset.aspx.cs" Inherits="Password_Reset" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
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
                    Password Reset</p>
                <p>
                    Please enter your registered email address to initiate password reset procedure.
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
                            &nbsp;</td>
                        <td valign="bottom" align="right">
                            <asp:button id="btn_submit" style="padding: 4px 15px; margin: 0 0 10px 30px;" runat="server"
                                text="Initiate" validationgroup="formLoginInfo" onclick="btn_submit_Click" />
                        </td>
                    </tr>
                </table>
            </asp:panel>
            <asp:panel id="pnlPasswordReset" runat="server" defaultbutton="btn_submit" visible="False">
                <p class="header1">
                    Reset My Password
                </p>
                <p>
                    Please enter and confirm your new password...
                </p>
                <asp:validationsummary id="ValidationSummary3" runat="server" style="font-size: 11px;
                    color: Red;" validationgroup="formLoginInfo" />
                <table cellpadding="2">
                    <tr>
                        <td>
                            <p class="label">
                                Password: <span style="color: Red;">*</span></p>
                            <asp:textbox id="txtPassword" runat="server" validationgroup="formLoginInfo" textmode="Password">
                            </asp:textbox>
                        </td>
                        <td>
                            <asp:HiddenField ID="hfAutoID" runat="server" />
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <p class="label">
                                Confirm Password: <span style="color: Red;">*</span></p>
                            <asp:textbox id="txtPassword2" runat="server" validationgroup="formLoginInfo" textmode="Password">
                            </asp:textbox>
                        </td>
                        <td valign="bottom" align="right">
                            <asp:button id="btn_newPassword" 
                                style="padding: 4px 15px; margin: 0 0 10px 30px;" runat="server"
                                text="Confirm" validationgroup="formLoginInfo" 
                                onclick="btn_newPassword_Click" />
                                <span id="btn_submit_msg"></span>
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
<asp:Content ID="Content4" ContentPlaceHolderID="foot" Runat="Server">
    <script>
        $(document).ready(function () {

            $("#ContentPlaceHolder1_btn_newPassword").on("click", function () {
                var errMsg = "";
                var blnError = false;
                if ($("#ContentPlaceHolder1_txtPassword").val() == "") {
                    errMsg += "<li>Password Required</li>";
                    blnError = true;
                };
                if ($("#ContentPlaceHolder1_txtPassword2").val() == "") {
                    errMsg += "<li>Password Confirmation Required</li>"
                    blnError = true;
                };
                if ($("#ContentPlaceHolder1_txtPassword1").val() != "" && $("#ContentPlaceHolder1_txtPassword2").val() != "") {
                    if ($("#ContentPlaceHolder1_txtPassword").val() != $("#ContentPlaceHolder1_txtPassword2").val()) {
                        errMsg += "<li>Password Confirmation Failed. Please re-enter</li>";
                        $("#ContentPlaceHolder1_txtPassword").val("").focus();
                        $("#ContentPlaceHolder1_txtPassword2").val("");
                        blnError = true;
                    };
                }
                if (blnError === true) {
                    $("#ContentPlaceHolder1_ValidationSummary3").text(errMsg)
                    .attr("style", "font-size:11px;color:Red;").html("<ul>" + errMsg + "</ul>")
                    return false
                }
                else {
                    $(this).attr("style", "display:none");
                    $("#btn_submit_msg").html("Please wait...");
                    return true;
                };
            });

            function isValidEmailAddress(emailAddress) {
                var pattern = new RegExp(/^((([a-z]|\d|[!#\$%&'\*\+\-\/=\?\^_`{\|}~]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])+(\.([a-z]|\d|[!#\$%&'\*\+\-\/=\?\^_`{\|}~]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])+)*)|((\x22)((((\x20|\x09)*(\x0d\x0a))?(\x20|\x09)+)?(([\x01-\x08\x0b\x0c\x0e-\x1f\x7f]|\x21|[\x23-\x5b]|[\x5d-\x7e]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(\\([\x01-\x09\x0b\x0c\x0d-\x7f]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF]))))*(((\x20|\x09)*(\x0d\x0a))?(\x20|\x09)+)?(\x22)))@((([a-z]|\d|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(([a-z]|\d|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])([a-z]|\d|-|\.|_|~|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])*([a-z]|\d|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])))\.)+(([a-z]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(([a-z]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])([a-z]|\d|-|\.|_|~|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])*([a-z]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])))\.?$/i);
                return pattern.test(emailAddress);
            };

        });
    </script>

</asp:Content>

