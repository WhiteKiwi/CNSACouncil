using System;

namespace CNSACouncil.admin {
	public partial class Logout : System.Web.UI.Page {
		protected void Page_Load(object sender, EventArgs e) {
			// Session 초기화
			Session["AdminID"] = null;
			Session["AdminName"] = null;

			// 관리자 로그인 페이지로 Redirect
			Response.Redirect("/admin/Login.aspx");
		}
	}
}