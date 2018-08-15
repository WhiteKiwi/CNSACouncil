using CNSACouncil.Models;
using MySql.Data.MySqlClient;
using System;
using System.Collections.Generic;

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

		/// <summary>
		/// 글 번호, 분류에 해당하는 댓글을 반환하는 메서드
		/// </summary>
		/// <param name="id">요청한 글 번호</param>  
		/// <param name="classification">요청한 분류</param>  
		/// <see cref="Comment"/>
		public static List<Comment> GetComments(int id, int classification) {
			var result = new List<Comment>();

			// Connect to DB;
			using (var conn = new MySqlConnection(System.Configuration.ConfigurationManager.ConnectionStrings["COUNCILDB"].ConnectionString)) {
				conn.Open();

				// Get Comments
				string sql = "SELECT* FROM " + COMMENTS + " WHERE Classification='" + classification + "' AND PostID='" + id + "';";
				MySqlCommand cmd = new MySqlCommand(sql, conn);

				var rdr = cmd.ExecuteReader();
				while (rdr.Read()) {
					result.Add(new Comment {
						PostID = (int)rdr["PostID"],
						Content = (string)rdr["Content"],
						WriterID = (string)rdr["WriterID"],
						CommentAt = (DateTime)rdr["CommentAt"],
						Classification = (int)rdr["Classification"]
					});
				}
			}
			return result;
		}
	}
}