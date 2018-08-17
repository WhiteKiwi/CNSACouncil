using System;
using MySql.Data.MySqlClient;
using CNSACouncil.Models;
using System.Collections.Generic;

namespace CNSACouncil.Managers {
	public static class PetitionManager {
		// Table Name
		private const string PETITIONS = "petitions";

		/// <summary>
		/// 청원을 추가하는 메서드
		/// </summary>
		/// <param name="petition">Suggestion class in Models</param>  
		/// <see cref="Petition"/>
		public static int UploadPetition(Petition petition) {
			// Connect to DB
			using (var conn = new MySqlConnection(System.Configuration.ConfigurationManager.ConnectionStrings["COUNCILDB"].ConnectionString)) {
				conn.Open();

				// Command Text - Create
				string commandText = "INSERT INTO " + PETITIONS + "(UserID, TItle, Content, IP, PetitionAt) VALUES (?, ?, ?, ?, ?);";
				var cmd = new MySqlCommand(commandText, conn);
				cmd.Parameters.Add("UserID", MySqlDbType.VarChar).Value = petition.UserID;
				cmd.Parameters.Add("Title", MySqlDbType.VarChar).Value = petition.Title;
				cmd.Parameters.Add("Content", MySqlDbType.VarChar).Value = petition.Content;
				cmd.Parameters.Add("IP", MySqlDbType.VarChar).Value = petition.IP;
				cmd.Parameters.Add("PetitionAt", MySqlDbType.DateTime).Value = petition.PetitionAt;

				int result;
				try {
					// The number of rows affected
					result = cmd.ExecuteNonQuery();
				} catch (MySqlException e) {
					// Returns 0 on exception
					return 0;
				}

				// Connection Close
				conn.Close();

				return result;
			}
		}

		/// <summary>
		/// 답변을 추가하는 메서드 
		/// </summary>
		/// <param name="answer'">답변 내용</param>  
		/// <see cref="Petition.Answer"/>
		public static void AddAnswer(int ID, string answer) {
			// Connect to DB
			using (var conn = new MySqlConnection(System.Configuration.ConfigurationManager.ConnectionStrings["COUNCILDB"].ConnectionString)) {
				conn.Open();

				// Command Text - Create
				string commandText = "INSERT INTO answers(PetitionID, Answer) VALUES (?, ?);";
				var cmd = new MySqlCommand(commandText, conn);
				cmd.Parameters.Add("PetitionID", MySqlDbType.UInt32).Value = ID;
				cmd.Parameters.Add("Answer", MySqlDbType.VarChar).Value = answer;

				cmd.ExecuteNonQuery();

				// Connection Close
				conn.Close();

				PetitionCheck(ID, 2);
			}
		}

		/// <summary>
		/// 청원을 개수를 반환하는 메서드
		/// </summary>
		/// <param name="state">청원 상태</param>  
		/// <see cref="Petition"/>
		public static int GetPetitionsCount(int state) {
			int result = 0;

			// Connect to DB
			using (var conn = new MySqlConnection(System.Configuration.ConfigurationManager.ConnectionStrings["COUNCILDB"].ConnectionString)) {
				conn.Open();

				// Command Text - Get Count
				string sql = "SELECT count(*) FROM " + PETITIONS + " WHERE State='" + state + "';";
				MySqlCommand cmd = new MySqlCommand(sql, conn);
				result = Convert.ToInt32(cmd.ExecuteScalar());


				// Connection Close
				conn.Close();
			}

			return result;
		}
		public static int GetPetitionsCount(string countSql) {
			int result = 0;

			// Connect to DB
			using (var conn = new MySqlConnection(System.Configuration.ConfigurationManager.ConnectionStrings["COUNCILDB"].ConnectionString)) {
				conn.Open();

				// Command Text - Get Count
				MySqlCommand cmd = new MySqlCommand(countSql, conn);
				result = Convert.ToInt32(cmd.ExecuteScalar());


				// Connection Close
				conn.Close();
			}

			return result;
		}

		/// <summary>
		/// Petition 정보를 반환하는 메서드
		/// </summary>
		/// <param name="ID">청원 ID</param>  
		/// <see cref="Petition"/>
		public static Petition GetPetitionByID(string ID, int state) {
			Petition result = null;

			// Connect to DB
			using (var conn = new MySqlConnection(System.Configuration.ConfigurationManager.ConnectionStrings["COUNCILDB"].ConnectionString)) {
				conn.Open();

				// Command Text - Get Petition
				string sql = "SELECT * FROM " + PETITIONS + " WHERE ID='" + ID + "' AND State='" + state + "';";
				MySqlCommand cmd = new MySqlCommand(sql, conn);
				var rdr = cmd.ExecuteReader();
				if (rdr.Read()) {
					result = new Petition {
						ID = int.Parse(ID),
						UserID = (string)rdr["UserID"],
						Title = (string)rdr["Title"],
						Content = (string)rdr["Content"],
						PetitionAt = (DateTime)rdr["PetitionAt"],
						Agrees = (int)rdr["Agrees"]
					};

					if (state == 2)
						result.Answer = GetAnswer(int.Parse(ID));
				}

				// Connection Close
				conn.Close();
			}

			return result;
		}

