using CNSACouncil.Models;
using MySql.Data.MySqlClient;

namespace CNSACouncil.Managers {
	public static class NoticeManager {
		// Table Name
		private const string NOTICES = "notices";


		/// <summary>
		/// 공지를 추가하는 함수
		/// </summary>
		/// <param name="notice">Notice class in Models</param>  
		/// <see cref="Notice"/>
		public static int UploadNotice(Notice notice) {
			// Connect to DB
			using (var conn = new MySqlConnection(System.Configuration.ConfigurationManager.ConnectionStrings["COUNCILDB"].ConnectionString)) {
				conn.Open();

				// Command Text - Create
				string commandText = "INSERT INTO " + NOTICES + "(Title, Content, NoticeAt) VALUES (?, ?, ?, ?);";
				var cmd = new MySqlCommand(commandText, conn);
				cmd.Parameters.Add("Title", MySqlDbType.VarChar).Value = notice.Title;
				cmd.Parameters.Add("Content", MySqlDbType.VarChar).Value = notice.Content;
				cmd.Parameters.Add("NoticeAt", MySqlDbType.DateTime).Value = notice.NoticeAt;

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