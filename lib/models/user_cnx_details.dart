class UserDetails {
  final String? id;

  final String? username;

  final List<String> roles;

  final String email;

  final List<String> typeCompte;

  final Profile profile;

  final DateTime createdAt;

  final bool isDeleted;

  final bool status;

  UserDetails({
    required this.id,
    this.username,
    required this.roles,
    required this.email,
    required this.typeCompte,
    required this.profile,
    required this.createdAt,
    required this.isDeleted,
    required this.status,
  });

  factory UserDetails.fromJson(Map<String, dynamic> json) {
    return UserDetails(
      id: json['id'],
      username: json['username'],
      roles: List<String>.from(json['roles']),
      email: json['email'],
      typeCompte: List<String>.from(json['typeCompte']),
      profile: Profile.fromJson(json['profil']),
      createdAt: DateTime.parse(json['created_at']),
      isDeleted: json['isDeleted'],
      status: json['status'],
    );
  }

  UserDetails copyWith({
    String? id,
    String? username,
    List<String>? roles,
    String? email,
    List<String>? typeCompte,
    Profile? profile,
    DateTime? createdAt,
    bool? isDeleted,
    bool? status,
  }) {
    return UserDetails(
      id: id ?? this.id,
      username: username ?? this.username,
      roles: roles ?? this.roles,
      email: email ?? this.email,
      typeCompte: typeCompte ?? this.typeCompte,
      profile: profile ?? this.profile,
      createdAt: createdAt ?? this.createdAt,
      isDeleted: isDeleted ?? this.isDeleted,
      status: status ?? this.status,
    );
  }
}

class Profile {
  final int id;

  final String nom;

  final String prenom;

  final String telephone;

  final String addresse;

  final DateTime createdAt;

  final String? logo;

  final bool isCompleted;

  Profile({
    required this.id,
    required this.nom,
    required this.prenom,
    required this.telephone,
    required this.addresse,
    required this.createdAt,
    this.logo,
    required this.isCompleted,
  });

  factory Profile.fromJson(Map<String, dynamic> json) {
    return Profile(
      id: json['id'],
      nom: json['nom'],
      prenom: json['prenom'],
      telephone: json['telephone'],
      addresse: json['addresse'],
      createdAt: DateTime.parse(json['created_at']),
      logo: json['logo'],
      isCompleted: json['is_completed'],
    );
  }
}
