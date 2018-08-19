<%@ Page Title="" Language="C#" MasterPageFile="~/masters/Admins.Master" AutoEventWireup="true" CodeBehind="AdminManagement.aspx.cs" Inherits="CNSACouncil.admin.AdminManagement" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="Contents" runat="server">
	<!-- Top Image -->
	<img src="/assets/img/admin-banner.png" style="width: 100%;" />

	<form runat="server">
		<!-- 계정 추가 및 비밀번호 변경 -->
		<div class="border border-dark m-5 row" style="padding: 30px;">
			<!-- 계정 추가 -->
			<div class="w-50 col-6">
				<h4 style="color: #707070;">관리자 추가</h4>
				<br />
				<div class="float-left" style="margin-right: 20px; width: calc(100% - 120px);">
					<asp:TextBox runat="server" ID="AdminID" CssClass="form-control" placeholder="ID"></asp:TextBox><br />
					<asp:TextBox runat="server" ID="AdminName" CssClass="form-control" placeholder="이름 - 직책"></asp:TextBox>
				</div>
				<div>
					<asp:Button runat="server" ID="AddAdminButton" CssClass="btn btn-lg btn-warning btn-square square" OnClick="AddAdminButton_Click" Text="ADD"></asp:Button>
				</div>
			</div>

			<!-- 비밀번호 변경 -->
			<div class="w-50 col-6">
				<h4 style="color: #707070;">비밀번호 변경</h4>
				<br />
				<div class="float-left" style="margin-right: 20px; width: calc(100% - 120px);">
					<asp:TextBox runat="server" ID="OldPassword" CssClass="form-control" TextMode="Password" placeholder="기존 비밀번호"></asp:TextBox><br />
					<asp:TextBox runat="server" ID="NewPassword" CssClass="form-control" TextMode="Password" placeholder="새 비밀번호"></asp:TextBox>
				</div>
				<div>
					<asp:Button runat="server" ID="ChangePasswordButton" CssClass="btn btn-lg btn-danger btn-square square" OnClick="ChangePasswordButton_Click" Text="APPLY"></asp:Button>
				</div>
			</div>
		</div>
		<br />
		<!-- 관리자 관리 -->
		<div class="container-fluid p-5">
			<h3 style="color: #707070;">관리자 계정 관리</h3>
			<div style="background-color: #707070; height: 4px; margin-bottom: 1rem;"></div>

			<%
				var adminList = CNSACouncil.Managers.AdminManager.GetAdmins();
				int adminNum = 1;
				foreach (var admin in adminList) {
			%>
			<div class="account-element">
				<div class="square-small bg-secondary text-white float-left"><%= adminNum++%></div>
				<input class="form-control float-left" style="width: calc(50% - 220px);" placeholder="ID" value="<%=admin.ID%>" />
				<input class="form-control float-left" style="width: calc(50% - 220px);" placeholder="이름 - 직책" value="<%=admin.Name %>" />
				<a href="/admin/AdminSetting.aspx?select=reset&adminID=<%= admin.ID%>" class="btn btn-warning btn-square float-left" style="height: 38px; width: 200px;" role="button">비밀번호 초기화</a>
				<a href="/admin/AdminSetting.aspx?select=delete&adminID=<%= admin.ID%>" class="btn  btn-danger btn-square float-left" style="height: 38px; width: 100px;" role="button">삭제</a>
			</div>
			<br />
			<% } %>
		</div>
	</form>

	<!-- Navbar - Admin Management-->
	<script>
		document.getElementById("nav5").classList.add("active");
	</script>
</asp:Content>
