namespace CNSACouncil.Models {
	/// <summary>
	/// Model of agrees table
	/// </summary>
	public class Agree {
		public int PetitionID { get; set; } // 청원 ID

		public string UserID { get; set; } // 찬성자 ID
	}
}