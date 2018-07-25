﻿using System;

namespace CNSACouncil {
	public partial class Suggest : System.Web.UI.Page {
		protected void Page_Load(object sender, EventArgs e) {

		}

		protected void SuggestButton_Click(object sender, EventArgs e) {
			SuggestButton.Enabled = false;

			// 건의 추가
			Managers.SuggestionManager.UploadSuggestion(new Models.Suggestion {
				Title = SuggestionTitle.Text,
				Content = Content.Text,
				IP = Request.UserHostAddress,
				SuggestAt = DateTime.Now.AddHours(9)
			});
			// TODO: 건의 성공, 건의 실패 판별

			Response.Redirect("/Suggest.aspx");
		}
	}
}