﻿<%@ Page Title="" Language="C#" MasterPageFile="~/masters/Admins.Master" AutoEventWireup="true" CodeBehind="ProjectManagement.aspx.cs" Inherits="CNSACouncil.admin.ProjectManagement" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="Contents" runat="server">
	<!-- Comming Soon -->
	<div class="text-center p-5 petition-box" style="margin: 50px;">
		<img src="/assets/img/CommingSoon.png" width="600" />
	</div>

	<!-- Navbar - Project Management-->
	<script>
		document.getElementById("nav4").classList.add("active");
	</script>
</asp:Content>