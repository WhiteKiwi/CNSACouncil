<%@ Page Title="" Language="C#" MasterPageFile="~/masters/Students.Master" AutoEventWireup="true" CodeBehind="Petitions.aspx.cs" Inherits="CNSACouncil.Petitions" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
	<script src="http://ajax.googleapis.com/ajax/libs/jquery/1.8.3/jquery.min.js" type="text/javascript"></script>
	<script type="text/javascript">
		var pageIndex = 1;
		var pageCount;
		$(window).scroll(function () {
			if ($(window).scrollTop() == $(document).height() - $(window).height()) {
				GetRecords();
			}
		});
		function GetRecords() {
			pageIndex++;
			if (pageIndex == 2 || pageIndex <= pageCount) {
				$("#loader").show();
				$.ajax({
					type: "POST",
					url: "Petitions.aspx/GetPetitions",
					data: '{pageIndex: ' + pageIndex + '}',
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
			var customers = xml.find("Petitions");
			customers.each(function () {
				var customer = $(this);
				var div = $("#petitions:first-child").eq(0).clone(true);
				$(".title", div).html(customer.find("Title").text());
				$(".content", div).html(customer.find("Content").text());
				$(".user-id", div).html(customer.find("UserID").text());
				$(".petiiton-at", div).html(customer.find("PetitionAt").text());
			});
			$("#loader").hide();
		}
	</script>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="Contents" runat="server">
	<!-- Top Image -->
	<img src="/assets/img/background-long.png" style="width: 100%;" />

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
		<h3>청원게시판은 5대 학생회의 공약 중 하나로 학생들의 여론을 빠르게 수렴하기 위해 만들어졌습니다.</h3>
		<br />
		<a href="/" class="btn btn-lg btn-warning btn-square w-25" role="button">지금 청원하기</a>
	</div>

	<!-- Petition Box -->
	<div id="petitions" style="overflow: auto;">
		<asp:Repeater runat="server" ID="repeater">
			<ItemTemplate>
				<div class="petition-box">
					<div class="row">
						<div class="col-md-7 color-black">
							<h3 class="petition-box-title"><b class="title"><%# Eval("Title")%></b></h3>
							<br />
							<h5 class="petition-box-content"><b class="content"><%# Eval("Content")%></b></h5>
						</div>
						<div class="col-md-1"></div>
						<div class="col-md-4 color-black">
							<h5>등록인 :  <span class="user-id"><%# Eval("UserID")%></span></h5>
							<h5 class="color-gold">동의 인원 :  99명</h5>
							<h5 class="right-date">등록 기간 :  <span class="petition-at"><%# Eval("PetitionAt")%></span></h5>
							<h5>&nbsp;~ 2018-06-26</h5>
							<br />
							<a href="/" class="btn btn-lg btn-secondary btn-square btn-long" role="button">자세히 보기</a>
						</div>
					</div>
				</div>
				<br />
				<br />
			</ItemTemplate>
		</asp:Repeater>
	</div>

	<img id="loader" src="/assets/img/loading.gif" style="display: none" />

	<!-- Navbar - Petition -->
	<script>
		document.getElementById("nav3").classList.add("active");
	</script>
</asp:Content>
