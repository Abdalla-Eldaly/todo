class User {
  static String CollectionName = 'colection';
  String? id;
  String? Fullnamed;
  String? Username;
  String? email;
  User({this.email, this.id, this.Fullnamed, this.Username});

  User.fromfirestore(Map<String, dynamic>? data) {
    id = data?[id];
    Fullnamed = data?[Fullnamed];
    Username = data?[Username];
    email = data?[email];
  }

  Map<String, dynamic> tofirestore() {
    return {
      "id": id,
      "Fullnamed": Fullnamed,
      "Username": Username,
      "email": email,
    };
  }
}
