<%@ Page Title="" Language="C#" MasterPageFile="~/masters/Students.Master" AutoEventWireup="true" CodeBehind="Petitions.aspx.cs" Inherits="CNSACouncil.Petitions" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
	<script src="/assets/js/jquery-1.8.3.min.js" type="text/javascript"></script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="Contents" runat="server">
	<!-- Top Image -->
	<img src="/assets/img/petitions-banner.png" style="width: 100%;" />

	<!-- Petition 분류 선택 -->
	<% 
		string[] order = { "", "", "", "" };
		if (Request.QueryString["order"] == "best") {
			order[1] = " active";
		} else if (Request.QueryString["order"] == "finished") {
			order[2] = " active";
		} else if (Request.QueryString["order"] == "answer") {
			order[3] = " active";
		} else {
			order[0] = " active";
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

	<!-- Notice box -->
	<div class="border-box-gold text-center">
		<div class="container-fluid" style="padding-bottom: 20px;">
			<h4>청원게시판은 5대 학생회의 공약으로 학생들의 여론을 빠르게 수렴하기 위하여 개설되었습니다.</h4>
			<h4>학교의 제도, 행사, 시설에 대해 다수의 목소리가 모여 30일 동안 100명 이상의 학생 여러분이 추천한 '청원'에 대해서는 학생회 사업으로 추진한 후 결과를 공지하겠습니다.</h4>
		</div>
		<a href="/UploadPetition.aspx" class="btn btn-lg btn-warning btn-square w-25" role="button">지금 청원하기</a>
	</div>

	<!-- Petition Box -->
	<div id="petitions" style="overflow: auto;">
		<asp:Repeater runat="server" ID="repeater">
			<ItemTemplate>
				<div class="petition-box" style="margin: 50px;">
					<div class="row">
						<div class="col-md-7 color-black">
							<h3 class="petition-box-title"><b class="title"><%# Eval("Title").ToString().Length > 18 ? Eval("Title").ToString().Substring(0, 18) + "..." : Eval("Title") %></b></h3>
							<br />
							<a href="/Petition.aspx?order=<%= Request.QueryString["order"] %>&id=<%# Eval("ID")%>" class="petition-link" style="text-decoration: none;">
								<h5 class="petition-box-content"><%# Eval("Content").ToString().Replace("<br/>", " ").Length > 170 ? Eval("Content").ToString().Replace("<br/>", " ").Substring(0, 170) + "..." : Eval("Content").ToString().Replace("<br/>", " ")%></h5>
							</a>
						</div>
						<div class="col-md-1"></div>
						<div class="col-md-4 color-black">
							<br>
							<h5>등록인 :  <span class="user-id"><%# Eval("UserID").ToString().Substring(0, 2) + "****"%></span></h5>
							<h5 class="color-gold">동의 인원 :  <span class="agrees"><%# Eval("Agrees")%></span>명</h5>
							<h5 class="right-date">등록 기간 :  <span class="petition-at"><%#DateTime.Parse(Eval("PetitionAt").ToString()).ToString("yyyy-MM-dd")%></span></h5>
							<h5>&nbsp;~ <%#DateTime.Parse(Eval("PetitionAt").ToString()).AddDays(30).ToString("yyyy-MM-dd")%></h5>
							<br />
							<a href="/Petition.aspx?order=<%= Request.QueryString["order"] %>&id=<%# Eval("ID")%>" class="btn btn-lg btn-secondary btn-square btn-long petition-link" role="button">자세히 보기</a>
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

	<!-- Navbar - Petition -->
	<script>
		document.getElementById("nav3").classList.add("active");
	</script>

	<!-- Infinite Scroll -->
	<script type="text/javascript">
		var pageIndex = 1;
		var pageCount;

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
					url: "/Petitions.aspx/GetPetitions",
					data: '{pageIndex: ' + pageIndex + ', order: "' + getParameterByName('order') + '"}',
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
				$(".petition-link", div).attr('href', '/Petition.aspx?order=' + getParameterByName("order") + '&id=' + petition.find("ID").text());
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
