using CNSACouncil.Models;
using MySql.Data.MySqlClient;
using System.Collections.Generic;

namespace CNSACouncil.Managers {
	public static class AdminManager {
		// Table Name
		private const string ADMINS = "admins";

		/// <summary>
		/// Login 성공 여부를 확인하는 메서드
		/// </summary>
		/// <param name="admin">Admin class in Models</param>  
		/// <see cref="Admin"/>
		public static int LoginCheck(Admin admin) {
			int result = -1;

			// Connect to DB
			using (var conn = new MySqlConnection(System.Configuration.ConfigurationManager.ConnectionStrings["COUNCILDB"].ConnectionString)) {
				conn.Open();

				// Command Text - SELECT Admin
				string commandText = "SELECT * FROM admins WHERE ID='" + admin.ID + "'";
				var cmd = new MySqlCommand(commandText, conn);

				var rdr = cmd.ExecuteReader();
				if (rdr.Read()) {
					if ((int)rdr["Password"] == (admin.Password + "v.j/dsDN1Qe]-1lEJfI1FWAFdqj-9DJ1f9-B0bu%d&_w!4e!@#").GetHashCode()) {
						// 로그인 성공
						result = 0;
					} else {
						// 패스워드 불일치
						result = 1;
					}
				} else {
					// 해당하는 ID가 존재하지 않을 경우
					result = 2;
				}

				// Connection Close
				conn.Close();
			}

			return result;
		}

		/// <summary>
		/// Admin 목록을 반환하는 메서드
		/// </summary>
		/// <see cref="Admin"/>
		public static List<Admin> GetAdmins() {
			var adminList = new List<Admin>();

			// Connect to DB
			using (var conn = new MySqlConnection(System.Configuration.ConfigurationManager.ConnectionStrings["COUNCILDB"].ConnectionString)) {
				conn.Open();

				// Command Text - SELECT Admins
				string commandText = "SELECT * FROM admins;";
				var cmd = new MySqlCommand(commandText, conn);

				var rdr = cmd.ExecuteReader();
				while (rdr.Read()) {
					adminList.Add(new Admin {
						ID = (string)rdr["ID"],
						Name = (string)rdr["Name"]
					});
				}

				// Connection Close
				conn.Close();
			}

			return adminList;
		}

		/// <summary>
		/// 계정 비밀번호를 초기화하는 메서드
		/// </summary>
		/// <param name="adminID">Admin's ID</param>  
		/// <see cref="Admin.ID"/>
		public static void ResetPassword(string adminID) {
			// Connect to DB
			using (var conn = new MySqlConnection(System.Configuration.ConfigurationManager.ConnectionStrings["COUNCILDB"].ConnectionString)) {
				conn.Open();

				// Command Text - UPDATE Password
				string commandText = "UPDATE admins SET Password='" + "5thcnsacouncilv.j/dsDN1Qe]-1lEJfI1FWAFdqj-9DJ1f9-B0bu%d&_w!4e!@#".GetHashCode() + "' WHERE ID='" + adminID + "';";
				var cmd = new MySqlCommand(commandText, conn);

				cmd.ExecuteNonQuery();

				// Connection Close
				conn.Close();
			}
		}

		/// <summary>
		/// 계정을 삭제하는 메서드
		/// </summary>
		/// <param name="adminID">Admin's ID</param>  
		/// <see cref="Admin.ID"/>
		public static void DeleteAccount(string adminID) {
			// Connect to DB
			using (var conn = new MySqlConnection(System.Configuration.ConfigurationManager.ConnectionStrings["COUNCILDB"].ConnectionString)) {
				conn.Open();

				// Command Text - DELETE Account
				string commandText = "DELETE FROM admins WHERE ID='" + adminID + "';";
				var cmd = new MySqlCommand(commandText, conn);

				cmd.ExecuteNonQuery();

				// Connection Close
				conn.Close();
			}
		}

		/// <summary>
		/// 계정을 추가하는 메서드
		/// </summary>
		/// <param name="admin">Admin class in Models</param>  
		/// <see cref="Admin"/>
		public static void AddAdmin(Admin admin) {
			// Connect to DB
			using (var conn = new MySqlConnection(System.Configuration.ConfigurationManager.ConnectionStrings["COUNCILDB"].ConnectionString)) {
				conn.Open();

				// Command Text - Create
				string commandText = "INSERT INTO " + ADMINS + "(ID, Password, Name) VALUES (?, ?, ?);";
				var cmd = new MySqlCommand(commandText, conn);
				cmd.Parameters.Add("ID", MySqlDbType.VarChar).Value = admin.ID;
				cmd.Parameters.Add("Password", MySqlDbType.Int32).Value = "5thcnsacouncilv.j/dsDN1Qe]-1lEJfI1FWAFdqj-9DJ1f9-B0bu%d&_w!4e!@#".GetHashCode();
				cmd.Parameters.Add("Name", MySqlDbType.VarChar).Value = admin.Name;

				cmd.ExecuteNonQuery();

				// Connection Close
				conn.Close();
			}
		}

		/// <summary>
		/// 비밀번호를 변경하는 메서드
		/// </summary>
		/// <param name="ID">관리자 ID</param>  
		/// <param name="oldPassword">기존 비밀번호</param>  
		/// <param name="newPassword">새 비밀번호</param>  
		/// <see cref="Admin"/>
		public static void ChangePassword(string ID, string oldPassword, string newPassword) {
			if (LoginCheck(new Admin {
				ID = ID,
				Password = oldPassword
			}) == 0) {
				// Connect to DB
				using (var conn = new MySqlConnection(System.Configuration.ConfigurationManager.ConnectionStrings["COUNCILDB"].ConnectionString)) {
					conn.Open();

					// Command Text - Change Password
					string commandText = "UPDATE admins SET Password='" + (newPassword + "v.j/dsDN1Qe]-1lEJfI1FWAFdqj-9DJ1f9-B0bu%d&_w!4e!@#").GetHashCode() + "' WHERE ID='" + ID + "';";
					var cmd = new MySqlCommand(commandText, conn);

					cmd.ExecuteNonQuery();

					// Connection Close
					conn.Close();
				}
			}
		}
	}
}