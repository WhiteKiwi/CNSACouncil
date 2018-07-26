using System;
using System.Collections.Generic;
using CNSACouncil.Models;
using MySql.Data.MySqlClient;

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
	}
}