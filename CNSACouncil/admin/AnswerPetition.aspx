<%@ Page Title="" Language="C#" MasterPageFile="~/masters/Admins.Master" AutoEventWireup="true" CodeBehind="AnswerPetition.aspx.cs" Inherits="CNSACouncil.admin.AnswerPetition" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="Contents" runat="server">
	<!-- Top Image -->
	<img src="/assets/img/background-long.png" style="width: 100%;" />

	<!-- Petition Tab -->
	<!-- Petition Tab -->
	<div>
		<ul class="selection-tab border-bottom">
			<li class="border-right" style="width: 33.3%;"><a href="/admin/PetitionManagement.aspx">승인 대기중</a></li>
			<li class="border-right active" style="width: 33.3%;"><a href="/admin/PetitionManagement.aspx?state=awaitingAnswer">답변 대기중</a></li>
			<li class="border-right" style="width: 33.3%;"><a href="/admin/PetitionManagement.aspx?state=delayed">지연됨</a></li>
		</ul>
	</div>

	<!-- Get Petition -->
	<% CNSACouncil.Models.Petition petition = CNSACouncil.Managers.PetitionManager.GetPetitionByID(Request.QueryString["id"], 1); %>
	<!-- Content -->
	<div class="border border-secondary m-5 p-5">
		<h4><b><%= petition.Title %></b></h4>
		<div class="color-gray p-2">
			<span>등록인: <%= petition.UserID.Substring(0, 2) + "****" %></span><span style="margin: 20px;">｜</span><span>청원기간 :  <%= petition.PetitionAt.ToString("yyyy-MM-dd") %> ~ <%= petition.PetitionAt.AddMonths(1).ToString("yyyy-MM-dd") %></span><span style="margin: 20px;">｜</span><span class="color-red"><%= petition.Agrees %>명의 공감</span>
		</div>
		<br />
		<div class="color-black"><%= petition.Content %></div>
		<br />
		<hr class="hr-gray" />
		<div class="p-2">
			<div style="background-color: #F3B120; height: 47px; width: 20px; float: left;"></div>
			<h3 class="color-gold" style="margin-left: 30px; padding-top: 6px;"><b>답변 내용</b></h3>
		</div>
		<br />
		<form runat="server">
			<asp:TextBox runat="server" ID="AnswerContent" CssClass="form-control" TextMode="MultiLine" Rows="10" placeholder="답변 내용을 입력하세요."></asp:TextBox>
			<br />
			<br />
			<div class="text-center">
				<asp:Button runat="server" ID="AnswerButton" CssClass="btn btn-lg btn-danger btn-square w-25" Text="답변하기" OnClick="AnswerButton_Click" />
			</div>
		</form>
	</div>
</asp:Content>
