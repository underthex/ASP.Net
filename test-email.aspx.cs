using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Net;
using System.Net.Mail;


public partial class test_email : System.Web.UI.Page
{


    protected void Page_Load(object sender, EventArgs e)
    {
         
    }
    protected void btnSend_Click(object objsender, EventArgs e)
    {
        System.Net.ServicePointManager.ServerCertificateValidationCallback = ((sender, certificate, chain, sslPolicyErrors) => true); 

        string WebsiteName = Request.Url.Host.ToLower();

        MailMessage Msg = new MailMessage();
        SmtpClient MailObj = new SmtpClient();

        Msg.From = new MailAddress(txtFromEmail.Text);
        Msg.Sender = new MailAddress(txtFromEmail.Text);
        Msg.To.Add(new MailAddress(txtToEmail.Text));
        //Msg.Bcc.Add(new MailAddress("stenly@webcitypress.com", WebsiteName + " AutoEmail"));
        Msg.IsBodyHtml = false;

        string strEmail = "";
        strEmail += "This is an automatic email. Please do not reply!" + Environment.NewLine;
        strEmail += "================================================================" + Environment.NewLine + Environment.NewLine + Environment.NewLine;
        strEmail += txtFromEmail.Text + " Test Email" + Environment.NewLine;
        strEmail += "================================================================";
        strEmail += Environment.NewLine + "This email was generated on " + DateTime.Now + " (web server time)";

        Msg.Body = strEmail;
        Msg.Subject = WebsiteName + " : Test Email";


        MailObj.UseDefaultCredentials = false;
        MailObj.EnableSsl = chkSecure.Checked;
        MailObj.Host = txtHost.Text;
        MailObj.Port = Convert.ToInt16(txtPort.Text);
        MailObj.Credentials = new NetworkCredential(txtUsername.Text, txtPassword.Text);

        MailObj.Send(Msg);

        Response.Write("Email sent to " + txtToEmail.Text);
    }

}