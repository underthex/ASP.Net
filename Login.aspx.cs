using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using SimpleCrypto;
using System.Data;

public partial class Login : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        string strMsg = "";
        if (Request.QueryString["status"] != null)
        {
            if (Request.QueryString["name"] != null)
            {
                strMsg += "<p class=\"header2\">" + Request.QueryString["name"].ToString() + ",</p>";
            }

            if (Request.QueryString["status"].ToString() == "1")
            {
                strMsg += "<p>Thank you for registering for an online access to your documents throught RXIPM member portal.<br>&larr; Please login to start.</p>";
                strMsg += "<hr>";
            }
            
            if (Request.QueryString["status"].ToString() == "2")
            {
                strMsg += "<p>You had previously registered for an online access.<br>&larr; Please login.</p>or reset your password if necessary.</p>";
                strMsg += "<p style=\"text-align:right\"><input type=button value=\"Reset Password\" onclick=\"self.location.href='Password-Reset.aspx'\"></p>";
                strMsg += "<hr>";
            }
            if (Request.QueryString["status"].ToString() == "Timeout") {
                strMsg += "<p class=\"header2\">Session Timeout</p>";
                strMsg += "<p>You were logged out due to inactivity. <br>&larr; Please re-login to start a new session.</p>";
                strMsg += "<hr>";
            }
        }
        litMsgBody.Text = strMsg;
    }
    protected void btn_submit_Click(object sender, EventArgs e)
    {
        //ValidateLogin2 valLogin = new ValidateLogin2();
        //valLogin.Username = txtEmail.Text;
        //valLogin.Password = txtPassword2.Text;
        //litMsgBody.Text = valLogin.Description;

        string strMsg = "";
        ValidateLogin valLogin = new ValidateLogin();
        if (valLogin.isValid(txtEmail.Text, txtPassword2.Text))
        {
            //SUCCESSFULLY AUTHENICATED
            //strMsg = "logged in: " + valLogin.FName + " " + valLogin.LName + ", email: " + valLogin.Email;

            //Populate Login Cookies
            Response.Cookies["Account"]["IP"] = Request.ServerVariables["REMOTE_ADDR"].ToString();
            Response.Cookies["Account"]["LoginDate"] = DateTime.Now.ToShortDateString();
            Response.Cookies["Account"]["AutoID"] = valLogin.AutoID.ToString();
            Response.Cookies["Account"]["Name"] = valLogin.FName + " " + valLogin.LName;
            Response.Cookies["Account"]["FName"] = valLogin.FName;
            Response.Cookies["Account"]["LName"] = valLogin.LName;
            Response.Cookies["Account"]["Email"] = valLogin.Email;
            Response.Cookies["Account"]["MemberID"] = valLogin.MemberID;
            if (Convert.ToInt16(valLogin.PersonID) < 10)
            {
                Response.Cookies["Account"]["PersonID"] = "0" + valLogin.PersonID;
            }
            else {
                Response.Cookies["Account"]["PersonID"] = valLogin.PersonID;
            }
            Response.Cookies["Account"]["Email"] = valLogin.Email;
            Response.Cookies["TimeTrack"].Value = DateTime.Now.ToString();

            Response.Redirect("Portal.aspx?sorts[computeDate]=-1");

        }
        else
        {
            if (valLogin.LoginDescription == "Empty") {
                strMsg += "<p class=\"header2 Red\">Member Not Found!</p><p>Please Register.</p>";
                strMsg += "<p style=\"text-align:right; margin-bottom:1px;\"><input type=button value=\"Register\" onclick=\"self.location.href='Register.aspx'\"></p><p style=\"text-align:right;margin-top:1px; font-size:12px;\"><a href=\"Password-Reset.aspx\">Reset your password.</a></p>";
                strMsg += "<hr>";
            }
            if (valLogin.LoginDescription == "Invalid")
            {
                strMsg += "<p class=\"header2 Red\">Invalid Login.</p><p>Please re-try.</p>";
                strMsg += "<p style=\"text-align:right\"><input type=button value=\"Reset Password\" onclick=\"self.location.href='Password-Reset.aspx'\"></p>";
                strMsg += "<hr style=\"width:90%\">";
            }
        }
        litMsgBody.Text = strMsg;
    }

}