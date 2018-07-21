using System;

namespace CNSACouncil.Models {
	/// <summary>
	/// Model of notices table
	/// </summary>
	public class Notice {
		public int ID { get; set; } // 공지 일련번호

		public string Title { get; set; } // 공지 제목

		public string Content { get; set; } // 공지 내용

		public DateTime NoticeAt { get; set; } // 공지일

		public int Views { get; set; } // 조회수
	}
}