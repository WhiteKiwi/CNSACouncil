<%@ Page Title="" Language="C#" MasterPageFile="~/masters/Students.Master" AutoEventWireup="true" CodeBehind="Notices.aspx.cs" Inherits="CNSACouncil.Notices" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="Contents" runat="server">
	<!-- Top Image -->
	<img src="/assets/img/background-long.png" style="width: 100%;" />

	<!-- 공지 -->
	<div class="m-5 color-black">
		<h3 class="p-2" style="color: #707070;">Notice</h3>

		<div class="board-bar"></div>
		<div class="board-element">
			<span><b>번호</b></span>
			<span><b>제목</b></span>
			<span><b>공지일</b></span>
		</div>
		<br />
		<hr class="hr-board" />
		<% int page;
			try {
				page = int.Parse(Request.QueryString["page"]);
			} catch (Exception e) {
				page = 1;
			}

			var noticeList = CNSACouncil.Managers.NoticeManager.GetNoticeByPage(page);
			int noticeNum = 1;

			// Write on Page
			foreach (var notice in noticeList) { %>

		<div class="board-element">
			<span><%= notice.ID%></span>
			<span><a href="/Notice.aspx?id=<%= notice.ID %>" class="color-black"><%= notice.Title%></a></span>
			<span><%= notice.NoticeAt.ToString("yyyy-MM-dd")%></span>
		</div>
		<br />
		<% if (noticeNum == noticeList.Count) { %>
		<div class="board-bar" style="margin-top: 1rem;"></div>
		<% } else { %>
		<hr class="hr-board" />
		<% }
				noticeNum++;
			} %>
	</div>
	<br />

	<!-- 페이징 -->
	<div class="text-center" style="margin-top: -40px;">
		<%
			const int listCount = 10; // 한 페이지에 표시할 건의 수
			const int pageCount = 10; // 한 페이지에 표시할 페이지 번호 수

			int totalCount = CNSACouncil.Managers.NoticeManager.GetNoticeCount();

			// 총 페이지 수 계산
			int totalPage = totalCount / listCount;
			if (totalCount % listCount > 0)
				totalPage++;

			// 요청한 페이지가 최대 페이지 수보다 클 경우
			if (totalPage < page)
				page = totalPage;

			// 표시될 첫 페이지 번호
			int startPage = ((page - 1) / 10) * 10 + 1;
			// 표시될 마지막 페이지 번호
			int endPage = startPage + pageCount - 1;

			// 마지막 페이지가 총 페이지보다 클 경우
			if (endPage > totalPage)
				endPage = totalPage;

			if (startPage > 1) {
				// 이전 page -> page - 1
				Response.Write("<a href=\"/Notices.aspx?page=" + (page - 1) + "\" class=\"page-num\">");
			} else {
				// 이전 page -> 1
				Response.Write("<a href=\"/Notices.aspx?page=1\" class=\"page-num\">");
			}
			Response.Write("<span class=\"page-num-gold\">&lt;</span></a>");

			for (int i = startPage; i <= endPage; i++) {
				if (i == page) {
					// 현재 페이지일 경우
					Response.Write("<a href=\"/Notices.aspx?page=" + i + "\" class=\"page-num\">");
					Response.Write("<span class=\"page-num-gold\">" + i + "</span></a>");
				} else {
					// 마지막 페이지일 경우
					Response.Write("<a href=\"/Notices.aspx?page=" + i + "\" class=\"page-num\">");
					Response.Write("<span class=\"page-num-white border\">" + i + "</span></a>");
				}
			}

			if (endPage == totalPage) {
				// 다음 page = endpage
				Response.Write("<a href=\"/Notices.aspx?page=" + endPage + "\" class=\"page-num\">");
			} else {
				// 다음 page = page + 1
				Response.Write("<a href=\"/Notices.aspx?page=" + (page + 1) + "\" class=\"page-num\"");
			}
			Response.Write("<span class=\"page-num-gold\">&gt;</span></a>");
		%>
	</div>
	<br />
	<br />

	<!-- Navbar - Notice -->
	<script>
		document.getElementById("nav2").classList.add("active");
	</script>
</asp:Content>
