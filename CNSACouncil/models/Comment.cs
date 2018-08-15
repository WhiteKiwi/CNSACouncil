using System;

namespace CNSACouncil.Models {
	/// <summary>
	/// Model of comments table
	/// </summary>
	public class Comment {
		public int PostID { get; set; } // 댓글의 글 번호

		public string Content { get; set; } // 댓글 내용

		public string WriterID { get; set; } // 작성자 ID

		public DateTime CommentAt { get; set; } // 댓글 작성 시간

		public int Classification { get; set; } // 0: 공지, 1: 청원, 2: 사업
	}
}