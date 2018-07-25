using System;

namespace CNSACouncil {
	public partial class Logout : System.Web.UI.Page {
		protected void Page_Load(object sender, EventArgs e) {
			// Sesstion 삭제
			Session["UserID"] = null;
			// 메인 화면으로 Redirect
			Response.Redirect("/");
		}
	}
}