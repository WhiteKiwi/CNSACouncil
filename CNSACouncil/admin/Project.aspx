﻿<%@ Page Title="" Language="C#" MasterPageFile="~/masters/Admins.Master" AutoEventWireup="true" CodeBehind="Project.aspx.cs" Inherits="CNSACouncil.admin.AdminProject" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="Contents" runat="server">
	<!-- Top Image -->
	<img src="/assets/img/admin-banner.png" style="width: 100%;" />

	<%
		CNSACouncil.Models.Project project;

		int id;
		try {
			id = int.Parse(Request.QueryString["id"]);
			project = CNSACouncil.Managers.ProjectManager.GetProject(id);
		} catch (Exception e) {
			project = new CNSACouncil.Models.Project();
			project.Title = "존재하지 않는 사업입니다";
			project.Content = "존재하지 않는 사업입니다";
			project.StartAt = Convert.ToDateTime("2014-03-01");
			project.EndAt = Convert.ToDateTime("2014-03-01");
			project.State = 0;
		}
	%>

	<!-- 사업 -->
	<div class="p-5 color-black">
		<h3 class="p-2" style="color: #707070;">Project</h3>
		<div class="board-bar"></div>

		<div style="padding-left: 1.5rem; padding-right: 1.5rem;">
			<div class="float-left">
				<h5><b><%= project.Title %></b></h5>
			</div>
			<span class="float-right"><%= project.StartAt.ToString("yyyy-MM-dd") %> ~ <%= project.State == 1 ? project.EndAt.ToString("yyyy-MM-dd") : "" %></span>
			<div class="clearfix"></div>
		</div>
		<hr class="hr-board" />
		<div class="container p-4">
			<img src="/assets/images/<%= project.FileName %>" width="100%" />
			<br />
			<br />
			<%= project.Content %>
		</div>
	</div>

	<div class="text-right p-5" style="margin-right: 1.5rem;">
		<a href="/admin/ProjectManagement.aspx" class="btn btn-lg btn-warning btn-square" role="button">목록</a>
	</div>

	<!-- Navbar - Project -->
	<script>
		document.getElementById("nav4").classList.add("active");
	</script>
</asp:Content>
