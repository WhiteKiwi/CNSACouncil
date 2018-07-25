<%@ Page Title="" Language="C#" MasterPageFile="~/masters/Students.Master" AutoEventWireup="true" CodeBehind="Notices.aspx.cs" Inherits="CNSACouncil.Notices" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="Contents" runat="server">
	<!-- Comming Soon -->
	<div class="text-center p-5 petition-box" style="margin: 50px;">
		<img src="/assets/img/CommingSoon.png" width="600" />
	</div>

	<!-- Navbar - Notice -->
	<script>
		document.getElementById("nav2").classList.add("active");
	</script>
</asp:Content>
