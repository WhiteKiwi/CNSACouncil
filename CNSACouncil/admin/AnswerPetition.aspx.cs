using CNSACouncil.Managers;
using System;

namespace CNSACouncil.admin {
	public partial class AnswerPetition : System.Web.UI.Page {
		protected void Page_Load(object sender, EventArgs e) {
			AnswerContent.FilebrowserImageUploadUrl = "/admin/Upload.ashx";
		}

		protected void AnswerButton_Click(object sender, EventArgs e) {
			AnswerButton.Enabled = false;

			if (string.IsNullOrEmpty(AnswerContent.Text.Trim())) {
				Response.Write("<script>alert('답변 내용을 입력해주세요.')</script>");
			} else {
				PetitionManager.AddAnswer(int.Parse(Request.QueryString["id"]) ,AnswerContent.Text);

				Response.Redirect("/admin/PetitionManagement.aspx?state=awaitingAnswer");
			}

			AnswerButton.Enabled = true;
		}
	}
}