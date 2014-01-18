using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Web.Services.Protocols;
using System.Web.Script.Services;
using System.Data;
using SimpleCrypto;

/// <summary>
/// Summary description for AccountSettings
/// </summary>
[WebService(Namespace = "http://rxipm.com/")]
[WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
// To allow this Web Service to be called from script, using ASP.NET AJAX, uncomment the following line. 
 [System.Web.Script.Services.ScriptService]
public class AccountSettings : System.Web.Services.WebService {

    public AccountSettings () {

        //Uncomment the following line if using designed components 
        //InitializeComponent(); 
    }

    [WebMethod]
    [ScriptMethod(ResponseFormat = ResponseFormat.Json)]
    public string HelloWorld() {
        return "Hello World";
    }

    [WebMethod]
    [ScriptMethod(ResponseFormat = ResponseFormat.Json)]
    public string ChangePassword(string strpass, string strnewpass, string memberid, string email) {
        MembersTableAdapters.MembersTableAdapter taMember = new MembersTableAdapters.MembersTableAdapter();
        if (taMember.GetDataByMemberID(memberid).Count > 0) {
            DataRow dtMember = taMember.GetDataByMemberID(memberid).Rows[0];
            ValidateLogin valLogin = new ValidateLogin();
            if (valLogin.isValid(email, strpass))
            {
                ICryptoService cryptoService = new PBKDF2();
                //save this salt to the database
                string PasswordSalt = cryptoService.GenerateSalt();
                //save this hash to the database
                string hashedPassword = cryptoService.Compute(strnewpass);
                taMember.UpdatePassword(hashedPassword, PasswordSalt, DateTime.Now, Convert.ToInt32(dtMember["AutoID"]));
                return "valid";
            }
            else
            {
                return "invalid";
            }
        }
        taMember.Dispose();
        return "invalid";
        
    } 
}
