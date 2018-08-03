<%@ Page Title="" Language="C#" MasterPageFile="~/masters/Students.Master" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="CNSACouncil.Default" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="Contents" runat="server">
	<!-- Top Image -->
	<img src="/assets/img/background-long.png" style="width: 100%;" />

	<!-- Main - Notice & Projects -->
	<div class="container-fluid main-contents row color-black">
		<!-- Notice -->
		<div class="float-left col-md-6" style="padding-left: 60px;">
			<hr class="hr-black" />
			<h3>Recent Notice</h3>
			<br />

			<% var notices = CNSACouncil.Managers.NoticeManager.GetNoticesByNoticeAt(5);

				foreach (var notice in notices) { %>
			<div class="w-100 content-div">
				<a href="/Notice.aspx?id=<%= notice.ID %>" class="content-link notice">
					<h5 class="float-left"><%= notice.Title %></h5>
				</a>
				<h5 class="float-right content-sub"><%= notice.NoticeAt.ToString("yyyy-MM-dd") %></h5>
			</div>
			<br />
			<% } %>
		</div>

		<!-- Projects -->
		<div class="float-right col-md-6" style="padding-left: 30px;">
			<hr class="hr-black" />
			<h3>Projects</h3>
			<br />

			<% var projects = CNSACouncil.Managers.ProjectManager.GetProjectsByStartAt(5);

				foreach (var project in projects) {
					bool isEnd = project.EndAt.ToString("yyyy-MM-dd") == "2014-03-01" ? false : true;
			%>
			<div class="w-100 content-div">
				<a href="/Project.aspx?id=<%= project.ID %>" class="content-link project">
					<h5 class="float-left"><%= project.Title %> (<%= project.StartAt.ToString("yyyy-MM-dd") %> ~ <%= isEnd ? project.EndAt.ToString("yyyy-MM-dd") : "" %>)</h5>
				</a>
				<h5 class="float-right content-sub color-<%= isEnd ? "gold" : "black" %>"><%= isEnd ? "진행 완료" : "진행중" %></h5>
			</div>
			<br />
			<% } %>
		</div>
	</div>

	<!-- Hot Issuse -->
	<div class="container-fluid float-none" style="padding: 60px;">
		<hr class="hr-red" />
		<h3 class="color-red">Hot Issues</h3>
		<br />
		<% var petitions = CNSACouncil.Managers.PetitionManager.GetPetitionsByAgrees(2);
			foreach (var petition in petitions) { %>
		<div class="petition-box">
			<div class="row">
				<div class="col-md-7 color-black">
					<h3 class="petition-box-title"><b><%= petition.Title.Length > 18 ? petition.Title.Substring(0, 18) + "..." : petition.Title %></b></h3>
					<br />
					<h5 class="petition-box-content"><%= petition.Content.Replace("<br/>", " ").Length > 170 ? petition.Content.Replace("<br/>", " ").Substring(0, 170) + "..." : petition.Content %></h5>
				</div>
				<div class="col-md-1"></div>
				<div class="col-md-4 color-black">
					<br>
					<h6>등록인 :  <%= petition.UserID.Substring(0, 2) + "****" %></h6>
					<h6 class="color-gold">동의 인원 :  <%= petition.Agrees %>명</h6>
					<h6 class="right-date">등록 기간 :  <%= petition.PetitionAt.ToString("yyyy-MM-dd") %></h6>
					<h6>&nbsp;~ <%= petition.PetitionAt.AddMonths(1).ToString("yyyy-MM-dd") %></h6>
					<br />
					<a href="/Petition.aspx?order=best&id=<%= petition.ID %>" class="btn btn-lg btn-secondary btn-square btn-long" role="button">자세히 보기</a>
				</div>
			</div>
		</div>
		<br />
		<% } %>
	</div>

	<!-- Comming Soon -->
	<div class="text-center p-5 petition-box" style="margin-left: 60px; margin-right: 60px;">
		<img src="/assets/img/CommingSoon.png" width="600" />
	</div>
	<br />
	<br />

	<!-- Navbar - HOME -->
	<script>
		document.getElementById("nav1").classList.add("active");
	</script>
</asp:Content>
