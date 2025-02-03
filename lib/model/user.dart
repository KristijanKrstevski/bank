class Users {
  int? id;
  String username;
  String email;
  String firstName;
  String lastName;
  String password;
  String gender;

  Users({
    this.id,
    required this.username,
    required this.email,
    required this.firstName,
    required this.lastName,
    required this.password,
    required this.gender,
  });

  // Convert a User into a Map.
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'username': username,
      'email': email,
      'first_name': firstName,
      'last_name': lastName,
      'password': password,
      'gender': gender,
    };
  }

  // Extract a User object from a Map.
  factory Users.fromMap(Map<String, dynamic> map) {
    return Users(
      id: map['id'],
      username: map['username'],
      email: map['email'],
      firstName: map['first_name'],
      lastName: map['last_name'],
      password: map['password'],
      gender: map['gender'],
    );
  }
}
