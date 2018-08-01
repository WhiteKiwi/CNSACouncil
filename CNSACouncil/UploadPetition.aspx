<%@ Page Title="" Language="C#" MasterPageFile="~/masters/Students.Master" AutoEventWireup="true" CodeBehind="UploadPetition.aspx.cs" Inherits="CNSACouncil.UploadPetition" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="Contents" runat="server">
	<!-- Top Image -->
	<img src="/assets/img/background-long.png" style="width: 100%;" />

	<div class="container-fluid text-center">
		<!-- Notice box -->
		<div class="border-box-red" style="padding-bottom: 5px;">
			<h3 class="color-red" style="margin-left: 20px;"><b>청원 시 주의사항</b></h3>
			<div class="m-4 color-gray">
				<h5>1. 청원하기와 건의하기는 구분하여 사용해주시기 바랍니다.</h5>
				<h5>2. </h5>
			</div>
		</div>

		<!-- Suggest box -->
		<form runat="server" style="margin: 30px 50px 30px 50px;">
			<div class="text-left">
				<h5 class="color-gray"><b>청원 제목</b></h5>
			</div>
			<asp:TextBox ID="PetitionTitle" runat="server" CssClass="w-100 form-control" placeholder="청원 제목을 입력하세요"></asp:TextBox>
			<br />
			<div class="text-left">
				<h5 class="color-gray"><b>청원 내용</b></h5>
			</div>
			<asp:TextBox ID="Content" runat="server" Rows="10" CssClass="w-100 form-control" TextMode="MultiLine" placeholder="청원 내용을 입력하세요"></asp:TextBox>
			<br />
			<br />
			<asp:Button runat="server" ID="PetitionButton" CssClass="btn btn-lg btn-warning btn-square w-25" Text="청원하기" OnClick="PetitionButton_Click" />
		</form>
	</div>
</asp:Content>
