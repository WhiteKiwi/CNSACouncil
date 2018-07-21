<%@ Page Title="" Language="C#" MasterPageFile="~/masters/Students.Master" AutoEventWireup="true" CodeBehind="Projects.aspx.cs" Inherits="CNSACouncil.Projects" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="Contents" runat="server">
	<!-- Top Image -->
	<img src="/assets/img/background-long.png" style="width: 100%;" />

	<!-- Project 분류 선택 -->
	<% 
		string[] order = { "", "" };
		if (Request.QueryString["state"] == "finished") {
			order[1] = " active";
		} else {
			order[0] = " active";
		}
	%>
	<!-- Project Tab -->
	<div>
		<ul class="selection-tab border-bottom">
			<li class="border-right<%=order[0]%>" style="width: 33.3%;"><a href="/Projects.aspx">진행중인 사업</a></li>
			<li class="border-right<%=order[1]%>" style="width: 33.3%;"><a href="/Projects.aspx?state=finished">완료된 사업</a></li>
			<li style="width: 33.3%;"><a href="/Suggest.aspx">건의하기</a></li>
		</ul>
	</div>

	<!-- Navbar - 학생회 사업 -->
	<script>
		document.getElementById("nav4").classList.add("active");
	</script>
</asp:Content>
