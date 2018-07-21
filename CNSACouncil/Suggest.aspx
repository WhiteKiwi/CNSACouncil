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
		<div class="border-box-red">
			<h3 class="color-red"><b>건의 시 주의사항</b></h3>
		</div>

		<!-- Suggest box -->
		<form runat="server" style="margin: 30px 50px 30px 50px;">
			<asp:TextBox ID="Content" runat="server" Rows="20" CssClass="w-100" TextMode="MultiLine"></asp:TextBox>
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
