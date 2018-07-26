using System;
using CNSACouncil.Managers;

namespace CNSACouncil.admin {
	public partial class SuggestionCheck : System.Web.UI.Page {
		protected void Page_Load(object sender, EventArgs e) {
			if (Request.QueryString["SuggestionID"] != null) {
				SuggestionManager.SuggestionCheck(Request.QueryString["SuggestionID"]);
			}

			Response.Redirect("/admin/SuggestionManagement.aspx");
		}
	}
}