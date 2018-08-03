using System;

namespace CNSACouncil {
	public partial class Suggest : System.Web.UI.Page {
		protected void Page_Load(object sender, EventArgs e) {

		}

		protected void SuggestButton_Click(object sender, EventArgs e) {
			SuggestButton.Enabled = false;

			if (string.IsNullOrEmpty(SuggestionTitle.Text.Trim())) // 제목이 비어있을 경우
				Response.Write("<script>alert('제목을 작성해주세요.');</script>");
			else if (string.IsNullOrEmpty(Content.Text.Trim())) // 내용이 비어 있을 경우
				Response.Write("<script>alert('내용을 작성해주세요.');</script>");
			else {
				// 건의 추가
				if (Managers.SuggestionManager.UploadSuggestion(new Models.Suggestion {
					Title = SuggestionTitle.Text,
					Content = Content.Text.Replace("\r\n", "<br/>"),
					IP = Request.UserHostAddress,
					SuggestAt = DateTime.Now.AddHours(9)
				}) == 0)
					Response.Write("<script>alert('건의에 실패했습니다. 다시 시도해주세요.');</script>");
				else {
					SuggestButton.Enabled = true;
					Response.Redirect("/Suggest.aspx");
				}
			}

			SuggestButton.Enabled = true;
		}
	}
}