using MySql.Data.MySqlClient;
using System;
using System.Data;
using System.Web.Services;

namespace CNSACouncil {
	public partial class Petitions : System.Web.UI.Page {
		protected void Page_Load(object sender, EventArgs e) {
			if (!IsPostBack) {
				repeater.DataSource = GetPetitionsData(1);
				repeater.DataBind();
			}
		}

		public static DataSet GetPetitionsData(int page) {
			var ds = new DataSet();

			using (var conn = new MySqlConnection(System.Configuration.ConfigurationManager.ConnectionStrings["COUNCILDB"].ConnectionString)) {
				conn.Open();
				// TODO: State에 따라 변경
				string sql = "SELECT * FROM petitions ORDER BY ID DESC LIMIT 10 OFFSET " + ((page - 1) * 10) + ";";
				MySqlDataAdapter adapter = new MySqlDataAdapter {
					SelectCommand = new MySqlCommand(sql, conn)
				};
				adapter.Fill(ds);

				conn.Close();
			}

			return ds;
		}

		private static DataSet GetData(MySqlCommand cmd) {
			using (var conn = new MySqlConnection(System.Configuration.ConfigurationManager.ConnectionStrings["COUNCILDB"].ConnectionString)) {
				conn.Open();

				using (MySqlDataAdapter msda = new MySqlDataAdapter()) {
					cmd.Connection = conn;
					msda.SelectCommand = cmd;
					using(DataSet ds = new DataSet()) {
						msda.Fill(ds, "petitions");
						DataTable dt = new DataTable("petitions");
						dt.Columns.Add("ID");
						dt.Rows.Add();
						dt.Rows[0][0] = cmd.Parameters["@PageCount"].Value;
						ds.Tables.Add(dt);

						conn.Close();
						return ds;
					}
				}
			}
		}

		[WebMethod]
		public static string GetPetitions(int pageIndex) {
			return GetPetitionsData(pageIndex).GetXml();
		}
	}
}