﻿<%@ Page Language="C#" AutoEventWireup="true" CodeFile="test-dns.aspx.cs" Inherits="test" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
        <asp:TextBox ID="TextBox1" runat="server" Width="188px">ws.integratedprescription.com</asp:TextBox>
&nbsp;<asp:Button ID="Button1" runat="server" onclick="Button1_Click" 
            Text="See IP &gt;&gt;" />
&nbsp;<asp:TextBox ID="TextBox2" runat="server" Width="187px"></asp:TextBox>
    </div>
    </form>
</body>
</html>
