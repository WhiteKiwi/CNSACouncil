﻿<%@ Page Title="" Language="C#" MasterPageFile="~/masters/Admins.Master" AutoEventWireup="true" CodeBehind="AllowPetition.aspx.cs" Inherits="CNSACouncil.admin.AllowPetition" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="Contents" runat="server">
	<!-- Top Image -->
	<img src="/assets/img/admin-banner.png" style="width: 100%;" />

	<!-- Petition Tab -->
	<div>
		<ul class="selection-tab border-bottom">
			<li class="border-right active" style="width: 33.3%;"><a href="/admin/PetitionManagement.aspx">승인 대기중</a></li>
			<li class="border-right" style="width: 33.3%;"><a href="/admin/PetitionManagement.aspx?state=awaitingAnswer">답변 대기중</a></li>
			<li class="border-right" style="width: 33.3%;"><a href="/admin/PetitionManagement.aspx?state=delayed">지연됨</a></li>
		</ul>
	</div>

	<!-- Get Petition -->
	<% CNSACouncil.Models.Petition petition = CNSACouncil.Managers.PetitionManager.GetPetitionByID(Request.QueryString["id"], 0); %>
	<!-- Content -->
	<div class="border border-secondary m-5 p-5">
		<h4><b><%= petition.Title %></b></h4>
		<div class="color-gray p-2">
			<span>등록인: <%= petition.UserID.Substring(0, 2) + "****" %></span><span style="margin: 20px;">｜</span><span>청원기간 :  <%= petition.PetitionAt.ToString("yyyy-MM-dd") %> ~ <%= petition.PetitionAt.AddDays(30).ToString("yyyy-MM-dd") %></span><span style="margin: 20px;">｜</span><span class="color-red"><%= petition.Agrees %>명의 공감</span>
		</div>
		<br />
		<div class="color-black"><%= petition.Content %></div>
		<br />
		<hr class="hr-gray" />
		<br />
		<form runat="server" class="text-center">
			<asp:Button runat="server" ID="AllowButton" CssClass="btn btn-lg btn-danger btn-square w-25" Text="승인하기" OnClick="AllowButton_Click" />
			<asp:Button runat="server" ID="DelayButton" CssClass="btn btn-lg btn-warning btn-square w-25" Text="지연하기" OnClick="DelayButton_Click" />
		</form>
	</div>

	<!-- Navbar - Petition Management-->
	<script>
		document.getElementById("nav3").classList.add("active");
	</script>
</asp:Content>
