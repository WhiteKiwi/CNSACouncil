<%@ Page Title="" Language="C#" MasterPageFile="~/masters/Students.Master" AutoEventWireup="true" CodeBehind="Timeline.aspx.cs" Inherits="CNSACouncil.Timeline" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="Contents" runat="server">
	<!-- Top Image -->
	<img src="/assets/img/background-long.png" style="width: 100%;" />

	<!-- About Us Tab -->
	<div>
		<ul class="selection-tab border-bottom">
			<li class="border-right w-50"><a href="/AboutUs.aspx">학생회 소개</a></li>
			<li class="w-50 active"><a href="/TimeLine.aspx">TIMELINE</a></li>
		</ul>
	</div>

	<!-- Navbar - About Us -->
	<script>
		document.getElementById("nav5").classList.add("active");
	</script>
</asp:Content>
