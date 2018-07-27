﻿<%@ Page Title="" Language="C#" MasterPageFile="~/masters/Admins.Master" AutoEventWireup="true" CodeBehind="AllowPetition.aspx.cs" Inherits="CNSACouncil.admin.AllowPetition" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="Contents" runat="server">
	<!-- Top Image -->
	<img src="/assets/img/background-long.png" style="width: 100%;" />

	<!-- Petition Tab -->
	<div>
		<ul class="selection-tab border-bottom">
			<li class="border-right active w-50"><a href="/admin/PetitionManagement.aspx">승인 대기중</a></li>
			<li class="border-right w-50"><a href="/admin/PetitionManagement.aspx?state=awaitingAnswer">답변 대기중</a></li>
		</ul>
	</div>

	<!-- Get Petition -->
	<% CNSACouncil.Models.Petition petition = CNSACouncil.Managers.PetitionManager.GetPetitionByID(Request.QueryString["id"], 0); %>
	<!-- Content -->
	<div class="border border-secondary m-5 p-5">
		<h4><b><%= petition.Title %></b></h4>
		<div class="color-gray p-2">
			<span>등록인: <%= petition.UserID.Substring(0, 2) + "****" %></span><span style="margin: 20px;">｜</span><span>청원기간 :  <%= petition.PetitionAt.ToString("yyyy-MM-dd") %> ~ <%= petition.PetitionAt.AddMonths(1).ToString("yyyy-MM-dd") %></span><span style="margin: 20px;">｜</span><span class="color-red"><%= CNSACouncil.Managers.PetitionManager.GetAgreesCount(petition.ID) %>명의 동의</span>
		</div>
		<br />
		<div class="color-black"><%= petition.Content %></div>
		<br />
		<hr class="hr-gray" />
		<br />
		<form runat="server" class="text-center">
				<asp:Button runat="server" ID="AllowButton" CssClass="btn btn-lg btn-danger btn-square w-25" Text="승인하기" OnClick="AllowButton_Click" />
		</form>
	</div>
</asp:Content>
