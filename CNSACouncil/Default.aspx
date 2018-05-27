<%@ Page Title="" Language="C#" MasterPageFile="~/masters/Students.Master" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="CNSACouncil.Default" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="Contents" runat="server">
	<!-- Top Image -->
	<img src="/assets/img/background-long.png" style="width: 100%;" />

	<!-- Main - Notice & Projects -->
	<div class="container-fluid main-contents row color-black">
		<!-- Notice -->
		<div class="float-left col-md-6">
			<hr class="hr-black" />
			<h3>Recent Notice</h3>
			<br />
			<div class="w-100 content-div">
				<a href="/" class="content-link">
					<h5 class="float-left">안녕하세요 5대 학생회 입니다.</h5>
				</a>
				<h5 class="float-right content-sub">2018-05-26</h5>
			</div>
			<br />
			<div class="w-100 content-div">
				<a href="/" class="content-link">
					<h5 class="float-left">안녕하세요 5대 학생회 입니다.</h5>
				</a>
				<h5 class="float-right content-sub">2018-05-26</h5>
			</div>
			<br />
			<div class="w-100 content-div">
				<a href="/" class="content-link">
					<h5 class="float-left">안녕하세요 5대 학생회 입니다.</h5>
				</a>
				<h5 class="float-right content-sub">2018-05-26</h5>
			</div>
			<br />
			<div class="w-100 content-div">
				<a href="/" class="content-link">
					<h5 class="float-left">안녕하세요 5대 학생회 입니다.</h5>
				</a>
				<h5 class="float-right content-sub">2018-05-26</h5>
			</div>
			<br />
			<div class="w-100 content-div">
				<a href="/" class="content-link">
					<h5 class="float-left">안녕하세요 5대 학생회 입니다.</h5>
				</a>
				<h5 class="float-right content-sub">2018-05-26</h5>
			</div>
			<br />
		</div>

		<!-- Projects -->
		<div class="float-right col-md-6">
			<hr class="hr-black" />
			<h3>Projects</h3>
			<br />
			<div class="w-100 content-div">
				<a href="/" class="content-link">
					<h5 class="float-left">학생회 홈페이지 제작 (2018-05-26~)</h5>
				</a>
				<h5 class="float-right content-sub color-gold">진행중</h5>
			</div>
			<br />
			<div class="w-100 content-div">
				<a href="/" class="content-link">
					<h5 class="float-left">MSMP 사업 (2018-05-26~)</h5>
				</a>
				<h5 class="float-right content-sub">진행완료</h5>
			</div>
			<br />
			<div class="w-100 content-div">
				<a href="/" class="content-link">
					<h5 class="float-left">학생회 홈페이지 제작 (2018-05-26~)</h5>
				</a>
				<h5 class="float-right content-sub color-gold">진행중</h5>
			</div>
			<br />
			<div class="w-100 content-div">
				<a href="/" class="content-link">
					<h5 class="float-left">MSMP 사업 (2018-05-26~)</h5>
				</a>
				<h5 class="float-right content-sub">진행완료</h5>
			</div>
			<br />
			<div class="w-100 content-div">
				<a href="/" class="content-link">
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
		<div class="petition-border">
			<div class="row">
				<div class="col-md-7 color-black">
					<h3 class="petition-border-title"><b>이거 진짜 바뀌어야 할 것 같지 않아요?</b></h3>
					<br />
					<h5 class="petition-border-content"><b>그쵸? 동의?</b></h5>
				</div>
				<div class="col-md-1"></div>
				<div class="col-md-4 color-black">
					<h6>등록인 :  최모양</h6>
					<h6 class="color-gold">동의 인원 :  99명</h6>
					<h6 class="right-date">등록 기간 :  2018-05-26</h6>
					<h6>&nbsp;~ 2018-06-26</h6>
					<br />
					<a href="/" class="btn btn-lg btn-secondary btn-square btn-long" role="button">자세히 보기</a>
				</div>
			</div>
		</div>
		<br />
		<br />
		<div class="petition-border">
			<div class="row">
				<div class="col-md-7 color-black">
					<h3 class="petition-border-title"><b>이거 진짜 바뀌어야 할 것 같지 않아요?</b></h3>
					<br />
					<h5 class="petition-border-content"><b>그쵸? 동의?</b></h5>
				</div>
				<div class="col-md-1"></div>
				<div class="col-md-4 color-black">
					<h6>등록인 :  최모양</h6>
					<h6 class="color-gold">동의 인원 :  99명</h6>
					<h6 class="right-date">등록 기간 :  2018-05-26</h6>
					<h6>&nbsp;~ 2018-06-26</h6>
					<br />
					<a href="/" class="btn btn-lg btn-secondary btn-square btn-long" role="button">자세히 보기</a>
				</div>
			</div>
		</div>
		<br />
		<br />
		<br />
		<div class="w-100 text-center">
			<a href="/" class="btn btn-lg btn-danger btn-square" role="button" style="padding-left: 90px; padding-right: 90px;">이슈 등록하기</a>
		</div>
		<br />
	</div>

	<!-- Navbar - HOME -->
	<script>
		document.getElementById("nav1").classList.add("active");
	</script>
</asp:Content>
