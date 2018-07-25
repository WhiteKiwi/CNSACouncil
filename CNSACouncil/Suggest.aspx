<%@ Page Title="" Language="C#" MasterPageFile="~/masters/Students.Master" AutoEventWireup="true" CodeBehind="Suggest.aspx.cs" Inherits="CNSACouncil.Suggest" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="Contents" runat="server">
	<!-- Top Image -->
	<img src="/assets/img/background-long.png" style="width: 100%;" />

	<!-- Project Tab -->
	<div>
		<ul class="selection-tab border-bottom">
			<li class="border-right" style="width: 33.3%;"><a href="/Projects.aspx">진행중인 사업</a></li>
			<li class="border-right" style="width: 33.3%;"><a href="/Projects.aspx?state=finished">완료된 사업</a></li>
			<li class="active" style="width: 33.3%;"><a href="/Suggest.aspx">건의하기</a></li>
		</ul>
	</div>

	<div class="container-fluid text-center">
		<!-- Notice box -->
		<div class="border-box-red color-red">
			<h3><b>건의 시 주의사항</b></h3>
			<div class="text-left m-3">
				<h4>1. 건의사항은 5대 학생회에서 학생들의 의견을 빠르게 수렴하고자 만든 페이지 입니다.</h4>
				<h4>2. 부적절한 언행이나 표현이 포함될 경우 ~~.</h4>
			</div>
		</div>

		<!-- Suggest box -->
		<form runat="server" style="margin: 30px 50px 30px 50px;">
			<asp:TextBox ID="SuggestionTitle" runat="server" CssClass="w-100 form-control" placeholder="제목"></asp:TextBox>
			<br />
			<asp:TextBox ID="Content" runat="server" Rows="10" CssClass="w-100 form-control" TextMode="MultiLine" placeholder="내용"></asp:TextBox>
			<br />
			<br />

			<asp:Button runat="server" ID="SuggestButton" CssClass="btn btn-lg btn-warning btn-square w-25" Text="건의하기" OnClick="SuggestButton_Click" />
		</form>
	</div>

	<!-- Navbar - 학생회 사업 -->
	<script>
		document.getElementById("nav4").classList.add("active");
	</script>
</asp:Content>
