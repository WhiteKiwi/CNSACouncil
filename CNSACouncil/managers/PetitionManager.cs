using CNSACouncil.Models;
using MySql.Data.MySqlClient;
using System;

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
				result = System.Convert.ToInt32(cmd.ExecuteScalar());


				// Connection Close
				conn.Close();
			}

			return result;
		}

		/// <summary>
		/// 동의 개수를 반환하는 메서드
		/// </summary>
		/// <param name="ID">청원 ID</param>  
		/// <see cref="Petition"/>
		public static int GetAgreesCount(int ID) {
			int result = 0;

			// Connect to DB
			using (var conn = new MySqlConnection(System.Configuration.ConfigurationManager.ConnectionStrings["COUNCILDB"].ConnectionString)) {
				conn.Open();

				// Command Text - Get Count
				string sql = "SELECT count(*) FROM agrees WHERE PetitionID='" + ID + "';";
				MySqlCommand cmd = new MySqlCommand(sql, conn);
				result = System.Convert.ToInt32(cmd.ExecuteScalar());

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
						PetitionAt = (DateTime)rdr["PetitionAt"]
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
		/// <see cref="Suggestion"/>
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
	}
}
