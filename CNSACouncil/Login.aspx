<%@ Page Title="" Language="C#" MasterPageFile="~/masters/Students.Master" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="CNSACouncil.Login" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="Contents" runat="server">
	<form runat="server">
		<asp:TextBox runat="server" ID="UserID" placeholder="CNSAnet ID"></asp:TextBox>
		<asp:TextBox runat="server" ID="UserPW" TextMode="Password" placeholder="CNSAnet PW"></asp:TextBox>
		<asp:Button runat="server" ID="LoginButton" Text="로그인" OnClick="LoginButton_Click" />
	</form>
</asp:Content>
