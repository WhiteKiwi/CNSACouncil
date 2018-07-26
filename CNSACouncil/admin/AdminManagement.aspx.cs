using CNSACouncil.Managers;
using System;

namespace CNSACouncil.admin {
	public partial class AdminManagement : System.Web.UI.Page {
		protected void Page_Load(object sender, EventArgs e) {

		}

		protected void AddAdminButton_Click(object sender, EventArgs e) {
			if (string.IsNullOrEmpty(AdminID.Text)) {
				Response.Write("<script>alert('ID를 입력해주세요.');</script>");
			} else if (string.IsNullOrEmpty(AdminName.Text)) {
				Response.Write("<script>alert('[이름 - 직책]을 입력해주세요.');</script>");
			} else {
				AdminManager.AddAdmin(new Models.Admin {
					ID = AdminID.Text,
					Name = AdminName.Text
				});

				Response.Redirect("/admin/AdminManagement.aspx");
			}
		}

		protected void ChangePasswordButton_Click(object sender, EventArgs e) {
			if (string.IsNullOrEmpty(OldPassword.Text)) {
				Response.Write("<script>alert('기존 비밀번호를 입력해주세요.');</script>");
			} else if (string.IsNullOrEmpty(NewPassword.Text)) {
				Response.Write("<script>alert('새 비밀번호를 입력해주세요.');</script>");
			} else {
				AdminManager.ChangePassword((string)Session["AdminID"], OldPassword.Text, NewPassword.Text);

				Response.Redirect("/admin/AdminManagement.aspx");
			}
		}
	}
}