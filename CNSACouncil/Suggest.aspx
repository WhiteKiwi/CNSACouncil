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
		<div class="border-box-red" style="padding-bottom: 5px;">
			<h3 class="color-red" style="margin-left: 20px;"><b>건의 시 주의사항</b></h3>
			<div class="container text-left m-4 color-gray">
				<h5>1. 청원하기와 건의하기는 구분하여 사용해주시기 바랍니다.</h5>
				<h5>2. 건의사항에는 편안한 표현을 사용해주시길 부탁드립니다.</h5>
				<h5>3. 장난성 건의는 삼가 주시기 바랍니다.</h5>
				<h5>4. 건의 결과는 공지사항에 게시됩니다.</h5>
			</div>
		</div>

		<!-- Suggest box -->
		<form runat="server" style="margin: 30px 50px 30px 50px;">
			<asp:TextBox ID="SuggestionTitle" runat="server" CssClass="w-100 form-control" placeholder="제목을 입력하세요"></asp:TextBox>
			<br />
			<asp:TextBox ID="Content" runat="server" Rows="10" CssClass="w-100 form-control" TextMode="MultiLine" placeholder="내용을 입력하세요"></asp:TextBox>
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
