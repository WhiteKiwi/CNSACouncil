using CNSACouncil.Models;
using MySql.Data.MySqlClient;
using System;
using System.Collections.Generic;

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
				string commandText = "INSERT INTO " + NOTICES + "(Title, Content, NoticeAt) VALUES (?, ?, ?);";
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

		/// <summary>
		/// 페이지에 해당하는 공지들을 반환하는 함수
		/// </summary>
		/// <param name="page">요청한 페이지 번호</param>  
		/// <see cref="Notice"/>
		public static List<Notice> GetNoticeByPage(int page) {
			var result = new List<Notice>();

			// Connect to DB;
			using (var conn = new MySqlConnection(System.Configuration.ConfigurationManager.ConnectionStrings["COUNCILDB"].ConnectionString)) {
				conn.Open();

				// Get Notice Count
				string sql = "SELECT count(*) FROM " + NOTICES + ";";
				MySqlCommand cmd = new MySqlCommand(sql, conn);
				int NoticeCount = Convert.ToInt32(cmd.ExecuteScalar());

				// Get Notice
				sql = "SELECT * FROM " + NOTICES + " ORDER BY ID DESC LIMIT 10 OFFSET " + ((page - 1) * 10) + ";";
				cmd.CommandText = sql;

				var rdr = cmd.ExecuteReader();
				while (rdr.Read()) {
					result.Add(new Notice {
						ID = (int)rdr["ID"],
						Title = (string)rdr["Title"],
						Content = (string)rdr["Content"],
						NoticeAt = (DateTime)rdr["NoticeAt"]
					});
				}

			}
			return result;
		}

		/// <summary>
		/// 공지의 개수를 반환하는 함수
		/// </summary>
		/// <see cref="Notice"/>
		public static int GetNoticeCount() {
			using (var conn = new MySqlConnection(System.Configuration.ConfigurationManager.ConnectionStrings["COUNCILDB"].ConnectionString)) {
				conn.Open();

				// Get Notices Count
				string sql = "SELECT count(*) FROM " + NOTICES + ";";
				MySqlCommand cmd = new MySqlCommand(sql, conn);
				int result = Convert.ToInt32(cmd.ExecuteScalar());

				conn.Close();

				return result;
			}
		}

		/// <summary>
		/// 메인 페이지 리스팅을 위해 공지를 최신순으로 가져오는 함수
		/// </summary>
		/// <see cref="Notice"/>
		public static List<Notice> GetNoticesByNoticeAt(int count) {
			var result = new List<Notice>();

			using (var conn = new MySqlConnection(System.Configuration.ConfigurationManager.ConnectionStrings["COUNCILDB"].ConnectionString)) {
				conn.Open();

				// Get Notices
				string sql = "SELECT * FROM " + NOTICES + " ORDER BY NoticeAt DESC LIMIT " + count + ";";
				MySqlCommand cmd = new MySqlCommand(sql, conn);
				var rdr = cmd.ExecuteReader();

				while (rdr.Read()) {
					result.Add(new Notice {
						ID = (int)rdr["ID"],
						Title = (string)rdr["Title"],
						NoticeAt = (DateTime)rdr["NoticeAt"]
					});
				}

				conn.Close();
			}

			return result;
		}
		
		/// <summary>
		 /// 공지를 가져오는 메서드
		 /// </summary>
		 /// <param name="id">공지 일련번호</param>  
		 /// <see cref="Notice"/>
		public static Notice GetNotice(int ID) {
			Notice result = null;

			// Connect to DB
			using (var conn = new MySqlConnection(System.Configuration.ConfigurationManager.ConnectionStrings["COUNCILDB"].ConnectionString)) {
				conn.Open();

				// Command Text - Get Notice
				string sql = "SELECT * FROM " + NOTICES + " WHERE ID='" + ID + "';";
				MySqlCommand cmd = new MySqlCommand(sql, conn);
				var rdr = cmd.ExecuteReader();
				if (rdr.Read()) {
					result = new Notice {
						ID = ID,
						Title = (string)rdr["Title"],
						Content = (string)rdr["Content"],
						NoticeAt = (DateTime)rdr["NoticeAt"]
					};
				}

				// Connection Close
				conn.Close();
			}

			return result;
		}
	}
}