using CNSACouncil.Managers;
using System;

namespace CNSACouncil {
	public partial class ANotice : System.Web.UI.Page {
		protected void Page_Load(object sender, EventArgs e) {

		}

		protected void CommentButton_Click(object sender, EventArgs e) {
			if (string.IsNullOrEmpty(Content.Text.Trim())) {
				Response.Write("<script>alert('내용을 입력해주세요.');</script>");
			} else if (Session["UserID"] == null) {
				// 로그인 페이지로 Redirect
				Response.Redirect("/Login.aspx?classification=0&id=" + int.Parse(Request.QueryString["id"]));
			} else {
				CommentButton.Enabled = false;

				CommentManager.AddComment(new Models.Comment {
					PostID = int.Parse(Request.QueryString["id"]),
					Content = Content.Text,
					WriterID = (string)Session["UserID"],
					CommentAt = DateTime.Now.AddHours(9),
					Classification = 0
				});

				CommentButton.Enabled = true;

				Response.Redirect(Request.RawUrl);
			}
		}
	}
}