using System;
using CNSACouncil.Managers;
using MySql.Data.MySqlClient;

namespace CNSACouncil.admin {
	public partial class Login : System.Web.UI.Page {
		protected void Page_Load(object sender, EventArgs e) {

		}

		protected void LoginButton_Click(object sender, EventArgs e) {
			if (string.IsNullOrEmpty(AdminID.Text.Trim())) {
				// ID 미입력시
				Response.Write("<script>alert('ID를 입력해주세요.');</script>");
			} else if (string.IsNullOrEmpty(AdminPW.Text.Trim())) {
				// PW 미입력시
				Response.Write("<script>alert('Password를 입력해주세요.');</script>");
			} else {
				int result = AdminManager.LoginCheck(new Models.Admin {
					ID = AdminID.Text,
					Password = AdminPW.Text
				});

				if (result == 0) {
					// 로그인 성공
					Session["AdminID"] = AdminID.Text;

					// 관리자 페이지로 Redirect
					Response.Redirect("/admin/");
				} else if (result == 1) {
					// 패스워드 불일치
					Response.Write("<script>alert('Password를 확인해주세요.');</script>");
				} else if (result == 2) {
					// 해당하는 ID가 존재하지 않을 경우
					Response.Write("<script>alert('ID를 확인해주세요.');</script>");

				} else if (result == -1) {
					// 연결 실패
					Response.Write("<script>alert('서버 에러.');</script>");
				}
			}
		}
	}
}