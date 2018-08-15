<%@ Page Title="" Language="C#" MasterPageFile="~/masters/Students.Master" AutoEventWireup="true" CodeBehind="Notice.aspx.cs" Inherits="CNSACouncil.ANotice" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="Contents" runat="server">
	<!-- Top Image -->
	<img src="/assets/img/background-long.png" style="width: 100%;" />

	<%
		CNSACouncil.Models.Notice notice;

		int id;
		try {
			id = int.Parse(Request.QueryString["id"]);
			notice = CNSACouncil.Managers.NoticeManager.GetNotice(id);
		} catch (Exception e) {
			notice = new CNSACouncil.Models.Notice();
			notice.Title = "존재하지 않는 공지입니다";
			notice.Content = "존재하지 않는 공지입니다";
			notice.NoticeAt = Convert.ToDateTime("2014-03-01");
		}
	%>
	<!-- 공지 -->
	<div class="p-5 color-black">
		<h3 class="p-2" style="color: #707070;">Notice</h3>
		<div class="board-bar"></div>

		<div style="padding-left: 1.5rem; padding-right: 1.5rem;">
			<div class="float-left">
				<h5><b><%= notice.Title %></b></h5>
			</div>
			<span class="float-right"><%= notice.NoticeAt.ToString("yyyy-MM-dd") %></span>
			<div class="clearfix"></div>
		</div>
		<hr class="hr-board" />
		<div class="p-4">
			<%= notice.Content %>
		</div>
	</div>

	<div class="text-right p-5" style="margin-right: 1.5rem;">
		<a href="/Notices.aspx" class="btn btn-lg btn-warning btn-square" role="button">목록</a>
	</div>

	<form runat="server" class="p-5" style="padding-top: 0 !important;">
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
			var commentList = CNSACouncil.Managers.CommentManager.GetComments(int.Parse(Request.QueryString["id"]), 0);

			foreach (var comment in commentList) {
		%>
		<div class="comment-element">
			<span><%= comment.WriterID %></span>
			<span><%= comment.Content %></span>
			<span><%= comment.CommentAt.ToString("yyyy-MM-dd '/' HH:mm") %></span>
		</div>
		<% } %>
	</form>

	<!-- Navbar - Notice -->
	<script>
		document.getElementById("nav2").classList.add("active");
	</script>
</asp:Content>
