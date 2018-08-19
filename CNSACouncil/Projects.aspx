<%@ Page Title="" Language="C#" MasterPageFile="~/masters/Students.Master" AutoEventWireup="true" CodeBehind="Projects.aspx.cs" Inherits="CNSACouncil.Projects" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="Contents" runat="server">
	<!-- Top Image -->
	<img src="/assets/img/projects-banner.png" style="width: 100%;" />

	<!-- Project 분류 선택 -->
	<% 
		int state;
		string[] order = { "", "" };
		if (Request.QueryString["state"] == "finished") {
			order[1] = " active";
			state = 1;
		} else {
			order[0] = " active";
			state = 0;
		}
	%>
	<!-- Project Tab -->
	<div>
		<ul class="selection-tab border-bottom">
			<li class="border-right<%=order[0]%>" style="width: 33.3%;"><a href="/Projects.aspx">진행중인 사업</a></li>
			<li class="border-right<%=order[1]%>" style="width: 33.3%;"><a href="/Projects.aspx?state=finished">완료된 사업</a></li>
			<li style="width: 33.3%;"><a href="/Suggest.aspx">건의하기</a></li>
		</ul>
	</div>

	<!-- Projects -->
	<div class="p-5" style="margin-top: -15px;">
		<div class="row">
			<%
				var projects = CNSACouncil.Managers.ProjectManager.GetProjectsByState(state);
				foreach (var project in projects) {
			%>
			<div class="col-md-6 p-2">
				<h1 class="project-name"><b><%= project.Title %></b></h1>
				<a href="/Project.aspx?id=<%= project.ID %>&state=<%= state %>">
				<img src="/assets/images/<%= project.FileName %>" width="100%" />
				</a>
			</div>
			<% } %>
		</div>
	</div>

	<!-- Navbar - 학생회 사업 -->
	<script>
		document.getElementById("nav4").classList.add("active");
	</script>
</asp:Content>
