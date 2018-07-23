using CNSACouncil.Models;
using MySql.Data.MySqlClient;

namespace CNSACouncil.Managers {
	public static class PetitionManager {
		// Table Name
		private const string PETITIONS = "petitions";

		/// <summary>
		/// 청원을 추가하는 함수
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
	}
}