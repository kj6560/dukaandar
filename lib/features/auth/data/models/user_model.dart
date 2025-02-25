class User {
  int id;
  String name;
  String email;
  dynamic emailVerifiedAt;
  String number;
  int? orgId;
  String? createdAt;
  String? updatedAt;

  User({
    required this.id,
    required this.name,
    required this.email,
    required this.emailVerifiedAt,
    required this.number,
    this.orgId,
    this.createdAt,
    this.updatedAt,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      emailVerifiedAt: json['emailVerifiedAt'],
      number: json['number'],
      orgId: json['orgId'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'emailVerifiedAt': emailVerifiedAt,
      'number': number,
      'orgId': orgId,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }
}
