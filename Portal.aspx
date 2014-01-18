<%@ Page Title="" Language="C#" MasterPageFile="~/_secure.master" AutoEventWireup="true"
    CodeFile="Portal.aspx.cs" Inherits="Portal" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <link rel="stylesheet" type="text/css" href="css/dynatable.css">
    <link rel="stylesheet" href="css/font-awesome.min.css">
    <script type="text/javascript" src="js/dynatable.js"></script>
    <style type="text/css">
        #divActivity
        {
            width: 900px;
            font-size: 13px;
        }
        #tblActivity
        {
            width: 100%;
            border: 1px solid silver;
        }
        #tblActivity tr:nth-child(even)
        {
            background-color: #eeeeee;
        }
        #tblActivity th, #tblActivity td
        {
            padding: 5px;
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
    <div id="qLink">
        <i class="fa fa-link"></i>
        <ul id="qLinkNav">
            <li data-div="divActivity">Claim History</li>
            <li data-div="divBenefits">Benefit Summary</li>
            <li data-div="divFormulary">Formulary Lookup</li>
        </ul>
    </div>
    <div class="clearfix">
        <div>
            <asp:label id="lblFullName" runat="server"></asp:label>
            <input type="button" onclick="javascript:window.location.href='Logout.aspx'" value="Log Out"
                style="float: right; margin: -10px 50px 0 0;" class="buttonCopper">
            <input type="button" onclick="javascript:window.location.href='Portal-Account.aspx'" value="Settings"
                style="float: right; margin: -10px 10px 0 0;" class="buttonCopper">
            <br />
            <div id="divActivity">
                <p class="header1" style="border-top: 1px dotted #ddd4ac; text-align: center;">
                    Claim History</p>
                <asp:literal id="litContent1" runat="server"></asp:literal>
            </div>
            <div id="divBenefits">
                <p class="header1" style="border-top: 1px dotted #ddd4ac; text-align: center;">
                    Benefit Summary</p>
                <asp:literal id="litContent2" runat="server"></asp:literal>
            </div>
            <div id="divFormulary">
                <p class="header1" style="border-top: 1px dotted #ddd4ac; text-align: center;">
                    Formulary Lookup</p>
                <asp:literal id="litContent3" runat="server"></asp:literal>
                <iframe id="iframeFormulary" scrolling="no" src="formulary.aspx?mode=plain" style="border: 0;
                    width: 1010px; height: 410px; background: transparent;"></iframe>
            </div>
            <p>
            </p>
            <p>
            </p>
            <p>
            </p>
        </div>
    </div>
</asp:content>
<asp:content id="Content4" contentplaceholderid="foot" runat="Server">
    <script type="text/javascript">

        var linksObject = {
            init: function () {
                $("#qLinkNav").on("click", "li", this.clickOnLi);
            },
            clickOnLi: function () {
                //console.log($(this).data('div'));
                $("html, body").animate({ scrollTop: $("#" + $(this).data("div")).offset().top - 35 }, "slow")
            }
        };

        $(document).ready(function () {
            $('#tblActivity').dynatable({
                dataset: {
                    perPageDefault: 10,
                    perPageOptions: [10, 30, 50, 100]
                }

            });

            linksObject.init();

            $('#iframeFormulary').load(function () {
                var iframeUrl = $(this).contents().get(0).location.href;
                console.log("test: " + iframeUrl.toLowerCase().indexOf("search="));
                if (iframeUrl.toLowerCase().indexOf("search=") > 0) {
                    $(this).animate({ "height": "650px" });
                } else {
                    $(this).animate({ "height": "400px" });
                }
            });




            //        var quickLinks = $('#qLink').children("#qLinkNav"); var htmlBody = $('html, body');
            //        var link1 = quickLinks.find("li").eq(0); var spot1 = "#divActivity";
            //        var link2 = quickLinks.find("li").eq(1); var spot2 = "#divBenefits";
            //        var link3 = quickLinks.find("li").eq(2); var spot3 = "#divFormulary";
            //        link1.on("click", function(){ htmlBody.animate({scrollTop: $(spot1).offset().top - 35}, 'slow'); });
            //        link2.on("click", function(){ htmlBody.animate({scrollTop: $(spot2).offset().top - 35}, 'slow'); });
            //        link3.on("click", function(){ htmlBody.animate({scrollTop: $(spot3).offset().top - 35}, 'slow'); });

            $(document).scroll(function () {
                if ($(document).scrollTop() >= $('#ContentPlaceHolder1_lblFullName').offset().top) {
                    $('#qLink').addClass("sticky");
                }
                else {
                    $('#qLink').removeClass("sticky");
                }
            });


        });
    </script>
</asp:content>
