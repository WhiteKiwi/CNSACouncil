using System;

namespace CNSACouncil.admin {
	public partial class UploadNotice : System.Web.UI.Page {
		protected void Page_Load(object sender, EventArgs e) {

		}

		protected void UploadButton_Click(object sender, EventArgs e) {
			UploadButton.Enabled = false;

			if (string.IsNullOrEmpty(NoticeTitle.Text.Trim())) // 제목이 비어있을 경우
				Response.Write("<script>alert('제목을 작성해주세요.');</script>");
			else if (string.IsNullOrEmpty(Content.Text.Trim())) // 내용이 비어 있을 경우
				Response.Write("<script>alert('내용을 작성해주세요.');</script>");
			else {
				// 건의 추가
				if (Managers.NoticeManager.UploadNotice(new Models.Notice {
					Title = NoticeTitle.Text,
					Content = Content.Text,
					NoticeAt = DateTime.Now.AddHours(9)
				}) == 0)
					Response.Write("<script>alert('건의에 실패했습니다. 다시 시도해주세요.');</script>");
				else {
					UploadButton.Enabled = true;
					Response.Redirect("/admin/UploadNotice.aspx");
				}
			}

			UploadButton.Enabled = true;
		}
	}
}