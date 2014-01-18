<%@ Page Title="" Language="C#" MasterPageFile="~/_secure.master" AutoEventWireup="true"
    CodeFile="Portal-Account.aspx.cs" Inherits="Portal_Account" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <style>
        .inlineBox
        {
            display: inline-block;
            padding: 0 5px;
            text-align: left;
        }
        .itemSection
        {
            text-align: center;
        }
        .subHead
        {
            border-top: 1px dotted #ddd4ac;
            text-align: center;
        }
        .desc
        {
            width: 600px;
            margin: auto;
            text-align: left;
            padding-bottom: 30px;
        }
        .error
        {
            font-size: 12px;
            color: Red;
            background: #eeeeee;
            padding: 5px;
            margin: -10px auto 10px auto;
            width: 80%;
            border-radius: 7px;
            display: none;
        }
        .showError
        {
            display: inline-block;
        }
    </style>
</asp:Content>
<asp:content id="Content2" contentplaceholderid="slides" runat="Server">
    <iframe style="width: 100%; height: 359px; margin: 37px 0 0 0; padding: 0; border: 0"
        id="flexslider" frameborder="0" name="flexslider" scrolling="no" src="slides/member/images/01.png">
        Your browser does not support inline frames or is currently configured not to display
        inline frames.</iframe>
</asp:content>
<asp:content id="Content3" contentplaceholderid="ContentPlaceHolder1" runat="Server">
    <input type="button" onclick="javascript:window.location.href='Portal.aspx'" value="Go Back"
                style="float: right; margin: -10px 50px 0 0;" class="buttonCopper">
    <p class="header2">
        Account Settings</p>
    <div id="divPassword" class="itemSection">
        <p class="header1 subHead">
            Change My Password</p>
        <p class="desc">
            You will be 
            prompted to log out upon successful submission. Please log back in with your new password.</p>
        <p id="error1" class="error">
            Error</p>
        <div class="inlineBox">
            Current Password:<br />
            <asp:textbox id="passwordCurrent" runat="server" TextMode="Password"></asp:textbox>
        </div>
        <div class="inlineBox">
            New Password:<br />
            <asp:textbox id="passwordNew" runat="server" TextMode="Password"></asp:textbox>
        </div>
        <div class="inlineBox">
            Confirm New Password:<br />
            <asp:textbox id="passwordNew2" runat="server" TextMode="Password"></asp:textbox>
        </div>
        <div class="inlineBox">
            <asp:button runat="server" id="btnSubmitPassword" cssclass="button1 buttonSmall" text="Update" />
        </div>
    </div>
    <div id="divEmail" class="itemSection">
        <p class="header1 subHead">
            Update My Email Address</p>
        <p class="desc">Current Email: 
            <asp:literal id="litCurrEmail" runat="server"></asp:literal></p>
        <p class="desc">
            You will be asked to confirm your new email address by logging into your new email
            account and click the confirmation link.</p>
        <p id="error2" class="error">
            Error</p>
        <div class="inlineBox">
            New Email:<br />
            <asp:textbox id="emailNew" runat="server">
            </asp:textbox>
        </div>
        <div class="inlineBox">
            Confirm New Email:<br />
            <asp:textbox id="emailNew2" runat="server">
            </asp:textbox>
        </div>
        <div class="inlineBox">
            Current
            Password:<br />
            <asp:textbox id="emailPassword" runat="server">
            </asp:textbox>
        </div>
        <div class="inlineBox">
            <asp:button runat="server" id="btnSubmitEmail" cssclass="button1 buttonSmall" text="Update" />
        </div>
    </div>
    <br />
    <br />
    <br />
</asp:content>
<asp:content id="Content4" contentplaceholderid="foot" runat="Server">
    <script type="text/javascript">
        $(document).ready(function () {

            $("#<%= btnSubmitEmail.ClientID %>").on("click", function (e) {
                e.preventDefault();
            });

            $("#<%= btnSubmitPassword.ClientID %>").on("click", function (e) {
                e.preventDefault();
                var thisButton = $(this);
                var curPassword = $("#<%= passwordCurrent.ClientID %>");
                var newPassword = $("#<%= passwordNew.ClientID %>");
                var newPassword2 = $("#<%= passwordNew2.ClientID %>");
                if (curPassword.val() == "" || newPassword.val() == "" || newPassword2.val() == "") {
                    showError("#error1", $("<p>All fields are required</p>"));
                    curPassword.focus();
                }
                else if (newPassword.val().length < 6 || newPassword2.val().length < 6) {
                    showError("#error1", $("<p>New password is too short. Must be 6 characters or more</p>"));
                    newPassword2.val("");
                    newPassword.val("").focus();
                }
                else if (newPassword.val() != newPassword2.val()) {
                    showError("#error1", $("<p>New password cannot be confirmed. Please try again.</p>"));
                    newPassword2.val("").focus();
                }
                else {
                    
                    $.ajax({
                        url: "AccountSettings.asmx/ChangePassword",
                        dataType: "json",
                        contentType: "application/json; charset=utf-8",
                        type: "POST",
                        data: JSON.stringify({ "strpass": curPassword.val(), "strnewpass": newPassword.val(), "memberid": "<%=Request.Cookies["Account"]["MemberID"]%>", "email": "<%=Request.Cookies["Account"]["Email"]%>" }), //data HAS TO BE STRINGIFIED to work!!!
                        error: function (request, errorStatus, errorMsg) {
                            alert("Error: " + errorMsg);
                        },
                        success: function (response) {
                            if(response.d == "invalid"){
                                showError("#error1", $("<p>Your current password is invalid. Please try again.</p>"));
                                curPassword.val("").focus();
                            }
                            if(response.d == "valid"){
                                alert("Your password has been updated. Click OK to log out.");
                                window.location.href = 'Logout.aspx';
                            }
                        },
                        beforeSend: function(){ 
                                thisButton.val("Loading ...").attr('disabled', 'disabled' );
                                hideError("#error1");
                            }, // before ajax command fires off, set the loading animation/spinner here
    				    complete: function(){ 
                                thisButton.val("Update").removeAttr('disabled')
                            } //run after success 
                    });
                }
            });
        });

        function showError(container, errorMsg) {
            $(container).html(errorMsg).addClass("showError");
        }

        function hideError(container) {
            $(container).html("").removeClass("showError");
        }

    </script>
</asp:content>
