using CNSACouncil.Managers;
using CNSACouncil.Models;
using System;
using System.IO;

namespace CNSACouncil.admin {
	public partial class AddProject : System.Web.UI.Page {
		protected void Page_Load(object sender, EventArgs e) {
			Content.FilebrowserImageUploadUrl = "/admin/Upload.ashx";
		}

		protected void UploadButton_Click(object sender, EventArgs e) {
			UploadButton.Enabled = false;

			if (ProjectPicture.HasFile) {
				// 파일 이름 (yyyy-MM-dd + FileName)
				string fileName = DateTime.Now.AddHours(9).ToString("yyyy-MM-dd") + Path.GetFileName(ProjectPicture.FileName);
				// 파일 저장
				ProjectPicture.PostedFile.SaveAs(Server.MapPath("/assets/images/") + fileName);

				ProjectManager.UploadProject(new Project {
					Title = ProjectTitle.Text,
					Content = Content.Text,
					StartAt = Convert.ToDateTime(ProjectStartAt.Text),
					FileName = fileName
				});

				UploadButton.Enabled = true;
				Response.Redirect("/admin/ProjectManagement.aspx");
			} else {
				// File 없음
				Response.Write("<script>alert('대표사진을 추가해주세요');</script>");
			}

			UploadButton.Enabled = true;
		}
	}
}