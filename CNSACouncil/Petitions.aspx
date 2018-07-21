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
		<ul class="petition-tab border-bottom">
			<li class="border-right<%=order[0]%>"><a href="/Petitions.aspx">최신순</a></li>
			<li class="border-right<%=order[1]%>"><a href="/Petitions.aspx?order=best">참여순</a></li>
			<li class="border-right<%=order[2]%>"><a href="/Petitions.aspx?order=finished">만료된 청원</a></li>
			<li class="<%=order[3]%>"><a href="/Petitions.aspx?order=answer">답변된 청원</a></li>
		</ul>
	</div>

	<!-- Navbar - Petition -->
	<script>
		document.getElementById("nav3").classList.add("active");
	</script>
</asp:Content>
