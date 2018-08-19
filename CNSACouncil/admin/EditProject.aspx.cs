using CNSACouncil.Managers;
using CNSACouncil.Models;
using System;
using System.IO;

namespace CNSACouncil.admin {
	public partial class EditProject : System.Web.UI.Page {
		Project project = null;

		protected void Page_Load(object sender, EventArgs e) {

		}

		protected void Page_Init(object sender, EventArgs e) {
			int id = int.Parse(Request.QueryString["id"]);

			project = ProjectManager.GetProject(id);

			ProjectTitle.Text = project.Title;
			ProjectStartAt.Text = project.StartAt.ToString("yyyy-MM-dd");
			ProjectEndAt.Text = project.EndAt.ToString("yyyy-MM-dd") == "2014-03-01" ? "" : project.EndAt.ToString("yyyy-MM-dd");
			Content.Text = project.Content;
		}

		protected void EditButton_Click(object sender, EventArgs e) {
			EditButton.Enabled = false;

			if (ProjectPicture.HasFile) {
				// 파일 이름 (yyyy-MM-dd + FileName)
				string fileName = DateTime.Now.AddHours(9).ToString("yyyy-MM-dd") + Path.GetFileName(ProjectPicture.FileName);
				// 파일 저장
				ProjectPicture.PostedFile.SaveAs(Server.MapPath("/assets/images/") + fileName);

				ProjectManager.EditProject(new Project {
					ID = project.ID,
					Title = ProjectTitle.Text,
					Content = Content.Text,
					StartAt = Convert.ToDateTime(ProjectStartAt.Text),
					EndAt = Convert.ToDateTime(string.IsNullOrEmpty(ProjectEndAt.Text.Trim()) ? "2014-03-01" : ProjectEndAt.Text.Trim()),
					State = string.IsNullOrEmpty(ProjectEndAt.Text.Trim()) ? 0 : 1,
					FileName = fileName
				});

				EditButton.Enabled = true;
				Response.Redirect("/admin/ProjectManagement.aspx");
			} else {
				// File 없음
				ProjectManager.EditProject(new Project {
					ID = project.ID,
					Title = ProjectTitle.Text,
					Content = Content.Text,
					StartAt = Convert.ToDateTime(ProjectStartAt.Text),
					EndAt = Convert.ToDateTime(string.IsNullOrEmpty(ProjectEndAt.Text.Trim()) ? "2014-03-01" : ProjectEndAt.Text.Trim()),
					State = string.IsNullOrEmpty(ProjectEndAt.Text.Trim()) ? 0 : 1,
					FileName = project.FileName
				});

				EditButton.Enabled = true;
				Response.Redirect("/admin/ProjectManagement.aspx");
			}

			EditButton.Enabled = true;
		}
	}
}