using CNSACouncil.Managers;
using System;

namespace CNSACouncil.admin {
	public partial class AdminSetting : System.Web.UI.Page {
		protected void Page_Load(object sender, EventArgs e) {
			if (Request.QueryString["select"] != null && Request.QueryString["adminID"] != null) {
				if (Request.QueryString["select"] == "reset") {
					// 계정 비밀번호 초기화
					AdminManager.ResetPassword(Request.QueryString["adminID"]);
				} else if (Request.QueryString["select"] == "delete") {
					// 계정 삭제
					AdminManager.DeleteAccount(Request.QueryString["adminID"]);
				}
			}

			Response.Redirect("/admin/AdminManagement.aspx");
		}
	}
}