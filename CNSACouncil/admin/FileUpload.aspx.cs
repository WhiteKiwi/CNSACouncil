using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace CNSACouncil.admin {
	public partial class FileUpload : System.Web.UI.Page {
		protected void Page_Load(object sender, EventArgs e) {
			HttpFileCollection uploadedFiles = Request.Files;

			int maxFile = 10;
			if (uploadedFiles.Count > maxFile) {
				Response.Write("한번에 올릴 수 있는 파일수는 " + maxFile.ToString() + "개입니다.");

				return;
			}

			for (int i = 0; i < uploadedFiles.Count; i++) {
				HttpPostedFile userPostedFile = uploadedFiles[i];

				if (userPostedFile.ContentLength > 0 && !String.IsNullOrEmpty(userPostedFile.FileName)) {
					string result = UploadFileSave(userPostedFile, i);
					if (result != "") {
						// 업로드 성공
						Response.Write(result + "<br/>");
					} else {
						// 업로드 실패
					}
				}
			}
		}

		private string UploadFileSave(HttpPostedFile SaveFile, int no) {
			// 저장폴더
			string wPath = Server.MapPath("/files") + "\\";

			// 확장자
			string fileType = SaveFile.FileName.Substring(SaveFile.FileName.LastIndexOf(".") + 1);

			// 저장될 파일 이름
			string saveFileName = DateTime.Now.ToString("yyyyMMddhhmmss") + '_' + no + "." + fileType;

			// 저장하기
			try {
				SaveFile.SaveAs(wPath + "\\" + saveFileName);
			} catch {
				return "";
			}

			return saveFileName;
		}
	}
}