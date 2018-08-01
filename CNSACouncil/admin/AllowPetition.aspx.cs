using CNSACouncil.Managers;
using System;

namespace CNSACouncil.admin {
	public partial class AllowPetition : System.Web.UI.Page {
		protected void Page_Load(object sender, EventArgs e) {

		}

		protected void AllowButton_Click(object sender, EventArgs e) {
			AllowButton.Enabled = false;
			PetitionManager.PetitionCheck(int.Parse(Request.QueryString["id"]), 1);
			AllowButton.Enabled = true;

			Response.Redirect("/admin/PetitionManagement.aspx");
		}

		protected void DelayButton_Click(object sender, EventArgs e) {
			AllowButton.Enabled = false;
			PetitionManager.PetitionCheck(int.Parse(Request.QueryString["id"]), -1);
			AllowButton.Enabled = true;

			Response.Redirect("/admin/PetitionManagement.aspx");
		}
	}
}