<%@ Page Title="" Language="C#" MasterPageFile="~/masters/Admins.Master" AutoEventWireup="true" CodeBehind="EditProject.aspx.cs" Inherits="CNSACouncil.admin.EditProject" %>

<%@ Register Assembly="CKEditor.NET" Namespace="CKEditor.NET" TagPrefix="CKEditor" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="Contents" runat="server">
	<!-- Top Image -->
	<img src="/assets/img/admin-banner.png" style="width: 100%;" />

	<!-- Project Tab -->
	<div>
		<ul class="selection-tab border-bottom">
			<li class="border-right w-50"><a href="/admin/AddProject.aspx">사업 등록</a></li>
			<li class="border-right w-50 active"><a href="/admin/ProjectManagement.aspx">사업 관리</a></li>
		</ul>
	</div>

	<!-- Project -->
	<form runat="server" class="p-5">
		<div class="text-left">
			<h5 class="color-gray"><b>사업 이름</b></h5>
		</div>
		<asp:TextBox ID="ProjectTitle" runat="server" CssClass="form-control" placeholder="제목을 입력하세요"></asp:TextBox>
		<br />

		<div>
			<div class="float-left  w-50" style="padding-right: 20px;">
				<div class="text-left">
					<h5 class="color-gray"><b>사업 시작일</b></h5>
				</div>
				<asp:TextBox ID="ProjectStartAt" runat="server" CssClass="form-control" placeholder="yyyy-MM-dd"></asp:TextBox>
			</div>

			<div class="float-left w-50" style="padding-left: 20px;">
				<div class="text-left">
					<h5 class="color-gray"><b>사업 완료일</b></h5>
				</div>
				<asp:TextBox ID="ProjectEndAt" runat="server" CssClass="form-control" placeholder="yyyy-MM-dd"></asp:TextBox>
			</div>
			<div class="clearfix"></div>
		</div>
		<br />

		<div>
			<div class="text-left">
				<h5 class="color-gray"><b>대표 사진</b></h5>
			</div>
			<div class="input-group mb-3">
				<div class="input-group-prepend">
					<span class="input-group-text" id="inputGroupFileAddon">Upload</span>
				</div>
				<div class="custom-file">
					<asp:FileUpload ID="ProjectPicture" CssClass="custom-file-input" runat="server" aria-describedby="inputGroupFileAddon" />
					<label class="custom-file-label" for="Contents_ProjectPicture">Choose file</label>
				</div>
			</div>
		</div>
		<br />

		<div class="text-left">
			<h5 class="color-gray"><b>사업 내용</b></h5>
		</div>
		<CKEditor:CKEditorControl ID="Content" BasePath="/assets/CKEditor/" runat="server"></CKEditor:CKEditorControl>
		<br />
		<br />
		<div class="text-center">
			<asp:Button runat="server" ID="EditButton" CssClass="btn btn-lg btn-danger btn-square w-25" Text="수정하기" OnClick="EditButton_Click" />
		</div>
	</form>

	<!-- Navbar - Project Management-->
	<script>
		document.getElementById("nav4").classList.add("active");
	</script>
</asp:Content>
