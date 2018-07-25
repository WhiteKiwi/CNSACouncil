using System;
using MySql.Data.MySqlClient;

namespace CNSACouncil.admin {
	public partial class Login : System.Web.UI.Page {
		protected void Page_Load(object sender, EventArgs e) {
			
		}

		protected void LoginButton_Click(object sender, EventArgs e) {
			// Connect to DB
			using (var conn = new MySqlConnection(System.Configuration.ConfigurationManager.ConnectionStrings["COUNCILDB"].ConnectionString)) {
				conn.Open();

				// Command Text - Create
				string commandText = "SELECT * FROM admins WHERE ID='" + AdminID.Text + "'";
				var cmd = new MySqlCommand(commandText, conn);

				var rdr = cmd.ExecuteReader();
				if (rdr.Read()) {
					if ((int)rdr["Password"] == (AdminPW.Text + "v.j/dsDN1Qe]-1lEJfI1FWAFdqj-9DJ1f9-B0bu%d&_w!4e!@#").GetHashCode()) {
						// 로그인 성공
						Session["AdminID"] = AdminID.Text;
						Session["AdminName"] = rdr["Name"];

						// 관리자 페이지로 Redirect
						Response.Redirect("/admin/");
					} else {
						// 패스워드 불일치
						Response.Write("<script>alert('Password를 확인해주세요.');</script>");
					}
				} else {
					// 해당하는 ID가 존재하지 않을 경우
					Response.Write("<script>alert('ID를 확인해주세요.');</script>");
				}

				// Connection Close
				conn.Close();
			}
		}
	}
}