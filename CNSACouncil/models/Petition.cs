﻿using System;

namespace CNSACouncil.Models {
	/// <summary>
	/// Model of petitions table
	/// </summary>
	public class Petition {
		public int ID { get; set; } // 청원 일련번호

		public string Title { get; set; } // 청원 제목

		public string Content { get; set; } // 청원 내용

		public string IP { get; set; } // 청원자 IP

		public DateTime PetitionAt { get; set; } // 청원 시각

		public int Views { get; set; }  // 조회수
	}
}