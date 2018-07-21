namespace CNSACouncil.Models {
	/// <summary>
	/// Model of users table
	/// </summary>
	public class User {
		public string ID { get; set; }  // User ID 

		private string password;    // User Password
		public string Password {
			get {
				// password Returns a hash value on request
				return (password + "dbqwud129e12E@#Ttfq3fhu29f@$QGF#ga!E12fbuie1f#@R").GetHashCode().ToString();
			}
			set {
				password = value;
			}
		}

		public string Name { get; set; }    // User Name

		public int Grade { get; set; }  // User Grade
	}
}