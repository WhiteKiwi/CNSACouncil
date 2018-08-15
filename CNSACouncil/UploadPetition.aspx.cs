using System;

namespace CNSACouncil {
	public partial class UploadPetition : System.Web.UI.Page {
		protected void Page_Load(object sender, EventArgs e) {
			// 세션이 비어 있을 경우
			if (Session["UserID"] == null) {
				// 로그인 페이지로 Redirect
				Response.Redirect("/Login.aspx?classification=1");
			}
		}

		protected void PetitionButton_Click(object sender, EventArgs e) {
			PetitionButton.Enabled = false;

			if (string.IsNullOrEmpty(PetitionTitle.Text.Trim())) // 제목이 비어있을 경우
				Response.Write("<script>alert('제목을 작성해주세요.');</script>");
			else if (string.IsNullOrEmpty(Content.Text.Trim())) // 내용이 비어 있을 경우
				Response.Write("<script>alert('내용을 작성해주세요.');</script>");
			else {
				// 청원 추가
				if (Managers.PetitionManager.UploadPetition(new Models.Petition {
					UserID = (string)Session["UserID"],
					Title = PetitionTitle.Text,
					Content = Content.Text.Replace("\r\n", "<br/>"),
					IP = Request.UserHostAddress,
					PetitionAt = DateTime.Now.AddHours(9)
				}) == 0)
					Response.Write("<script>alert('청원에 실패했습니다. 다시 시도해주세요.');</script>");
				else {
					PetitionButton.Enabled = true;
					Response.Redirect("/Petitions.aspx");
				}
			}

			PetitionButton.Enabled = true;
		}
	}
}