﻿using CNSACouncil.Models;
using MySql.Data.MySqlClient;
using System;
using System.Collections.Generic;

namespace CNSACouncil.Managers {
	public static class SuggestionManager {
		// Table Name
		private const string SUGGESTIONS = "suggestions";

		/// <summary>
		/// 건의를 추가하는 메서드
		/// </summary>
		/// <param name="suggestion">Suggestion class in Models</param>  
		/// <see cref="Suggestion"/>
		public static int UploadSuggestion(Suggestion suggestion) {
			// Connect to DB
			using (var conn = new MySqlConnection(System.Configuration.ConfigurationManager.ConnectionStrings["COUNCILDB"].ConnectionString)) {
				conn.Open();

				// Command Text - Create
				string commandText = "INSERT INTO " + SUGGESTIONS + "(Title, Content, IP, SuggestAt) VALUES (?, ?, ?, ?);";
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

		/// <summary>
		/// 페이지에 해당하는 건의들을 반환하는 메서드
		/// </summary>
		/// <param name="page">요청한 페이지 번호</param>  
		/// <see cref="Suggestion"/>
		public static List<Suggestion> GetSuggestionByPageAndState(int page, int state) {
			var result = new List<Suggestion>();

			// Connect to DB;
			using (var conn = new MySqlConnection(System.Configuration.ConfigurationManager.ConnectionStrings["COUNCILDB"].ConnectionString)) {
				conn.Open();

				// Get Suggestion Count
				string sql = "SELECT count(*) FROM " + SUGGESTIONS + " WHERE State='" + state + "';";
				MySqlCommand cmd = new MySqlCommand(sql, conn);
				int suggestionCount = Convert.ToInt32(cmd.ExecuteScalar());

				// Get Suggestion
				sql = "SELECT * FROM " + SUGGESTIONS + " WHERE State='" + state + "' ORDER BY ID DESC LIMIT 10 OFFSET " + ((page - 1) * 10) + ";";
				cmd.CommandText = sql;

				var rdr = cmd.ExecuteReader();
				while (rdr.Read()) {
					result.Add(new Suggestion {
						ID = (int)rdr["ID"],
						Title = (string)rdr["Title"],
						Content = (string)rdr["Content"],
						SuggestAt = (DateTime)rdr["SuggestAt"]
					});
				}

			}
			return result;
		}

		/// <summary>
		/// State에 해당하는 건의의 개수를 반환하는 메서드
		/// </summary>
		/// <param name="state">건의 상태</param>  
		/// <see cref="Suggestion"/>
		public static int GetSuggestionCountByState(int state) {
			using (var conn = new MySqlConnection(System.Configuration.ConfigurationManager.ConnectionStrings["COUNCILDB"].ConnectionString)) {
				conn.Open();

				// Get Suggestion Count
				string sql = "SELECT count(*) FROM " + SUGGESTIONS + " WHERE State='" + state + "';";
				MySqlCommand cmd = new MySqlCommand(sql, conn);
				int result = Convert.ToInt32(cmd.ExecuteScalar());

				conn.Close();

				return result;
			}
		}

		/// <summary>
		/// ID를 받아 지난 건의로 이동시키는 메서드
		/// </summary>
		/// <param name="ID">건의 일련번호</param>  
		/// <see cref="Suggestion"/>
		public static void SuggestionCheck(string ID) {
			using (var conn = new MySqlConnection(System.Configuration.ConfigurationManager.ConnectionStrings["COUNCILDB"].ConnectionString)) {
				conn.Open();

				// Update Suggestion State
				string sql = "UPDATE " + SUGGESTIONS + " SET State='1' WHERE ID='" + ID + "';";
				MySqlCommand cmd = new MySqlCommand(sql, conn);
				cmd.ExecuteNonQuery();

				conn.Close();
			}
		}
	}
}