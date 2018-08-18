<%@ Page Title="" Language="C#" MasterPageFile="~/masters/Students.Master" AutoEventWireup="true" CodeBehind="Project.aspx.cs" Inherits="CNSACouncil.AProject" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="Contents" runat="server">
	<!-- Top Image -->
	<img src="/assets/img/background-long.png" style="width: 100%;" />

	<!-- Project 분류 선택 -->
	<% 
		string[] order = { "", "" };
		if (Request.QueryString["state"] == "1") {
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

	<%
		CNSACouncil.Models.Project project;

		int id;
		try {
			id = int.Parse(Request.QueryString["id"]);
			project = CNSACouncil.Managers.ProjectManager.GetProject(id);
		} catch (Exception e) {
			project = new CNSACouncil.Models.Project();
			project.Title = "존재하지 않는 사업입니다";
			project.Content = "존재하지 않는 사업입니다";
			project.StartAt = Convert.ToDateTime("2014-03-01");
			project.EndAt = Convert.ToDateTime("2014-03-01");
			project.State = 0;
		}
	%>
	<!-- 사업 -->
	<div class="p-5 color-black">
		<h3 class="p-2" style="color: #707070;">Project</h3>
		<div class="board-bar"></div>

		<div style="padding-left: 1.5rem; padding-right: 1.5rem;">
			<div class="float-left">
				<h5><b><%= project.Title %></b></h5>
			</div>
			<span class="float-right"><%= project.StartAt.ToString("yyyy-MM-dd") %> ~ <%= project.State == 1 ? project.EndAt.ToString("yyyy-MM-dd") : "" %></span>
			<div class="clearfix"></div>
		</div>
		<hr class="hr-board" />
		<div class="container p-4">
			<img src="/assets/images/<%= project.FileName %>" width="100%" />
			<br />
			<br />
			<%= project.Content %>
		</div>
	</div>

	<div class="text-right p-5" style="margin-right: 1.5rem;">
		<a href="/Projects.aspx" class="btn btn-lg btn-warning btn-square" role="button">목록</a>
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
			var commentList = CNSACouncil.Managers.CommentManager.GetComments(int.Parse(Request.QueryString["id"]), 2);

			foreach (var comment in commentList) {
		%>
		<div class="comment-element">
			<span><%= comment.WriterID %></span>
			<span><%= comment.Content %></span>
			<span><%= comment.CommentAt.ToString("yyyy-MM-dd '/' HH:mm") %></span>
		</div>
		<% } %>
	</form>

	<!-- Navbar - Project -->
	<script>
		document.getElementById("nav4").classList.add("active");
	</script>
</asp:Content>
