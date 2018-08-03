using System;

namespace CNSACouncil.Models {
	/// <summary>
	/// Model of projects table
	/// </summary>
	public class Project {
		public int ID { get; set; } // 사업 일련번호

		public string Title { get; set; } // 사업 제목

		public string Content { get; set; } // 사업 내용

		public DateTime StartAt { get; set; } // 시작일

		public DateTime EndAt { get; set; } // 종료일

		public string FileName { get; set; } // 대표 사진 이름

		public int State { get; set; } // 사업 상태 - 0: 진행중, 1: 완료
	}
}