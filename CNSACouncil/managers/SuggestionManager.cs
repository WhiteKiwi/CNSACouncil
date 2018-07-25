using CNSACouncil.Models;
using MySql.Data.MySqlClient;

namespace CNSACouncil.Managers {
	public static class SuggestionManager {
		// Table Name
		private const string SUGGESTIONS = "suggestions";

		/// <summary>
		/// 건의를 추가하는 함수
		/// </summary>
		/// <param name="suggestion">Suggestion class in Models</param>  
		/// <see cref="Suggestion"/>
		public static int UploadSuggestion(Suggestion suggestion) {
			// Connect to DB
			using (var conn = new MySqlConnection(System.Configuration.ConfigurationManager.ConnectionStrings["COUNCILDB"].ConnectionString)) {
				conn.Open();

				// Command Text - Create
				string commandText = "INSERT INTO " + SUGGESTIONS+ "(Title, Content, IP, SuggestAt) VALUES (?, ?, ?, ?);";
				var cmd = new MySqlCommand(commandText, conn);
				cmd.Parameters.Add("Title", MySqlDbType.VarChar).Value = suggestion.Title;
				cmd.Parameters.Add("Content", MySqlDbType.VarChar).Value = suggestion.Content;
				cmd.Parameters.Add("IP", MySqlDbType.VarChar).Value = suggestion.IP;
				cmd.Parameters.Add("SuggestAt", MySqlDbType.DateTime).Value = suggestion.SuggestAt;

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