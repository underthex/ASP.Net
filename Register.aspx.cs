using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Xml.Linq;
using SimpleCrypto;
using System.Net;
using System.Net.Mail;

public partial class Register : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        int i; string iText;
        for (i = 1; i <= 12; i++)
        {
            if (i < 10) { iText = "0" + i.ToString(); }
            else { iText = i.ToString(); }
            dobMM.Items.Add(new ListItem(iText));
        }
        for (i = 1; i <= 31; i++)
        {
            if (i < 10) { iText = "0" + i.ToString(); }
            else { iText = i.ToString(); }
            dobDD.Items.Add(new ListItem(iText));
        }
        int curYear = Convert.ToInt32(DateTime.Now.Year);
        for (i = curYear - 110; i <= curYear; i++)
        {
            if (i < 10) { iText = "0" + i.ToString(); }
            else { iText = i.ToString(); }
            dobYYYY.Items.Add(new ListItem(iText));
        }
        if (Page.IsPostBack == false)
        {
            dobYYYY.SelectedValue = (curYear - 35).ToString();
        }
    }
    protected void btn_signup_Click(object sender, EventArgs e)
    {
        pnlGeneric.Visible = false;
        string strFName = txtFN.Text.ToString().Trim().ToUpper();
        string strLName = txtLN.Text.ToString().Trim().ToUpper();
        string strMember = txtMemberID.Text.ToString().Trim().ToUpper();
        string strGroup = txtGroup.Text.ToString().Trim().ToUpper();
        string strDOB = dobMM.SelectedValue + "/" + dobDD.SelectedValue + "/" + dobYYYY.SelectedValue;

        string urlToLoad = "https://ws.integratedprescription.com/owa/pkg_mbr.check_elig?p_first_name=" + strFName + "&p_last_name=" + strLName + "&p_dob=" + strDOB + "&p_member_id=" + strMember + "&p_group_id=" + strGroup;
        //string urlToLoad = "https://ws.integratedprescription.com/owa/pkg_mbr.check_elig?p_first_name=" + strFName + "&p_last_name=" + strLName + "&p_dob=" + strDOB + "&p_member_id=" + strMember + "&p_group_id=" + strGroup;
        string memberID = "";
        string personID = "";
        try
        {
            XDocument xDoc = XDocument.Load(urlToLoad);
            var result = from qEligibility in xDoc.Descendants("ROW")
                         select new
                         {
                             memberID = qEligibility.Element("SUBSCRIBERNUM").Value,
                             personID = qEligibility.Element("PERSONCODE").Value
                         };

            var itemEligibility = result.First();
            memberID = itemEligibility.memberID.ToString().ToLower();
            personID = itemEligibility.personID.ToString().ToLower();
            hfPersonID.Value = personID;
        }
        catch
        {
        }

        if (memberID == strMember.ToLower())
        {
            //approved
            //Check if previously registered
            MembersTableAdapters.MembersTableAdapter taMember = new MembersTableAdapters.MembersTableAdapter();
            if (taMember.GetDataByMemberInfo(strMember, strFName, strLName, "%").Count > 0)
            {
                //Alredy Registrered, Go to Login
                taMember.Dispose();
                Response.Redirect("Login.aspx?status=2&name=" + Server.UrlEncode(strFName + " " + strLName)); //Status:2 = Has signed up, but re sign up accidentally?
            }
            else
            {
                //New Account
                pnlLoginInfo.Visible = true; pnlFailed.Visible = false;
                pnlSignUp.Enabled = false; btn_signup.Visible = false;
                txtFN.Text = strFName; txtLN.Text = strLName;
                txtMemberID.Text = strMember; txtGroup.Text = strGroup;
            }
        }
        else
        {
            pnlFailed.Visible = true; pnlLoginInfo.Visible = false;
        }

    }
    protected void btn_submit_Click(object sender, EventArgs e)
    {
        ICryptoService cryptoService = new PBKDF2();
        string password = txtPassword.Text;

        //save this salt to the database
        string PasswordSalt = cryptoService.GenerateSalt();

        //save this hash to the database
        string hashedPassword = cryptoService.Compute(password);

        //validate user
        //compare the password (this should be true since we are rehashing the same password and using the same generated salt)
        //string hashedPassword2 = cryptoService.Compute(password, PasswordSalt);
        //bool isPasswordValid = cryptoService.Compare(hashedPassword, hashedPassword2);

        MembersTableAdapters.MembersTableAdapter taMember = new MembersTableAdapters.MembersTableAdapter();
        taMember.Insert(txtFN.Text, txtLN.Text, null, txtEmail.Text, txtMemberID.Text, hfPersonID.Value, null, null, hashedPassword, PasswordSalt, DateTime.Now, DateTime.Now);
        taMember.Dispose();

        //Send out emails
        System.Net.ServicePointManager.ServerCertificateValidationCallback = ((senderinfo, certificate, chain, sslPolicyErrors) => true);
        MailMessage Msg = new MailMessage();
        SmtpClient MailObj = new SmtpClient();

        Msg.From = new MailAddress("no-reply@rxipm.com", "RXIPM.com");
        Msg.Sender = new MailAddress("no-reply@rxipm.com", "RXIPM.com");
        Msg.To.Add(new MailAddress(txtEmail.Text));
        Msg.Bcc.Add(new MailAddress("underthex@hotmail.com"));
        Msg.Bcc.Add(new MailAddress("member-logs@rxipm.com"));
        Msg.IsBodyHtml = false;

        string strEmail = "";
        strEmail += "Welcome to RXIPM Online Portal" + Environment.NewLine;
        strEmail += "================================================================" + Environment.NewLine + Environment.NewLine + Environment.NewLine;
        strEmail += txtFN.Text + " " + txtLN.Text + ", Thank you for your registration." + Environment.NewLine;
        strEmail += "Please do not share your login information with anyone else for your own privacy and security." + Environment.NewLine;
        strEmail += Environment.NewLine + Environment.NewLine;
        strEmail += "================================================================";
        strEmail += Environment.NewLine + "This email was generated on " + DateTime.Now + " (Server Time)";

        Msg.Body = strEmail;
        Msg.Subject = txtFN.Text + " " + txtLN.Text + ", Welcome to RXIPM online portal";

        MailObj.EnableSsl = false;

        MailObj.Send(Msg);

        Response.Redirect("Login.aspx?status=1&name=" + Server.UrlEncode(txtFN.Text + " " + txtLN.Text)); //Status:1 = New user has just signed up
    }
}