﻿<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="CNSACouncil.Login" %>

<!DOCTYPE html>
<html class="login-html">
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />

	<!-- Title -->
	<title>충남삼성고등학교 학생회</title>

	<!-- Icon -->
	<link rel="shortcut icon" href="/assets/img/CSC.png" />

	<!-- Bootstrap CSS Framework -->
	<link rel="stylesheet" href="/assets/css/bootstrap.min.css?ver=0.3">

	<!-- Custom CSS -->
	<link rel="stylesheet" href="/assets/css/style.css?ver=0.8">
</head>
<body>
	<form runat="server">
		<div class="p-5 border border-secondary">
			<div class="text-center" style="margin-top: -15px; padding-right: 15px; padding-bottom: 10px;">
				<img src="/assets/img/Logo.png" width="330" />
			</div>
			<br />
			<div>
				<span>
					<asp:TextBox runat="server" ID="UserID" CssClass="form-control" placeholder="CNSAnet ID"></asp:TextBox><br />
					<asp:TextBox runat="server" ID="UserPW" CssClass="form-control" TextMode="Password" placeholder="CNSAnet PW"></asp:TextBox>
				</span>
				<span>
					<asp:Button runat="server" ID="LoginButton" CssClass="btn btn-lg btn-warning btn-square square" Text="로그인" OnClick="LoginButton_Click" />
				</span>
			</div>
		</div>
	</form>

	<!-- Copyright -->
	<footer>
		<span>Copyright © 2018 Copyright 5th CNSA Student Council All Rights Reserved</span>
	</footer>
</body>
</html>
