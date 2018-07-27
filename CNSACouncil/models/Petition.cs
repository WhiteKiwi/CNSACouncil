using System;

namespace CNSACouncil.Models {
	/// <summary>
	/// Model of petitions table
	/// </summary>
	public class Petition {
		public int ID { get; set; } // 청원 일련번호

		public string UserID { get; set; } // 청원자 CNSAnet ID

		public string Title { get; set; } // 청원 제목

		public string Content { get; set; } // 청원 내용

		public string IP { get; set; } // 청원자 IP

		public DateTime PetitionAt { get; set; } // 청원 시각

		public int State { get; set; } // 청원 상태 - 0: 미승인, 1: 승인, 2: 답변됨
	}
}
