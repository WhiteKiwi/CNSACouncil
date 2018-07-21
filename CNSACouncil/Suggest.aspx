<%@ Page Title="" Language="C#" MasterPageFile="~/masters/Students.Master" AutoEventWireup="true" CodeBehind="Suggest.aspx.cs" Inherits="CNSACouncil.Suggest" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="Contents" runat="server">
	<!-- Top Image -->
	<img src="/assets/img/background-long.png" style="width: 100%;" />

	<!-- Project Tab -->
	<div>
		<ul class="project-tab border-bottom">
			<li class="border-right"><a href="/Projects.aspx">진행중인 사업</a></li>
			<li class="border-right"><a href="/Projects.aspx?state=finished">완료된 사업</a></li>
			<li class="active"><a href="/Suggest.aspx">건의하기</a></li>
		</ul>
	</div>

	<!-- Navbar - 학생회 사업 -->
	<script>
		document.getElementById("nav4").classList.add("active");
	</script>
</asp:Content>
