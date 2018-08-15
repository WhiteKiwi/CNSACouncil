using System;
using System.Net;
using System.Text;

namespace CNSACouncil {
	public partial class Login : System.Web.UI.Page {
		protected void Page_Load(object sender, EventArgs e) {

		}
		protected void LoginButton_Click(object sender, EventArgs e) {
			if (string.IsNullOrEmpty(UserID.Text.Trim())) // ID가 비어있을 경우
				Response.Write("<script>alert('ID를 입력해주세요.');</script>");
			else if (string.IsNullOrEmpty(UserPW.Text.Trim())) // PW가 비어있을 경우
				Response.Write("<script>alert('PW를 입력해주세요.');</script>");
			else {
				string responseData = Encoding.UTF8.GetString(new LoginWebClient().UploadValues("https://student.cnsa.hs.kr/login/userLogin", new System.Collections.Specialized.NameValueCollection() {
					{ "loginId", UserID.Text },
					{ "loginPw", UserPW.Text }
				}));

				// requestData에 특정 문자열이 포함되어 있지 않을 경우 로그인 성공으로 간주
				if (!responseData.Contains("/login/userLogin")) {
					// 로그인 성공 시 세션 저장
					Session["UserID"] = UserID.Text;

					if (Request.QueryString["classification"] != null) {
						int classification = int.Parse(Request.QueryString["classification"]);
						if (classification == 0) {
							// 0이면 공지
							Response.Redirect("/Notice.aspx?id=" + Request.QueryString["id"]);
						} else if (classification == 1) {
							// 1이면 청원
							if (Request.QueryString["id"] != null) {
								// id가 존재하면 청원으로 이동
								Response.Redirect("/Petition.aspx?order=" + Request.QueryString["order"] + "&id=" + Request.QueryString["id"]);
							} else {
								// id가 존재하지 않으면 청원 등록으로 이동
								Response.Redirect("/UploadPetition.aspx");
							}
						} else if (classification == 2) {
							// 2이면 사업
							Response.Redirect("/Project.aspx?id=" + Request.QueryString["id"] + "&state=" + Request.QueryString["state"]);
						}
					} else {
						// 메인 화면으로 Redirect
						Response.Redirect("/");
					}
				} else {
					// 로그인 실패
					Response.Write("<script>alert('로그인에 실패하였습니다.');</script>");
				}
			}
		}
	}

	public class LoginWebClient : WebClient {
		public CookieContainer CookieContainer {
			get; set;
		}

		public LoginWebClient() {
			CookieContainer = new CookieContainer();
		}

		protected override WebRequest GetWebRequest(Uri address) {
			//WebRequest 생성
			WebRequest request = base.GetWebRequest(address);

			//패킷 속성 설정
			if (request is HttpWebRequest) {
				//패킷 Cookie 쿠키 설정
				(request as HttpWebRequest).CookieContainer = this.CookieContainer;
				//Connect: Kepp-Alive 
				(request as HttpWebRequest).KeepAlive = true;
			}

			//HttpWebRequest.AutomaticDecompression 속성 설정 
			HttpWebRequest httpRequest = (HttpWebRequest)request;
			httpRequest.AutomaticDecompression = DecompressionMethods.GZip | DecompressionMethods.Deflate;

			//https 인증서 설정
			httpRequest.ServerCertificateValidationCallback += (sender, certificate, chain, sslPolicyErrors) => true;

			return httpRequest;
		}
	}
}