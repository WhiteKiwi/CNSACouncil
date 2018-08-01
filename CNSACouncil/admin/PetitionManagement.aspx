<%@ Page Title="" Language="C#" MasterPageFile="~/masters/Admins.Master" AutoEventWireup="true" CodeBehind="PetitionManagement.aspx.cs" Inherits="CNSACouncil.admin.PetitionManagement" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
	<script src="/assets/js/jquery-1.8.3.min.js" type="text/javascript"></script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="Contents" runat="server">
	<!-- Top Image -->
	<img src="/assets/img/background-long.png" style="width: 100%;" />

	<!-- Petition 분류 선택 -->
	<% 
		string[] order = { "", "" };
		if (Request.QueryString["state"] == "awaitingAnswer") {
			order[1] = " active";
		} else {
			order[0] = " active";
		}
	%>
	<!-- Petition Tab -->
	<div>
		<ul class="selection-tab border-bottom">
			<li class="border-right<%=order[0]%> w-50"><a href="/admin/PetitionManagement.aspx">승인 대기중</a></li>
			<li class="border-right<%=order[1]%> w-50"><a href="/admin/PetitionManagement.aspx?state=awaitingAnswer">답변 대기중</a></li>
		</ul>
	</div>

	<!-- Petition Box -->
	<div id="petitions" style="overflow: auto;">
		<asp:Repeater runat="server" ID="repeater">
			<ItemTemplate>
				<div class="petition-box" style="margin: 50px;">
					<div class="row">
						<div class="col-md-7 color-black">
							<h3 class="petition-box-title"><b class="title"><%# Eval("Title")%></b></h3>
							<br />
							<h5 class="petition-box-content"><%# Eval("Content").ToString().Length > 120 ? Eval("Content").ToString().Substring(0, 120) + "..." : Eval("Content")%></h5>
						</div>
						<div class="col-md-1"></div>
						<div class="col-md-4 color-black">
							<h5>등록인 :  <span class="user-id"><%# Eval("UserID").ToString().Substring(0, 2) + "****"%></span></h5>
							<h5 class="color-gold">동의 인원 :  <span class="agrees"><%# Eval("Agrees")%></span>명</h5>
							<h5 class="right-date">등록 기간 :  <span class="petition-at"><%#DateTime.Parse(Eval("PetitionAt").ToString()).ToString("yyyy-MM-dd")%></span></h5>
							<h5>&nbsp;~ <%#DateTime.Parse(Eval("PetitionAt").ToString()).AddMonths(1).AddHours(9).ToString("yyyy-MM-dd")%></h5>
							<br />
							<a href="/admin/<%= Request.QueryString["state"] == "awaitingAnswer" ? "Answer" : "Allow" %>Petition.aspx?id=<%# Eval("ID")%>" class="btn btn-lg btn-secondary btn-square btn-long" role="button">자세히 보기</a>
						</div>
					</div>
				</div>
			</ItemTemplate>
		</asp:Repeater>
	</div>

	<div class="text-center">
		<img id="loader" src="/assets/img/loading.gif" style="display: none;" />
	</div>
	<br />

	<!-- Navbar - Petition Management-->
	<script>
		document.getElementById("nav3").classList.add("active");
	</script>

	<!-- Infinite Scroll -->
	<script type="text/javascript">
		var pageIndex = 1;
		var pageCount = 100;

		window.onscroll = function (ev) {
			if ((window.innerHeight + window.scrollY) >= document.body.offsetHeight) {
				GetRecords();
			}
		};

		function GetRecords() {
			pageIndex++;
			if (pageIndex == 2 || pageIndex <= pageCount) {
				$("#loader").show();
				$.ajax({
					type: "POST",
					url: "/admin/PetitionManagement.aspx/GetPetitions",
					data: '{pageIndex: ' + pageIndex + ', state: "' + getParameterByName('state') + '"}',
					contentType: "application/json; charset=utf-8",
					dataType: "json",
					success: OnSuccess,
					failure: function (response) {
						alert(response.d);
					},
					error: function (response) {
						alert(response.d);
					}
				});
			}
		}

		function OnSuccess(response) {
			var xmlDoc = $.parseXML(response.d);
			var xml = $(xmlDoc);
			pageCount = parseInt(xml.find("PageCount").eq(0).find("PageCount").text());
			var petitions = xml.find("Petition");
			petitions.each(function () {
				var petition = $(this);
				var div = $("#petitions > div").eq(0).clone(true);
				$(".title", div).html(petition.find("Title").text());
				var content = petition.find("Content").text();
				if (content.length > 120)
					$(".petition-box-content", div).html(petition.find("Content").text().substring(0, 120) + "...");
				else
					$(".petition-box-content", div).html(petition.find("Content").text());
				$(".user-id", div).html(petition.find("UserID").text().substring(0, 2) + "****");
				$(".petiiton-at", div).html(petition.find("PetitionAt").text());
				$(".agrees", div).html(petition.find("Agrees").text());
				if (getParameterByName("state") == "awaitingAnswer")
					$(".petition-link", div).attr('href', '/admin/ReplyPetition.aspx?id=' + petition.find("ID").text());
				else
					$(".petition-link", div).attr('href', '/admin/AllowPetition.aspx?id=' + petition.find("ID").text());
				$("#petitions").append(div);
			});
			$("#loader").hide();
		}

		function getParameterByName(name, url) {
			if (!url) url = window.location.href;
			name = name.replace(/[\[\]]/g, '\\$&');
			var regex = new RegExp('[?&]' + name + '(=([^&#]*)|&|#|$)'),
				results = regex.exec(url);
			if (!results) return null;
			if (!results[2]) return '';
			return decodeURIComponent(results[2].replace(/\+/g, ' '));
		}
	</script>
</asp:Content>
