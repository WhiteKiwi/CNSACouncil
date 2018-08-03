using System.Web;

namespace CNSACouncil.admin {
	/// <summary>
	/// Upload의 요약 설명입니다.
	/// </summary>
	public class Upload : IHttpHandler {

		public void ProcessRequest(HttpContext context) {
			HttpPostedFile uploads = context.Request.Files["upload"];

			string CKEditorFuncNum = context.Request["CKEditorFuncNum"];

			string file = System.IO.Path.GetFileName(uploads.FileName);

			uploads.SaveAs(context.Server.MapPath("/assets/images/") + file);

			string url = "/assets/images/" + file;

			context.Response.Write(string.Format("<script>window.parent.CKEDITOR.tools.callFunction('{0}', '{1}', '')</script>", CKEditorFuncNum, url));

			context.Response.End();
		}

		public bool IsReusable {
			get {
				return false;
			}
		}
	}
}