<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="CNSACouncil.admin.Login" %>

<!DOCTYPE html>

<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />

	<!-- Title -->
	<title>충남삼성고등학교 학생회 - 관리자 로그인</title>

	<!-- Icon -->
	<link rel="shortcut icon" href="/assets/img/CSC.png" />

	<!-- Bootstrap CSS Framework -->
	<link rel="stylesheet" href="/assets/css/bootstrap.min.css?ver=0.3">

	<!-- Custom CSS -->
	<link rel="stylesheet" href="/assets/css/style.css?ver=0.6">
</head>
<body>
	<form runat="server">
		<asp:TextBox runat="server" ID="AdminID" placeholder="ID"></asp:TextBox>
		<asp:TextBox runat="server" ID="AdminPW" TextMode="Password" placeholder="Password"></asp:TextBox>
		<asp:Button runat="server" ID="LoginButton" Text="로그인" OnClick="LoginButton_Click" />
	</form>

	<!-- Copyright -->
	<footer>
		<span>Copyright © 2018 Copyright 5th CNSA Student Council All Rights Reserved</span>
	</footer>

	<script src="/assets/js/jquery-3.3.1.slim.min.js"></script>
	<script src="/assets/js/popper.min.js"></script>
	<script src="/assets/js/bootstrap.min.js"></script>
</body>
</html>
