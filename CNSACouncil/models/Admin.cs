namespace CNSACouncil.Models {
	/// <summary>
	/// Model of admins table
	/// </summary>
	public class Admin {
		public string ID { get; set; } // 관리자 ID

		public string Password { get; set; } // 비밀번호

		public string Name { get; set; } // 이름 - 직책
	}
}
