<%@ Page Title="" Language="C#" MasterPageFile="~/masters/Students.Master" AutoEventWireup="true" CodeBehind="Petition.aspx.cs" Inherits="CNSACouncil.APetition" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="Contents" runat="server">
	<!-- Top Image -->
	<img src="/assets/img/background-long.png" style="width: 100%;" />

	<form runat="server">
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
		<div class="border border-secondary m-5 p-5" style="position: relative;">
			<%if (state == 2) { %>
			<div class="answer-rectangle">
				<span>답변<br />
					완료</span>
			</div>
			<% } %>
			<h4><b><%= petition.Title %></b></h4>
			<div class="color-gray p-2">
				<span>등록인: <%= petition.UserID.Substring(0, 2) + "****" %></span><span style="margin: 20px;">｜</span><span>청원기간 :  <%= petition.PetitionAt.ToString("yyyy-MM-dd") %> ~ <%= petition.PetitionAt.AddDays(30).ToString("yyyy-MM-dd") %></span><span style="margin: 20px;">｜</span><span class="color-red"><%= petition.Agrees %>명의 공감</span>
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
					if (DateTime.Compare(petition.PetitionAt, DateTime.Now.AddDays(-30)) >= 0) {
			%>
			<!-- 답변이 존재하지 않을 시 공감버튼 -->
			<br />
			<div class="text-center">
				<asp:Button runat="server" ID="AgreeButton" CssClass="btn btn-lg btn-danger btn-square w-25" Text="공감하기" OnClick="AgreeButton_Click" />
			</div>
			<% 
					}
				}
			%>
		</div>

		<div runat="server" class="p-5" style="padding-top: 0 !important;">
			<div class="board-bar-gold"></div>
			<h4 class="color-gold">COMMENT</h4>
			<div style="margin-top: 15px;">
				<div style="width: calc(100% - 120px); float: left; margin-right: 15px;">
					<asp:TextBox runat="server" ID="Content" CssClass="form-control noresize" TextMode="MultiLine" Rows="3" placeholder="댓글 작성 시 주의사항:&#10;로그인 후에만 댓글 등록이 가능합니다.&#10;한 번 작성한 댓글은 삭제 할 수 없으니 신중하게 생각하고 댓글을 작성해 주세요."></asp:TextBox>
				</div>
				<div>
					<asp:Button runat="server" ID="CommentButton" CssClass="btn btn-lg btn-warning btn-square" Text="등록" Style="width: 86px; height: 86px;" OnClick="CommentButton_Click" />
				</div>
			</div>
			<br />
			<div class="board-bar"></div>
			<%
				var commentList = CNSACouncil.Managers.CommentManager.GetComments(int.Parse(Request.QueryString["id"]), 1);

				foreach (var comment in commentList) {
			%>
			<div class="comment-element">
				<span><%= comment.WriterID %></span>
				<span><%= comment.Content %></span>
				<span><%= comment.CommentAt.ToString("yyyy-MM-dd '/' HH:mm") %></span>
			</div>
			<% } %>
		</div>
	</form>
	<!-- Navbar - Petition -->
	<script>
		document.getElementById("nav3").classList.add("active");
	</script>
</asp:Content>
