using CNSACouncil.Managers;
using System;

namespace CNSACouncil {
	public partial class APetition : System.Web.UI.Page {
		protected void Page_Load(object sender, EventArgs e) {

		}

		protected void AgreeButton_Click(object sender, EventArgs e) {
			AgreeButton.Enabled = false;

			PetitionManager.AgreePetition(int.Parse(Request.QueryString["id"]), (string)Session["UserID"]);
			Response.Redirect(Request.RawUrl);

			AgreeButton.Enabled = true;
		}
	}
}