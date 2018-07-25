<%@ Page Title="" Language="C#" MasterPageFile="~/masters/Admins.Master" AutoEventWireup="true" CodeBehind="AdminManagement.aspx.cs" Inherits="CNSACouncil.admin.AdminManagement" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="Contents" runat="server">
	<!-- Comming Soon -->
	<div class="text-center p-5 petition-box" style="margin: 50px;">
		<img src="/assets/img/CommingSoon.png" width="600" />
	</div>
	
	<!-- Navbar - Admin Management-->
	<script>
		document.getElementById("nav5").classList.add("active");
	</script>
</asp:Content>
