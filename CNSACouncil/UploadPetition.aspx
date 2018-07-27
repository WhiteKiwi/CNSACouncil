<%@ Page Title="" Language="C#" MasterPageFile="~/masters/Students.Master" AutoEventWireup="true" CodeBehind="UploadPetition.aspx.cs" Inherits="CNSACouncil.UploadPetition" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="Contents" runat="server">
	<!-- Top Image -->
	<img src="/assets/img/background-long.png" style="width: 100%;" />

	<div class="container-fluid text-center">
		<!-- Notice box -->
		<div class="border-box-red color-red">
			<h3><b>청원 시 주의사항</b></h3>
			<div class="text-left m-3">
				<h4>1. 청원 페이지는 5대 학생회에서 학생들의 의견을 빠르게 수렴하고자 만든 페이지 입니다.</h4>
				<h4>2. 부적절한 언행이나 표현이 포함될 경우 ~~.</h4>
			</div>
		</div>

		<!-- Suggest box -->
		<form runat="server" style="margin: 30px 50px 30px 50px;">
			<div class="text-left">
				<h5 class="color-gray"><b>청원 제목</b></h5>
			</div>
			<asp:TextBox ID="PetitionTitle" runat="server" CssClass="w-100 form-control" placeholder="청원 제목을 입력하세요."></asp:TextBox>
			<br />
			<div class="text-left">
				<h5 class="color-gray"><b>청원 내용</b></h5>
			</div>
			<asp:TextBox ID="Content" runat="server" Rows="10" CssClass="w-100 form-control" TextMode="MultiLine" placeholder="청원 내용을 입력하세요."></asp:TextBox>
			<br />
			<br />
			<asp:Button runat="server" ID="PetitionButton" CssClass="btn btn-lg btn-warning btn-square w-25" Text="청원하기" OnClick="PetitionButton_Click" />
		</form>
	</div>
</asp:Content>
