using CNSACouncil.Managers;
using MySql.Data.MySqlClient;
using System;
using System.Data;
using System.Web.Services;

namespace CNSACouncil {
	public partial class Petitions : System.Web.UI.Page {
		const int elementCount = 5;

		protected void Page_Load(object sender, EventArgs e) {
			if (!IsPostBack) {
				repeater.DataSource = GetPetitionsData(1, Request.QueryString["order"]);
				repeater.DataBind();
			}
		}

		public static DataSet GetPetitionsData(int page, string order) {
			string sql = "SELECT * FROM petitions WHERE State='" + 1 + "' AND (DATE_ADD(NOW(), INTERVAL -1 MONTH ) < PetitionAt) ORDER BY ID DESC LIMIT 5 OFFSET " + ((page - 1) * elementCount) + ";";
			string countSql = "SELECT count(*) FROM petitions WHERE State='" + 1 + "' AND (DATE_ADD(NOW(), INTERVAL -1 MONTH ) < PetitionAt) ORDER BY ID DESC LIMIT 5 OFFSET " + ((page - 1) * elementCount) + ";";
			if (order == "best") {
				sql = "SELECT * FROM petitions WHERE State='" + 1 + "' AND (DATE_ADD(NOW(), INTERVAL -1 MONTH ) < PetitionAt) ORDER BY Agrees DESC LIMIT 5 OFFSET " + ((page - 1) * elementCount) + ";";
				countSql = "SELECT count(*) FROM petitions WHERE State='" + 1 + "' AND (DATE_ADD(NOW(), INTERVAL -1 MONTH ) < PetitionAt) ORDER BY Agrees DESC LIMIT 5 OFFSET " + ((page - 1) * elementCount) + ";";
			} else if (order == "finished") {
				sql = "SELECT * FROM petitions WHERE State='" + 1 + "' AND (DATE_ADD(NOW(), INTERVAL -1 MONTH ) >= PetitionAt) ORDER BY ID DESC LIMIT 5 OFFSET " + ((page - 1) * elementCount) + ";";
				countSql = "SELECT count(*) FROM petitions WHERE State='" + 1 + "' AND (DATE_ADD(NOW(), INTERVAL -1 MONTH ) >= PetitionAt) ORDER BY ID DESC LIMIT 5 OFFSET " + ((page - 1) * elementCount) + ";";
			} else if (order == "answer") {
				sql = "SELECT * FROM petitions WHERE State='" + 2 + "' ORDER BY ID DESC LIMIT 5 OFFSET " + ((page - 1) * elementCount) + ";";
				countSql = "SELECT count(*) FROM petitions WHERE State='" + 2 + "' ORDER BY ID DESC LIMIT 5 OFFSET " + ((page - 1) * elementCount) + ";";
			}

			MySqlCommand cmd = new MySqlCommand(sql);

			return GetData(cmd, countSql);
		}

		private static DataSet GetData(MySqlCommand cmd, string countSql) {
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
						int petitionsCount = PetitionManager.GetPetitionsCount(countSql);
						dt.Rows[0][0] = petitionsCount % 5 == 0 ? petitionsCount / elementCount : petitionsCount / elementCount + 1;
						ds.Tables.Add(dt);

						conn.Close();
						return ds;
					}
				}
			}
		}

		[WebMethod]
		public static string GetPetitions(int pageIndex, string order) {
			return GetPetitionsData(pageIndex, order).GetXml();
		}
	}
}