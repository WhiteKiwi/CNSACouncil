<%@ Page Title="" Language="C#" MasterPageFile="~/masters/Admins.Master" AutoEventWireup="true" CodeBehind="SuggestionManagement.aspx.cs" Inherits="CNSACouncil.admin.SuggestionManagement" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="Contents" runat="server">
	<!-- Top Image -->
	<img src="/assets/img/background-long.png" style="width: 100%;" />
	
	<!-- 건의 분류 선택 -->
	<% 
		string[] order = { "", "" };
		if (Request.QueryString["order"] == "last") {
			order[1] = " active";
		} else {
			order[0] = " active";
		}
	%>
	<!-- Petition Tab -->
	<div>
		<ul class="selection-tab border-bottom">
			<li class="border-right<%=order[0]%> w-50"><a href="/admin/SuggestionManagement.aspx">새로운 건의</a></li>
			<li class="<%=order[1]%> w-50"><a href="/admin/SuggestionManagement.aspx?order=last">지난 건의</a></li>
		</ul>
	</div>

	<!-- Navbar - Suggestion Management-->
	<script>
		document.getElementById("nav2").classList.add("active");
	</script>
</asp:Content>
