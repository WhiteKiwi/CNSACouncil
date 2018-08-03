<%@ Page Title="" Language="C#" MasterPageFile="~/masters/Admins.Master" AutoEventWireup="true" CodeBehind="ProjectManagement.aspx.cs" Inherits="CNSACouncil.admin.ProjectManagement" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="Contents" runat="server">
	<!-- Top Image -->
	<img src="/assets/img/background-long.png" style="width: 100%;" />

	<!-- Project Tab -->
	<div>
		<ul class="selection-tab border-bottom">
			<li class="border-right w-50"><a href="/admin/AddProject.aspx">사업 등록</a></li>
			<li class="border-right w-50 active"><a href="/admin/ProjectManagement.aspx">사업 관리</a></li>
		</ul>
	</div>

	<!-- Navbar - Project Management-->
	<script>
		document.getElementById("nav4").classList.add("active");
	</script>
</asp:Content>
