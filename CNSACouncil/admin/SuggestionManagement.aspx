<%@ Page Title="" Language="C#" MasterPageFile="~/masters/Admins.Master" AutoEventWireup="true" CodeBehind="SuggestionManagement.aspx.cs" Inherits="CNSACouncil.admin.SuggestionManagement" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="Contents" runat="server">
	<!-- Top Image -->
	<img src="/assets/img/background-long.png" style="width: 100%;" />

	<!-- 건의 분류 선택 -->
	<% 
		bool isLast = Request.QueryString["order"] == "last";

		string[] order = { "", "" };
		if (isLast) {
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

	<div class="m-5 color-black">
		<div class="board-bar"></div>
		<div class="board-element">
			<span><b>번호</b></span>
			<span><b>제목</b></span>
			<span><b>건의일</b></span>
		</div>
		<br />
		<hr class="hr-board" />
		<% int page;
			try {
				page = int.Parse(Request.QueryString["page"]);
			} catch (Exception e) {
				page = 1;
			}

			var suggestionList = CNSACouncil.Managers.SuggestionManager.GetSuggestionByPageAndState(page, isLast ? 1 : 0);
			int suggestionNum = 1;
			// Write on Page
			foreach (var suggestion in suggestionList) { %>

		<div class="board-element">
			<span><%= suggestion.ID%></span>
			<span><a href="javascript:open('<%= suggestionNum%>');" class="color-black"><%= suggestion.Title%></a></span>
			<span><%=suggestion.SuggestAt.ToString("yyyy-MM-dd")%></span>
		</div>
		<br />
		<div id="suggestion-<%= suggestionNum%>" class="suggestion-content" style="display: none;">
			<div>
				<%= suggestion.Content%>
			</div>
			<br />
			<%if (!isLast) { %>
			<div class="text-right">
				<a href="/admin/SuggestionCheck.aspx?SuggestionID=<%= suggestion.ID%>" class="btn btn-lg btn-warning btn-square w-25" role="button">확인</a>
			</div>
			<%} %>
		</div>
		<hr class="hr-board" />

		<%suggestionNum++;
			} %>
	</div>

	<!-- 페이징 -->
	<div class="text-center" style="margin-top: -40px;">
		<%
			const int listCount = 10; // 한 페이지에 표시할 건의 수
			const int pageCount = 10; // 한 페이지에 표시할 페이지 번호 수

			int totalCount = CNSACouncil.Managers.SuggestionManager.GetSuggestionCountByState(Request.QueryString["order"] == "last" ? 1 : 0);

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
				Response.Write("<a href=\"/admin/SuggestionManagement.aspx?"+ (isLast ? "order=last&" : "") +"page=" + (page - 1) + "\" class=\"page-num\">");
			} else {
				// 이전 page -> 1
				Response.Write("<a href=\"/admin/SuggestionManagement.aspx?"+ (isLast ? "order=last&" : "") +"page=1\" class=\"page-num\">");
			}
			Response.Write("<span class=\"page-num-gold\">&lt;</span></a>");

			for (int i = startPage; i <= endPage; i++) {
				if (i == page) {
					// 현재 페이지일 경우
					Response.Write("<a href=\"/admin/SuggestionManagement.aspx?"+ (isLast ? "order=last&" : "") +"page=" + i + "\" class=\"page-num\">");
					Response.Write("<span class=\"page-num-gold\">" + i + "</span></a>");
				} else {
					// 마지막 페이지일 경우
					Response.Write("<a href=\"/admin/SuggestionManagement.aspx?"+ (isLast ? "order=last&" : "") +"page=" + i + "\" class=\"page-num\">");
					Response.Write("<span class=\"page-num-white border\">" + i + "</span></a>");
				}
			}

			if (endPage == totalPage) {
				// 다음 page = endpage
				Response.Write("<a href=\"/admin/SuggestionManagement.aspx?"+ (isLast ? "order=last&" : "") +"page=" + endPage + "\" class=\"page-num\">");
			} else {
				// 다음 page = page + 1
				Response.Write("<a href=\"/admin/SuggestionManagement.aspx?"+ (isLast ? "order=last&" : "") +"page=" + (page + 1) + "\" class=\"page-num\"");
			}
			Response.Write("<span class=\"page-num-gold\">&gt;</span></a>");
		%>
	</div>
	<br />
	<br />

	<!-- Suggestion Content Open-->
	<script>
		// 건의 내용을 Open 하는 함수
		function open(suggestionNum) {
			var openedSuggestion = document.getElementById("suggestion-" + suggestionNum);
			if (openedSuggestion.style.display == 'none') {
				openedSuggestion.style.display = "block";
			} else {
				openedSuggestion.style.display = "none";
			}
		}
	</script>

	<!-- Navbar - Suggestion Management-->
	<script>
		document.getElementById("nav2").classList.add("active");
	</script>
</asp:Content>
