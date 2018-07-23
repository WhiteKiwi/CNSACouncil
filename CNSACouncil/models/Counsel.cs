namespace CNSACouncil.Models {
	/// <summary>
	/// Model of agrees table
	/// </summary>
	public class Counsel {
		public int ID { get; set; } // 상담 일련번호

		public string OfficerID { get; set; } // 학생회 임원 아이디

		public string Date { get; set; } // 원하는 상담 시간

		public string Content { get; set; } // 상담 내용

		public int State { get; set; } // 청원 상태 - 0: 등록됨, 1: 승인, 2: 거절

		public string Code { get; set; } // 사용자 식별 번호

		public string Reason { get; set; } // 반려 사유 - 반려 시
	}
}
