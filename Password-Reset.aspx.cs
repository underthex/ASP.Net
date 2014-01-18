using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Net;
using System.Net.Mail;
using SimpleCrypto;

public partial class Password_Reset : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        pnlPasswordReset.Visible = false; pnlLoginInfo.Visible = true;
        if (Request.QueryString["Email"] != null && Request.QueryString["ResetID"] != "") {
            string strEmail = Server.UrlDecode(Request.QueryString["Email"]);
            string strEntered = Server.UrlDecode(Request.QueryString["ResetID"]);
            MembersTableAdapters.MembersTableAdapter taMember = new MembersTableAdapters.MembersTableAdapter();
            if (taMember.GetDataByEmail(strEmail).Count > 0) {
                DataRow dtMember = taMember.GetDataByEmail(strEmail).Rows[0];
                if (dtMember["Entered"].ToString() == strEntered.ToString()) {
                    string strAutoID = dtMember["AutoID"].ToString();
                    pnlLoginInfo.Visible = false;
                    pnlPasswordReset.Visible = true;
                    hfAutoID.Value = strAutoID;
                };
            }
            taMember.Dispose();
        }
    }
    protected void btn_submit_Click(object sender, EventArgs e)
    {
        string strMsg = "";
        MembersTableAdapters.MembersTableAdapter taMember = new MembersTableAdapters.MembersTableAdapter();
        if (taMember.GetDataByEmail(txtEmail.Text).Count > 0)
        {
            //Member Found
            strMsg += "<p class=\"header2 Red\">An email has been sent!</p><p>Please follow the instructions on the email to reset your password.</p>";
            strMsg += "<hr>";
            DataRow dtMember = taMember.GetDataByEmail(txtEmail.Text).Rows[0];
            string qEmail = dtMember["Email"].ToString(); string qEntered = dtMember["Entered"].ToString();

            //Send out emails
            System.Net.ServicePointManager.ServerCertificateValidationCallback = ((senderinfo, certificate, chain, sslPolicyErrors) => true);
            MailMessage Msg = new MailMessage();
            SmtpClient MailObj = new SmtpClient();
            string WebsiteName = Request.Url.Host.ToLower();

            Msg.From = new MailAddress("no-reply@rxipm.com", "RXIPM.com");
            Msg.Sender = new MailAddress("no-reply@rxipm.com", "RXIPM.com");
            Msg.To.Add(new MailAddress(qEmail));
            Msg.Bcc.Add(new MailAddress("underthex@hotmail.com"));
            Msg.Bcc.Add(new MailAddress("member-logs@rxipm.com"));
            Msg.IsBodyHtml = false;

            string strEmail = "";
            strEmail += "We received a request to reset your password." + Environment.NewLine;
            strEmail += "================================================================" + Environment.NewLine + Environment.NewLine + Environment.NewLine;
            strEmail += "Hello " + dtMember["FirstName"].ToString() + " " + dtMember["LastName"].ToString() + ", Please click on the link below to replace your current password." + Environment.NewLine;
            strEmail += "Please do not share your password with anyone else for your own privacy and security." + Environment.NewLine;
            strEmail += "http://www." + WebsiteName.Replace("www.", "") + "/Password-Reset.aspx?Email=" + Server.UrlEncode(qEmail) + "&ResetID=" + Server.UrlEncode(qEntered);
            strEmail += Environment.NewLine + Environment.NewLine;
            strEmail += "================================================================";
            strEmail += Environment.NewLine + "This email was generated on " + DateTime.Now + " (Server Time)";

            Msg.Body = strEmail;
            Msg.Subject = "Password Reset for RXIPM online portal";

            MailObj.EnableSsl = false;

            MailObj.Send(Msg);
        }
        else { 
            //Member Not Found
            strMsg += "<p class=\"header2 Red\">Member Not Found!</p><p>Please Register.</p>";
            strMsg += "<p style=\"text-align:right; margin-bottom:1px;\"><input type=button value=\"Register\" onclick=\"self.location.href='Register.aspx'\"></p><p style=\"text-align:right;margin-top:1px; font-size:12px;\"><a href=\"Password-Reset.aspx\">Reset your password.</a></p>";
            strMsg += "<hr>";
        }
        taMember.Dispose();
        litMsgBody.Text = strMsg;
    }
    protected void btn_newPassword_Click(object sender, EventArgs e)
    {
        ICryptoService cryptoService = new PBKDF2();
        string password = txtPassword.Text;

        //save this salt to the database
        string PasswordSalt = cryptoService.GenerateSalt();

        //save this hash to the database
        string hashedPassword = cryptoService.Compute(password);

        MembersTableAdapters.MembersTableAdapter taMember = new MembersTableAdapters.MembersTableAdapter();
        taMember.UpdatePassword(hashedPassword, PasswordSalt, DateTime.Now, Convert.ToInt32(hfAutoID.Value));
        taMember.Dispose();

        string strMsg = "<p class=\"header2\">Password Changed</p><p>Now you can login with your new password.</p>";
        strMsg += "<p style=\"text-align:right; margin-bottom:1px;\"><input type=button value=\"Log-In Now\" onclick=\"self.location.href='Login.aspx'\"></p><hr>";
        litMsgBody.Text = strMsg;
    }
}