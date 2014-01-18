<%@ Page Language="C#" AutoEventWireup="true" CodeFile="test-email.aspx.cs" Inherits="test_email" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
    
        To (email):
        <asp:TextBox ID="txtToEmail" runat="server"></asp:TextBox>
&nbsp;<br />
        <br />
        Host:
        <asp:TextBox ID="txtHost" runat="server">mail.rxipm.com</asp:TextBox>
&nbsp;Port
        <asp:TextBox ID="txtPort" runat="server" Width="41px">25</asp:TextBox>
        <br />
        From (email):
        <asp:TextBox ID="txtFromEmail" runat="server">no-reply@rxipm.com</asp:TextBox>
&nbsp;<br />
        <br />
        Username:
        <asp:TextBox ID="txtUsername" runat="server" >no-reply@rxipm.com</asp:TextBox>
        <br />
        Password: 
        <asp:TextBox ID="txtPassword" runat="server" TextMode="Password" ></asp:TextBox>
        <br />
        <br />
        <asp:CheckBox ID="chkSecure" runat="server" Text="Secure" Checked="True" />
        <br />
        <br />
        <br />
        <asp:Button ID="btnSend" runat="server" onclick="btnSend_Click" 
            Text="Test Send" />
    
        <br />
    
    </div>
    </form>
</body>
</html>
