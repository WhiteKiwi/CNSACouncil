﻿using System;

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

		public DateTime EndAt { get; set; } // 청원 마감일

		public int State { get; set; } // 청원 상태 - 0: 미승인, 1: 승인, 2: 답변됨, -1: 지연됨

		public string Answer { get; set; } // 청원 답변 - DB에서는 정규화되어 있음

		public int Agrees { get; set; } // 동의 수
	}
}
