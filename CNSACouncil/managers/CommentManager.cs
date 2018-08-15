using CNSACouncil.Models;
using MySql.Data.MySqlClient;

namespace CNSACouncil.Managers {
	public static class CommentManager {
		// Table Name
		private const string COMMENTS = "comments";

		/// <summary>
		/// 댓글을 추가하는 메서드
		/// </summary>
		/// <param name="comment">Comment class in Models</param>  
		/// <see cref="Comment"/>
		public static void AddComment(Comment comment) {
			// Connect to DB
			using (var conn = new MySqlConnection(System.Configuration.ConfigurationManager.ConnectionStrings["COUNCILDB"].ConnectionString)) {
				conn.Open();

				// Command Text - Create
				string commandText = "INSERT INTO " + COMMENTS + "(PostID, Content, WriterID, CommentAt, Classification) VALUES (?, ?, ?, ?, ?);";
				var cmd = new MySqlCommand(commandText, conn);
				cmd.Parameters.Add("PostID", MySqlDbType.Int32).Value = comment.PostID;
				cmd.Parameters.Add("Content", MySqlDbType.VarChar).Value = comment.Content;
				cmd.Parameters.Add("WriterID", MySqlDbType.VarChar).Value = comment.WriterID;
				cmd.Parameters.Add("CommentAt", MySqlDbType.DateTime).Value = comment.CommentAt;
				cmd.Parameters.Add("Classification", MySqlDbType.Int32).Value = comment.Classification;

				// The number of rows affected
				cmd.ExecuteNonQuery();

				// Connection Close
				conn.Close();
			}
		}
	}
}