<%@ Page Title="" Language="C#" MasterPageFile="~/masters/Students.Master" AutoEventWireup="true" CodeBehind="Petitions.aspx.cs" Inherits="CNSACouncil.Petitions" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="Contents" runat="server">
	<!-- Top Image -->
	<img src="/assets/img/background-long.png" style="width: 100%;" />

	<!-- Petition 분류 선택 -->
	<% 
		string[] order = { "", "", "", "" };
		if (Request.QueryString["order"] == "best") {
			order[1] = " active";
		} else if (Request.QueryString["order"] == "finished") {
			order[2] = " active";
		} else if (Request.QueryString["order"] == "answer") {
			order[3] = " active";
		} else {
			order[0] = " active";
		}
	%>
	<!-- Petition Tab -->
	<div>
		<ul class="selection-tab border-bottom">
			<li class="border-right<%=order[0]%> w-25"><a href="/Petitions.aspx">최신순</a></li>
			<li class="border-right<%=order[1]%> w-25"><a href="/Petitions.aspx?order=best">참여순</a></li>
			<li class="border-right<%=order[2]%> w-25"><a href="/Petitions.aspx?order=finished">만료된 청원</a></li>
			<li class="<%=order[3]%> w-25"><a href="/Petitions.aspx?order=answer">답변된 청원</a></li>
		</ul>
	</div>

	<!-- Notice box -->
	<div class="border-box-gold text-center">
		<h3>청원게시판은 5대 학생회의 공약 중 하나로 학생들의 여론을 빠르게 수렴하기 위해 만들어졌습니다.</h3>
		<br />
		<a href="/" class="btn btn-lg btn-warning btn-square w-25" role="button">지금 청원하기</a>
	</div>

	<!-- Comming Soon -->
	<div class="text-center p-5 petition-box" style="margin: 50px;">
		<img src="/assets/img/CommingSoon.png" width="600" />
	</div>

	<!-- Navbar - Petition -->
	<script>
		document.getElementById("nav3").classList.add("active");
	</script>
</asp:Content>
