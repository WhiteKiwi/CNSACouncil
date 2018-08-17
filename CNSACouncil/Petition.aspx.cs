using CNSACouncil.Managers;
using System;

namespace CNSACouncil {
	public partial class APetition : System.Web.UI.Page {
		protected void Page_Load(object sender, EventArgs e) {
			// 공감 여부 버튼에 반영
			if (CNSACouncil.Managers.PetitionManager.IsAgree(Request.QueryString["id"], (string)Session["UserID"])) {
				AgreeButton.Enabled = false;
				AgreeButton.Text = "공감함";
			}
		}

		protected void AgreeButton_Click(object sender, EventArgs e) {
			AgreeButton.Enabled = false;

			if (Session["UserID"] != null) {
				PetitionManager.AgreePetition(int.Parse(Request.QueryString["id"]), (string)Session["UserID"]);
				Response.Redirect(Request.RawUrl);
			} else {
				Response.Redirect("/Login.aspx?classification=1&id=" + Request.QueryString["id"]);
			}
		}

		protected void CommentButton_Click(object sender, EventArgs e) {
			if (string.IsNullOrEmpty(Content.Text.Trim())) {
				Response.Write("<script>alert('내용을 입력해주세요.');</script>");
			} else if (Session["UserID"] == null) {
				// 로그인 페이지로 Redirect
				Response.Redirect("/Login.aspx?classification=1&order=" + Request.QueryString["order"] + "&id=" + Request.QueryString["id"]);
			} else {
				CommentButton.Enabled = false;

				CommentManager.AddComment(new Models.Comment {
					PostID = int.Parse(Request.QueryString["id"]),
					Content = Content.Text,
					WriterID = (string)Session["UserID"],
					CommentAt = DateTime.Now.AddHours(9),
					Classification = 1
				});

				CommentButton.Enabled = true;

				Response.Redirect(Request.RawUrl);
			}
		}
	}
}