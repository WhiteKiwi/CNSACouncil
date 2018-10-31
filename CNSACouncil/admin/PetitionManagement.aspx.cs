using CNSACouncil.Managers;
using MySql.Data.MySqlClient;
using System;
using System.Data;
using System.Web.Services;
namespace CNSACouncil.admin {
	public partial class PetitionManagement : System.Web.UI.Page {
		const int elementCount = 5;

		protected void Page_Load(object sender, EventArgs e) {
			if (!IsPostBack) {
				repeater.DataSource = GetPetitionsData(1, Request.QueryString["state"]);
				repeater.DataBind();
			}
		}

		public static DataSet GetPetitionsData(int page, string stateValue) {
			int state;

			if (stateValue == "awaitingAnswer") {
				state = 1;
			} else if (stateValue == "delayed") {
				state = -1;
			} else {
				state = 0;
			}

//			string sql = "SELECT * FROM petitions WHERE State='" + state + "' " + (state == 1 ? "" : "AND EndAt > ADDTIME(NOW(), '09:00:00') ") + "ORDER BY ID DESC LIMIT 5 OFFSET " + ((page - 1) * elementCount) + ";";
			string sql = "SELECT * FROM petitions WHERE State='" + state + "' ORDER BY ID DESC LIMIT 5 OFFSET " + ((page - 1) * elementCount) + ";";
			MySqlCommand cmd = new MySqlCommand(sql);

			return GetData(cmd, state);
		}

		private static DataSet GetData(MySqlCommand cmd, int state) {
			using (var conn = new MySqlConnection(System.Configuration.ConfigurationManager.ConnectionStrings["COUNCILDB"].ConnectionString)) {
				conn.Open();

				using (MySqlDataAdapter msda = new MySqlDataAdapter()) {
					cmd.Connection = conn;
					msda.SelectCommand = cmd;

					using (DataSet ds = new DataSet()) {
						msda.Fill(ds, "Petition");

						DataTable dt = new DataTable("PageCount");
						dt.Columns.Add("PageCount");
						dt.Rows.Add();
						int petitionsCount = PetitionManager.GetPetitionsCount(state);
						dt.Rows[0][0] = petitionsCount % 5 == 0 ? petitionsCount / elementCount : petitionsCount / elementCount + 1;
						ds.Tables.Add(dt);

						conn.Close();
						return ds;
					}
				}
			}
		}

		[WebMethod]
		public static string GetPetitions(int pageIndex, string state) {
			return GetPetitionsData(pageIndex, state).GetXml();
		}
	}
}