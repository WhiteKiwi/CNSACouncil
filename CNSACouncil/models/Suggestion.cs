using System;

namespace CNSACouncil.Models {
	/// <summary>
	/// Model of suggestions table
	/// </summary>
	public class Suggestion {
		public int ID { get; set; } // 건의 일련번호

		public string Content { get; set; } // 건의 내용

		public string IP { get; set; } // 건의자 IP

		public DateTime SuggestAt { get; set; } // 건의 시각
		
		public int State { get; set; } // 건의 상태 - 0: 안읽음, 1: 읽음
	}
}