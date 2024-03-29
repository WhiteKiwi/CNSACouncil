﻿using CNSACouncil.Models;
using MySql.Data.MySqlClient;
using System;
using System.Collections.Generic;

namespace CNSACouncil.Managers {
	public static class ProjectManager {
		// Table Name
		private const string PROJECTS = "projects";

		/// <summary>
		/// ID와 마감일를 받아 완료된 사업으로 체크하는 메서드 추가
		/// </summary>
		/// <param name="ID">사업 일련번호</param>  
		/// <param name="endAt">사업 완료일</param>  
		/// <see cref="Project"/>
		public static void ProjectCheck(string ID, string endAt) {
			using (var conn = new MySqlConnection(System.Configuration.ConfigurationManager.ConnectionStrings["COUNCILDB"].ConnectionString)) {
				conn.Open();

				// Update Suggestion State
				string sql = "UPDATE " + PROJECTS + " SET State='1', EndAt='"+endAt+"' WHERE ID='" + ID + "';";
				MySqlCommand cmd = new MySqlCommand(sql, conn);
				cmd.ExecuteNonQuery();

				conn.Close();
			}
		}

		/// <summary>
		/// 사업을 추가하는 메서드
		/// </summary>
		/// <param name="project">Project class in Models</param>  
		/// <see cref="Project"/>
		public static int UploadProject(Project project) {
			// Connect to DB
			using (var conn = new MySqlConnection(System.Configuration.ConfigurationManager.ConnectionStrings["COUNCILDB"].ConnectionString)) {
				conn.Open();

				// Command Text - Create
				string commandText = "INSERT INTO " + PROJECTS + "(TItle, Content, StartAt, FileName) VALUES (?, ?, ?, ?);";
				var cmd = new MySqlCommand(commandText, conn);
				cmd.Parameters.Add("Title", MySqlDbType.VarChar).Value = project.Title;
				cmd.Parameters.Add("Content", MySqlDbType.VarChar).Value = project.Content;
				cmd.Parameters.Add("StartAt", MySqlDbType.Date).Value = project.StartAt;
				cmd.Parameters.Add("FileName", MySqlDbType.VarChar).Value = project.FileName;

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
		/// 메인 페이지 리스팅을 위해 사업들을 최신순으로 가져오는 메서드
		/// </summary>
		/// <see cref="Project"/>
		public static List<Project> GetProjectsByStartAt(int count) {
			var result = new List<Project>();

			using (var conn = new MySqlConnection(System.Configuration.ConfigurationManager.ConnectionStrings["COUNCILDB"].ConnectionString)) {
				conn.Open();

				// Get Projects
				string sql = "SELECT * FROM " + PROJECTS + " ORDER BY StartAt DESC LIMIT " + count + ";";
				MySqlCommand cmd = new MySqlCommand(sql, conn);
				var rdr = cmd.ExecuteReader();

				while (rdr.Read()) {
					result.Add(new Project {
						ID = (int)rdr["ID"],
						Title = (string)rdr["Title"],
						StartAt = (DateTime)rdr["StartAt"],
						EndAt = (DateTime)rdr["EndAt"],
						State = (int)rdr["State"]
					});
				}

				conn.Close();
			}

			return result;
		}

		/// <summary>
		/// 사업들을 State에 따라 반환하는 메서드
		/// </summary>
		/// <see cref="Project"/>
		public static List<Project> GetProjectsByState(int state) {
			var result = new List<Project>();

			using (var conn = new MySqlConnection(System.Configuration.ConfigurationManager.ConnectionStrings["COUNCILDB"].ConnectionString)) {
				conn.Open();

				// Get Projects
				string sql = "SELECT * FROM " + PROJECTS + " WHERE State='" + state + "';";
				MySqlCommand cmd = new MySqlCommand(sql, conn);
				var rdr = cmd.ExecuteReader();

				while (rdr.Read()) {
					result.Add(new Project {
						ID = (int)rdr["ID"],
						Title = (string)rdr["Title"],
						StartAt = (DateTime)rdr["StartAt"],
						EndAt = (DateTime)rdr["EndAt"],
						FileName = (string)rdr["FileName"]
					});
				}

				conn.Close();
			}

			return result;
		}

		/// <summary>
		/// 사업들을 반환하는 메서드
		/// </summary>
		/// <see cref="Project"/>
		public static List<Project> GetProjects() {
			var result = new List<Project>();

			using (var conn = new MySqlConnection(System.Configuration.ConfigurationManager.ConnectionStrings["COUNCILDB"].ConnectionString)) {
				conn.Open();

				// Get Projects
				string sql = "SELECT * FROM " + PROJECTS + ";";
				MySqlCommand cmd = new MySqlCommand(sql, conn);
				var rdr = cmd.ExecuteReader();

				while (rdr.Read()) {
					result.Add(new Project {
						ID = (int)rdr["ID"],
						Title = (string)rdr["Title"],
						StartAt = (DateTime)rdr["StartAt"],
						EndAt = (DateTime)rdr["EndAt"],
						FileName = (string)rdr["FileName"],
						State = (int)rdr["State"]
					});
				}

				conn.Close();
			}

			return result;
		}

		/// <summary>
		/// 사업을 가져오는 메서드
		/// </summary>
		/// <param name="ID">사업 일련번호</param>  
		/// <see cref="Project"/>
		public static Project GetProject(int ID) {
			Project result = null;

			// Connect to DB
			using (var conn = new MySqlConnection(System.Configuration.ConfigurationManager.ConnectionStrings["COUNCILDB"].ConnectionString)) {
				conn.Open();

				// Command Text - Get Notice
				string sql = "SELECT * FROM " + PROJECTS + " WHERE ID='" + ID + "';";
				MySqlCommand cmd = new MySqlCommand(sql, conn);
				var rdr = cmd.ExecuteReader();
				if (rdr.Read()) {
					result = new Project {
						ID = ID,
						Title = (string)rdr["Title"],
						Content = (string)rdr["Content"],
						StartAt = (DateTime)rdr["StartAt"],
						EndAt = (DateTime)rdr["EndAt"],
						FileName = (string)rdr["FileName"],
						State = (int)rdr["State"]
					};
				}

				// Connection Close
				conn.Close();
			}

			return result;
		}

		/// <summary>
		/// 사업을 수정 메서드
		/// </summary>
		/// <param name="ID">사업 일련번호</param>  
		/// <see cref="Project"/>
		public static void EditProject(Project project) {
			// Connect to DB
			using (var conn = new MySqlConnection(System.Configuration.ConfigurationManager.ConnectionStrings["COUNCILDB"].ConnectionString)) {
				conn.Open();

				// Command Text - Get Notice
				string sql = "UPDATE " + PROJECTS + " SET Title='" + project.Title + "', Content='" + project.Content + "', StartAt='" + project.StartAt.ToString("yyyy-MM-dd") + "', EndAt='" + project.EndAt.ToString("yyyy-MM-dd") + "', State='" + project.State + "', FileName='" + project.FileName + "' WHERE ID='" + project.ID + "';";
				MySqlCommand cmd = new MySqlCommand(sql, conn);
				cmd.ExecuteNonQuery();

				// Connection Close
				conn.Close();
			}
		}
	}
}