		/// <summary>
		/// Petition 답변을 반환하는 메서드
		/// </summary>
		/// <param name="ID">청원 ID</param>  
		/// <see cref="Petition"/>
		public static string GetAnswer(int ID) {
			string result = "";

			// Connect to DB
			using (var conn = new MySqlConnection(System.Configuration.ConfigurationManager.ConnectionStrings["COUNCILDB"].ConnectionString)) {
				conn.Open();

				// Command Text - Get Count
				string sql = "SELECT Answer FROM answers WHERE PetitionID='" + ID + "';";
				MySqlCommand cmd = new MySqlCommand(sql, conn);
				result = (string)cmd.ExecuteScalar();

				// Connection Close
				conn.Close();
			}

			return result;
		}

		/// <summary>
		/// 청원 상태를 조정하는 메서드
		/// </summary>
		/// <param name="ID">청원 일련번호</param>  
		/// <param name="state">청원 상태</param>  
		/// <see cref="Petition"/>
		public static void PetitionCheck(int ID, int state) {
			using (var conn = new MySqlConnection(System.Configuration.ConfigurationManager.ConnectionStrings["COUNCILDB"].ConnectionString)) {
				conn.Open();

				// Update Petition State
				string sql = "UPDATE " + PETITIONS + " SET State='" + state + "' WHERE ID='" + ID + "';";
				MySqlCommand cmd = new MySqlCommand(sql, conn);
				cmd.ExecuteNonQuery();

				conn.Close();
			}
		}

		/// <summary>
		/// 청원에 동의 수를 1 증가시키는 메서드
		/// </summary>
		/// <param name="ID">청원 일련번호</param>  
		/// <param name="userID">User ID</param>  
		/// <see cref="Petition"/>
		public static void AgreePetition(int ID, string userID) {
			using (var conn = new MySqlConnection(System.Configuration.ConfigurationManager.ConnectionStrings["COUNCILDB"].ConnectionString)) {
				conn.Open();

				// 이미 동의 했는지 동의 여부 검사
				string sql = "SELECT EXISTS(SELECT * FROM agrees WHERE PetitionID='" + ID + "' AND UserID='" + userID + "') AS SUCCESS;";
				MySqlCommand cmd = new MySqlCommand(sql, conn);

				if (Convert.ToInt32(cmd.ExecuteScalar()) == 0) {
					sql = "INSERT INTO agrees(PetitionID, UserID) VALUES (?, ?);";
					cmd.CommandText = sql;
					cmd.Parameters.Add("PetitionID", MySqlDbType.Int32).Value = ID;
					cmd.Parameters.Add("UserID", MySqlDbType.VarChar).Value = userID;
					cmd.ExecuteNonQuery();

					sql = "UPDATE " + PETITIONS + " SET Agrees = Agrees + 1 WHERE ID='" + ID + "';";
					cmd.CommandText = sql;
					cmd.ExecuteNonQuery();
				}

				conn.Close();
			}
		}

		/// <summary>
		/// 청원 동의 여부를 반환하는 메서드
		/// </summary>
		/// <param name="ID">청원 일련번호</param>  
		/// <param name="userID">User ID</param>  
		/// <see cref="Petition"/>
		public static bool IsAgree(string ID, string userID) {
			using (var conn = new MySqlConnection(System.Configuration.ConfigurationManager.ConnectionStrings["COUNCILDB"].ConnectionString)) {
				conn.Open();

				// 이미 동의 했는지 동의 여부 검사
				string sql = "SELECT EXISTS(SELECT * FROM agrees WHERE PetitionID='" + ID + "' AND UserID='" + userID + "') AS SUCCESS;";
				MySqlCommand cmd = new MySqlCommand(sql, conn);

				if (Convert.ToInt32(cmd.ExecuteScalar()) == 0) {
					conn.Close();

					return false;
				} else {
					conn.Close();

					return true;
				}
			}
		}

		/// <summary>
		/// 공감순으로 청원을 반환하는 메서드
		/// </summary>
		/// <param name="count">가져올 청원 개수</param>  
		/// <see cref="Petition"/>
		public static List<Petition> GetPetitionsByAgrees(int count) {
			var result = new List<Petition>();

			using (var conn = new MySqlConnection(System.Configuration.ConfigurationManager.ConnectionStrings["COUNCILDB"].ConnectionString)) {
				conn.Open();

				// Get 2 Petition by Agrees
				string sql = "SELECT * FROM petitions WHERE State='1' AND (DATE_ADD(NOW(), INTERVAL -1 MONTH ) < PetitionAt) ORDER BY Agrees DESC LIMIT " + count + ";";
				MySqlCommand cmd = new MySqlCommand(sql, conn);
				var rdr = cmd.ExecuteReader();
				while (rdr.Read()) {
					result.Add(new Petition {
						ID = Convert.ToInt32(rdr["ID"]),
						Title = (string)rdr["Title"],
						Content = (string)rdr["Content"],
						UserID = (string)rdr["UserID"],
						PetitionAt = (DateTime)rdr["PetitionAt"],
						Agrees = (int)rdr["Agrees"]
					});
				}

				conn.Close();
			}

			return result;
		}
	}
}
