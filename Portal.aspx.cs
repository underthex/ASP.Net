using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Xml.Linq;

public partial class Portal : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        System.Globalization.TextInfo ti = System.Globalization.CultureInfo.CurrentCulture.TextInfo;
        lblFullName.Text = "<span class=\"header2\">Welcome, " + ti.ToTitleCase(Request.Cookies["Account"]["Name"].ToString().ToLower()) + "</span>";

        string urlToLoad = "https://ws.integratedprescription.com/owa/IPM.pkg_clm.hist?p_member_id=" + Request.Cookies["Account"]["MemberID"].ToString().ToUpper() + "&p_person_code=" + Request.Cookies["Account"]["PersonID"].ToString();
        try
        {
            XDocument xDoc = XDocument.Load(urlToLoad);
            var result = from qEligibility in xDoc.Descendants("ROW")
                         select new
                         {
                             RX_NUM = qEligibility.Element("RX_NUM").Value,
                             DATE_FILLED = qEligibility.Element("DATE_FILLED").Value,
                             NDC = qEligibility.Element("NDC").Value,
                             NDC_DESCRIPTION = qEligibility.Element("NDC_DESCRIPTION").Value,
                             METRIC_QTY = qEligibility.Element("METRIC_QTY").Value,
                             DAYS_SUPPLY = qEligibility.Element("DAYS_SUPPLY").Value,
                             PATIENT_TOTAL = qEligibility.Element("PATIENT_TOTAL").Value
                         };

            string strOutput = "<table id=\"tblActivity\"><thead><tr><th data-dynatable-sorts=\"computeDate\">Date</th><th style=\"display:none\">computeDate</th><th>Rx Number</th><th>NDC#</th><th>Description</th><th>Qty</th><th>Days of<br>Supply</th><th>Copay</th></tr></thead><tbody>";
            string sortDate = ""; string sortPaddedDayNum = ""; string sortPaddedMonthNum = ""; 
            for (int i = 0; i < result.Count(); i++) {
                
                if (Convert.ToInt16(Convert.ToDateTime(result.ElementAt(i).DATE_FILLED).Day.ToString()) < 10){sortPaddedDayNum = "0" + Convert.ToDateTime(result.ElementAt(i).DATE_FILLED).Day.ToString();}
                else{sortPaddedDayNum = Convert.ToDateTime(result.ElementAt(i).DATE_FILLED).Day.ToString();}

                if (Convert.ToInt16(Convert.ToDateTime(result.ElementAt(i).DATE_FILLED).Month.ToString()) < 10) { sortPaddedMonthNum = "0" + Convert.ToDateTime(result.ElementAt(i).DATE_FILLED).Month.ToString(); }
                else { sortPaddedMonthNum = Convert.ToDateTime(result.ElementAt(i).DATE_FILLED).Month.ToString(); }

                strOutput += "<tr>";
                sortDate = Convert.ToDateTime(result.ElementAt(i).DATE_FILLED).Year.ToString() + sortPaddedMonthNum + sortPaddedDayNum;
                strOutput += "<td>" + sortPaddedMonthNum + "/" + sortPaddedDayNum + "/" + Convert.ToDateTime(result.ElementAt(i).DATE_FILLED).Year.ToString() + "</td>";
                strOutput += "<td>" + sortDate + "</td>";
                strOutput += "<td>" + result.ElementAt(i).RX_NUM + "</td>";
                strOutput += "<td>" + result.ElementAt(i).NDC + "</td>";
                strOutput += "<td>" + result.ElementAt(i).NDC_DESCRIPTION + "</td>";
                strOutput += "<td>" + result.ElementAt(i).METRIC_QTY + "</td>";
                strOutput += "<td>" + result.ElementAt(i).DAYS_SUPPLY + "</td>";
                strOutput += "<td>" + "$ " + Convert.ToDecimal(result.ElementAt(i).PATIENT_TOTAL).ToString("0.00") + "</td>";
                strOutput += "</tr>";
            }
            strOutput += "</tbody></table>";
            litContent1.Text = strOutput;
        }
        catch {
            litContent1.Text = "Error loading data. Please log out and try again.";
        }
        
    }
}