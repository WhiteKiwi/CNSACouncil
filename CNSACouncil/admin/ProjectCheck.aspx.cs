using CNSACouncil.Managers;
using System;

namespace CNSACouncil.admin {
	public partial class ProjectCheck : System.Web.UI.Page {
		protected void Page_Load(object sender, EventArgs e) {
			if (Request.Form["id"] != null) {
				ProjectManager.ProjectCheck(Request.Form["id"], Request.Form["endAt"]);
			}

			Response.Redirect("/admin/ProjectManagement.aspx");
		}
	}
}