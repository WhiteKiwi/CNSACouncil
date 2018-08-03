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

	<!-- Projects -->
	<div class="p-5" style="margin-top: -15px;">
		<div class="row">
			<%
				var projects = CNSACouncil.Managers.ProjectManager.GetProjects();
				foreach (var project in projects) {
			%>
			<div class=" w-50 float-left p-2">
				<a href="/admin/Project.aspx?id=<%= project.ID %>">
					<img src="/assets/images/<%= project.FileName %>" width="100%" />
				</a>
				<% if (project.State == 0) { %>
				<button type="button" class="btn btn-lg btn-secondary btn-square w-100" data-toggle="modal" data-target="#completeModal">사업 완료</button>

				<div class="modal fade" id="completeModal" tabindex="-1" role="dialog" aria-labelledby="completeModalLabel" aria-hidden="true">
					<div class="modal-dialog" role="document">
						<form class="modal-content p-5" method="post" action="/admin/ProjectCheck.aspx">
							<h4 class="color-gray"><b>사업 마감일</b></h4>

							<div class="input-group mb-3">
								<input name="endAt" type="text" class="form-control" placeholder="yyyy-MM-dd" aria-label="Recipient's username" aria-describedby="button-addon">
								<div class="input-group-append">
									<button class="btn btn-outline-secondary" type="submit" id="button-addon">완료</button>
								</div>
							</div>

							<input name="id" type="hidden" value="<%= project.ID %>" />
						</form>
					</div>
				</div>
				<% } %>
			</div>
			<% } %>
		</div>
	</div>

	<!-- Navbar - Project Management-->
	<script>
		document.getElementById("nav4").classList.add("active");
	</script>
</asp:Content>
