using System;
using System.Collections.Generic;
using CNSACouncil.Models;
using MySql.Data.MySqlClient;

namespace CNSACouncil.Managers {
	public static class ProjectManager {
		// Table Name
		private const string PROJECTS = "projects";

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
	}
}