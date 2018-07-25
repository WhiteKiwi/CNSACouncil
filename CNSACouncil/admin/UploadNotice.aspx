<%@ Page Title="" Language="C#" MasterPageFile="~/masters/Admins.Master" AutoEventWireup="true" CodeBehind="UploadNotice.aspx.cs" ValidateRequest="false" Inherits="CNSACouncil.admin.UploadNotice" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
	<script src="/assets/ckeditor/ckeditor.js"></script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="Contents" runat="server">
	<form runat="server">
		<div class="container">
			<asp:TextBox runat="server" ID="text" TextMode="MultiLine"></asp:TextBox>
			<script>
				CKEDITOR.replace("Contents_text");
			</script>
			<asp:Button runat="server" OnClick="Upload" Text="등록" />
		</div>
	</form>

	<!-- Comming Soon -->
	<div class="text-center p-5 petition-box" style="margin: 50px;">
		<img src="/assets/img/CommingSoon.png" width="600" />
	</div>

	<!-- Navbar - Notice Management-->
	<script>
		document.getElementById("nav1").classList.add("active");
	</script>
</asp:Content>
