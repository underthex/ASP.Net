<%@ Page Title="" Language="C#" MasterPageFile="~/_public-ssl.master" AutoEventWireup="true"
    CodeFile="Register.aspx.cs" Inherits="Register" %>

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
            <p class="header1">
                Member Sign Up
            </p>
            <p>
                Please sign up with your IPM membership information.
            </p>
            <asp:panel id="pnlSignUp" runat="server" defaultbutton="btn_signup">
                <asp:validationsummary id="ValidationSummary1" runat="server" style="font-size: 11px;
                    color: Red;" validationgroup="formSignUp" />
                <table cellpadding="2">
                    <tr>
                        <td style="padding-right: 6px">
                            <p class="label">
                                First Name: <span style="color: Red;">*</span></p>
                            <asp:textbox id="txtFN" runat="server" validationgroup="formSignUp">
                            </asp:textbox>
                        </td>
                        <td>
                            <p class="label">
                                Last Name: <span style="color: Red;">*</span></p>
                            <asp:textbox id="txtLN" runat="server" validationgroup="formSignUp">
                            </asp:textbox>
                        </td>
                    </tr>
                    <tr>
                        <td style="padding-right: 6px" valign="top">
                            <p class="label">
                                Member ID: <span style="color: Red;">*</span></p>
                            <asp:textbox id="txtMemberID" runat="server" validationgroup="formSignUp">
                            </asp:textbox>
                        </td>
                        <td valign="top">
                            <p class="label">
                                Group Number: <span style="color: Red;">*</span></p>
                            <asp:textbox id="txtGroup" runat="server" validationgroup="formSignUp">
                            </asp:textbox>
                        </td>
                    </tr>
                    <tr>
                        <td style="padding-right: 6px" valign="top">
                            <p class="label">
                                Date of Birth (mm dd yyyy): <span style="color: Red;">*</span></p>
                            <asp:dropdownlist id="dobMM" runat="server" width="60px">
                            </asp:dropdownlist>
                            </span>
                            <asp:dropdownlist id="dobDD" runat="server" width="60px">
                            </asp:dropdownlist>
                            </span>
                            <asp:dropdownlist id="dobYYYY" runat="server" width="80px">
                            </asp:dropdownlist>
                        </td>
                        <td valign="bottom" align="right">
                            <asp:button id="btn_signup" style="padding: 4px 15px" runat="server" text="Sign Up"
                                validationgroup="formSignUp" onclick="btn_signup_Click" />
                            <span id="btn_signup_msg"></span>
                        </td>
                    </tr>
                </table>
            </asp:panel>
        </div>
        <div class="col_1_Right">
            <asp:panel id="pnlGeneric" runat="server">
                <br />
                <p style="text-align: center;">
                    <br />
                    <b>IPM Customer Service</b><br />
                    via email at <a href="mailto:info@rxipm.com">info@rxipm.com</a>
                    <br />
                    or call 1.877.860.8846</p>
            </asp:panel>
            <asp:panel id="pnlFailed" runat="server" visible="False">
                <br />
                <br />
                <br />
                <p class="header2 red">
                    Member Not Found!
                </p>
                <p class="header2 red" style="font-size: 30px; margin: 0;">
                    Please check your info on the card.</p>
                <p>
                    &nbsp;</p>
                <p>
                    Contact IPM Customer Service
                    <br />
                    via email at info@rxipm.com or call 1.877.860.8846</p>

            </asp:panel>
            <asp:panel id="pnlLoginInfo" runat="server" defaultbutton="btn_submit" visible="False">
                <p class="header1">
                    Member Sign Up (Con't)
                </p>
                <p>
                    Your eligibility has been approved. Please continue below...
                </p>
                <asp:validationsummary id="ValidationSummary2" runat="server" style="font-size: 11px;
                    color: Red;" validationgroup="formLoginInfo" />
                <table cellpadding="2">
                    <tr>
                        <td style="padding-right: 6px" colspan="2">
                            <p class="label">
                                Email: <span style="color: Red;">*</span></p>
                            <asp:textbox id="txtEmail" runat="server" validationgroup="formLoginInfo" cssclass="textBox"
                                width="350px">
                            </asp:textbox>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <p class="label">
                                Password: <span style="color: Red;">*</span></p>
                            <asp:textbox id="txtPassword" runat="server" validationgroup="formLoginInfo" textmode="Password">
                            </asp:textbox>
                        </td>
                        <td>
                            <asp:HiddenField ID="hfPersonID" runat="server" />
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
                            <asp:button id="btn_submit" style="padding: 4px 15px; margin: 0 0 10px 30px;" runat="server"
                                text="Submit" validationgroup="formLoginInfo" onclick="btn_submit_Click" />
                                <span id="btn_submit_msg"></span>
                        </td>
                    </tr>
                </table>
            </asp:panel>
        </div>
    </div>
</asp:content>
<asp:content id="Content4" contentplaceholderid="foot" runat="Server">
    <script>
        $(document).ready(function () {

            $("#ContentPlaceHolder1_btn_signup").on("click", function () {
                var errMsg = "";
                var blnError = false;
                if ($("#ContentPlaceHolder1_txtFN").val() == "") {
                    errMsg += "<li>First Name Required</li>";
                    blnError = true;
                };
                if ($("#ContentPlaceHolder1_txtLN").val() == "") {
                    errMsg += "<li>Last Name Required</li>";
                    blnError = true;
                };
                if ($("#ContentPlaceHolder1_txtMemberID").val() == "") {
                    errMsg += "<li>Member ID# Required</li>";
                    blnError = true;
                };
                if ($("#ContentPlaceHolder1_txtGroup").val() == "") {
                    errMsg += "<li>Group Number Required</li>";
                    blnError = true;
                };
                if (blnError === true) {
                    $("#ContentPlaceHolder1_ValidationSummary1").text(errMsg)
                    .attr("style", "font-size:11px;color:Red;").html("<ul>" + errMsg + "</ul>");
                    return false;
                }
                else {
                    $(this).attr("style", "display:none");
                    $("#btn_signup_msg").html("Please wait...");
                    return true;
                };
            });

            $("#ContentPlaceHolder1_btn_submit").on("click", function () {
                var errMsg = "";
                var blnError = false;
                if ($("#ContentPlaceHolder1_txtEmail").val() == "") {
                    errMsg += "<li>Email Required</li>";
                    blnError = true;
                } else {
                    if (isValidEmailAddress($("#ContentPlaceHolder1_txtEmail").val()) === false) {
                        errMsg += "<li>Invalid email address</li>";
                        blnError = true;
                    }
                };
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
                    $("#ContentPlaceHolder1_ValidationSummary2").text(errMsg)
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
</asp:content>
