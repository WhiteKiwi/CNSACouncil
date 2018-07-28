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
			<div class="w-100 content-div">
				<a href="/" class="content-link notice">
					<h5 class="float-left">안녕하세요 5대 학생회 입니다.</h5>
				</a>
				<h5 class="float-right content-sub">2018-05-26</h5>
			</div>
			<br />
			<div class="w-100 content-div">
				<a href="/" class="content-link notice">
					<h5 class="float-left">안녕하세요 5대 학생회 입니다.</h5>
				</a>
				<h5 class="float-right content-sub">2018-05-26</h5>
			</div>
			<br />
			<div class="w-100 content-div">
				<a href="/" class="content-link notice">
					<h5 class="float-left">안녕하세요 5대 학생회 입니다.</h5>
				</a>
				<h5 class="float-right content-sub">2018-05-26</h5>
			</div>
			<br />
			<div class="w-100 content-div">
				<a href="/" class="content-link notice">
					<h5 class="float-left">안녕하세요 5대 학생회 입니다.</h5>
				</a>
				<h5 class="float-right content-sub">2018-05-26</h5>
			</div>
			<br />
			<div class="w-100 content-div">
				<a href="/" class="content-link notice">
					<h5 class="float-left">안녕하세요 5대 학생회 입니다.</h5>
				</a>
				<h5 class="float-right content-sub">2018-05-26</h5>
			</div>
			<br />
		</div>

		<!-- Projects -->
		<div class="float-right col-md-6" style="padding-left: 30px;">
			<hr class="hr-black" />
			<h3>Projects</h3>
			<br />
			<div class="w-100 content-div">
				<a href="/" class="content-link project">
					<h5 class="float-left">학생회 홈페이지 제작 (2018-05-26~)</h5>
				</a>
				<h5 class="float-right content-sub color-gold">진행중</h5>
			</div>
			<br />
			<div class="w-100 content-div">
				<a href="/" class="content-link project">
					<h5 class="float-left">MSMP 사업 (2018-05-26~)</h5>
				</a>
				<h5 class="float-right content-sub">진행완료</h5>
			</div>
			<br />
			<div class="w-100 content-div">
				<a href="/" class="content-link project">
					<h5 class="float-left">학생회 홈페이지 제작 (2018-05-26~)</h5>
				</a>
				<h5 class="float-right content-sub color-gold">진행중</h5>
			</div>
			<br />
			<div class="w-100 content-div">
				<a href="/" class="content-link project">
					<h5 class="float-left">MSMP 사업 (2018-05-26~)</h5>
				</a>
				<h5 class="float-right content-sub">진행완료</h5>
			</div>
			<br />
			<div class="w-100 content-div">
				<a href="/" class="content-link project">
					<h5 class="float-left">학생회 홈페이지 제작 (2018-05-26~)</h5>
				</a>
				<h5 class="float-right content-sub color-gold">진행중</h5>
			</div>
			<br />
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
					<h3 class="petition-box-title"><b><%= petition.Title %></b></h3>
					<br />
					<h5 class="petition-box-content"><b><%= petition.Content.Length > 120 ? petition.Content.Substring(0, 120) + "..." : petition.Content %></b></h5>
				</div>
				<div class="col-md-1"></div>
				<div class="col-md-4 color-black">
					<h5>등록인 :  <%= petition.UserID.Substring(0, 2) + "****" %></h5>
					<h5 class="color-gold">동의 인원 :  <%= petition.Agrees %>명</h5>
					<h5 class="right-date">등록 기간 :  <%= petition.PetitionAt.ToString("yyyy-MM-dd") %></h5>
					<h5>&nbsp;~ <%= petition.PetitionAt.AddMonths(1).ToString("yyyy-MM-dd") %></h5>
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
