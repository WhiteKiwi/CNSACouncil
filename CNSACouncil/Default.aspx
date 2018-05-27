<%@ Page Title="" Language="C#" MasterPageFile="~/masters/Students.Master" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="CNSACouncil.Default" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="Contents" runat="server">
	<!-- Top Image -->
	<img src="/assets/img/background-long.png" style="width: 100%;" />

	<!-- Main - Notice & Projects -->
	<div class="container-fluid main-contents row color-gray">
		<div class="float-left col-md-6">
			<hr class="hr-gray" />
			<h4>Recent Notice</h4>
		</div>
		<div class="float-right col-md-6">
			<hr class="hr-gray" />
			<h4>Projects</h4>
		</div>
	</div>

	<!-- Hot Issuse -->
	<div class="container-fluid float-none" style="padding: 60px;">
		<hr class="hr-red" />
		<h4 class="color-red">Hot Issues</h4>
		<br />
		<div class="petition-border">
			<div class="row">
				<div class="col-md-9 color-gray">
					<h3 style="color: #707070;"><b>이거 진짜 바뀌어야 할 것 같지 않아요?</b></h3>
					<br />
					<h5 style="margin-left: 30px;"><b>그쵸? 동의?</b></h5>
				</div>
				<div class="col-md-3 color-gray">
					<h6>등록인 :  최모양</h6>
					<h6 class="color-gold">동의 인원 :  99명</h6>
					<h6>등록 기간 :  2018-05-26 ~ 2018-06-26</h6>
					<br />
					<a href="/" class="btn btn-lg btn-secondary btn-square" role="button">자세히 보기</a>
				</div>
			</div>
		</div>
		<br />
		<br />
		<div class="petition-border">
			<div class="row">
				<div class="col-md-9 color-gray">
					<h3 style="color: #707070;"><b>이거 진짜 바뀌어야 할 것 같지 않아요?</b></h3>
					<br />
					<h5 style="margin-left: 30px;"><b>그쵸? 동의?</b></h5>
				</div>
				<div class="col-md-3 color-gray">
					<h6>등록인 :  최모양</h6>
					<h6 class="color-gold">동의 인원 :  99명</h6>
					<h6>등록 기간 :  2018-05-26 ~ 2018-06-26</h6>
					<br />
					<a href="/" class="btn btn-lg btn-secondary btn-square" role="button">자세히 보기</a>
				</div>
			</div>
		</div>
		<br />
		<br />
		<br />
		<div class="w-100 text-center">
			<a href="/" class="btn btn-lg btn-danger btn-square" role="button">이슈 등록하기</a>
		</div>
		<br />
	</div>

	<!-- Navbar - HOME -->
	<script>
		document.getElementById("nav1").classList.add("active");
	</script>
</asp:Content>
