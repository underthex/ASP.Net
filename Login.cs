using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data;
using SimpleCrypto;

/// <summary>
/// Summary description for Login
/// </summary>
/// 
public class ValidateLogin2
{
    public string Username { get; set; }
    public string Password { get; set; }
    public string Description
    {
        get {
            return Username +  " : " + Password;
        }
        set
        { 
    } }

}

public class ValidateLogin
{
    public string LoginDescription = "";
    public string FName { get; set; }
    public string LName { get; set; }
    public int AutoID { get; set; }
    public string Email { get; set; }
    public string MemberID { get; set; }
    public string PersonID { get; set; }

    public bool isValid(string strEmail, string strPassword)
    {

        MembersTableAdapters.MembersTableAdapter taMember = new MembersTableAdapters.MembersTableAdapter();
        if (taMember.GetDataByEmail(strEmail).Count > 0)
        {
            DataRow dtMember = taMember.GetDataByEmail(strEmail).Rows[0];
            string qPassword = dtMember["Password"].ToString();
            string qPasswordSalt = dtMember["PasswordSalt"].ToString();
            //validate user
            //compare the password (this should be true since we are rehashing the same password and using the same generated salt)
            ICryptoService cryptoService = new PBKDF2();
            string hashedStrPassword = cryptoService.Compute(strPassword, qPasswordSalt);
            bool isPasswordValid = cryptoService.Compare(qPassword, hashedStrPassword);
            
            if (isPasswordValid == true)
            {
                LoginDescription = "Success";
                FName = dtMember["FirstName"].ToString();
                LName = dtMember["LastName"].ToString();
                AutoID = Convert.ToInt32(dtMember["AutoID"]);
                Email = dtMember["Email"].ToString();
                MemberID = dtMember["MemberID"].ToString();
                PersonID = dtMember["PersonID"].ToString();
                taMember.Dispose();

                return true;
            }
            else
            {
                LoginDescription = "Invalid";
                taMember.Dispose();
                return false;
            }
        }
        else
        {
            taMember.Dispose();
            LoginDescription = "Empty";
            taMember.Dispose();
            return false;

        }
    }
}