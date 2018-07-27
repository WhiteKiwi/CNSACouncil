<%@ Page Title="" Language="C#" MasterPageFile="~/masters/Students.Master" AutoEventWireup="true" CodeBehind="APetition.aspx.cs" Inherits="CNSACouncil.APetition" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="Contents" runat="server">
	<!-- Top Image -->
	<img src="/assets/img/background-long.png" style="width: 100%;" />

	<!-- Petition 분류 선택 -->
	<% 
		int state;
		string[] order = { "", "", "", "" };
		if (Request.QueryString["order"] == "best") {
			order[1] = " active";
			state = 1;
		} else if (Request.QueryString["order"] == "finished") {
			order[2] = " active";
			state = 1;
		} else if (Request.QueryString["order"] == "answer") {
			order[3] = " active";
			state = 2;
		} else {
			order[0] = " active";
			state = 1;
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

	<!-- Get Petition -->
	<% CNSACouncil.Models.Petition petition = CNSACouncil.Managers.PetitionManager.GetPetitionByID(Request.QueryString["id"], state); %>
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

		<%if (state == 2) { %>
		<!-- 답변 존재 시 출력 -->
		<div class="p-2">
			<div style="background-color: #F3B120; height: 47px; width: 20px; float: left;"></div>
			<h3 class="color-gold" style="margin-left: 30px; padding-top: 6px;"><b>답변 내용</b></h3>
		</div>
		<br />
		<div class="p-4 border border-secondary" style="background-color: #F9F9F9;">
			<%= petition.Answer %>
		</div>
		<br />
		<% 
			} else {
				if (DateTime.Compare(petition.PetitionAt, DateTime.Now.AddMonths(-1)) >= 0) {
		%>
		<!-- 답변이 존재하지 않을 시 공감버튼 -->
		<br />
		<form runat="server" class="text-center">
			<asp:Button runat="server" ID="AgreeButton" CssClass="btn btn-lg btn-danger btn-square w-25" Text="공감하기" OnClick="AgreeButton_Click" />
		</form>
		<% 
				}
			}
		%>
	</div>
</asp:Content>
