<%@ Page Title="" Language="C#" MasterPageFile="~/masters/Admins.Master" AutoEventWireup="true" CodeBehind="UploadNotice.aspx.cs" ValidateRequest="false" Inherits="CNSACouncil.admin.UploadNotice" %>
<%@ Register Assembly="CKEditor.NET" Namespace="CKEditor.NET" TagPrefix="CKEditor" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="Contents" runat="server">
	<!-- Top Image -->
	<img src="/assets/img/admin-banner.png" style="width: 100%;" />

	<!-- Notice Box -->
	<form runat="server" class="text-center" style="margin: 30px 50px 30px 50px;">
		<div class="text-left">
			<h5 class="color-gray"><b>공지 제목</b></h5>
		</div>
		<asp:TextBox runat="server" ID="NoticeTitle" CssClass="form-control" placeholder="제목을 입력하세요" />
		<br />
		<div class="text-left">
			<h5 class="color-gray"><b>공지 내용</b></h5>
		</div>
		<CKEditor:CKEditorControl ID="Content" BasePath="/assets/CKEditor/" runat="server"></CKEditor:CKEditorControl>
		<br />
		<br />
		<asp:Button runat="server" ID="UploadButton" CssClass="btn btn-lg btn-warning btn-square w-25" Text="공지 등록" OnClick="UploadButton_Click" />
	</form>
	<br />

	<!-- Navbar - Notice Management-->
	<script>
		document.getElementById("nav1").classList.add("active");
	</script>
</asp:Content>
