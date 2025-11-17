class User {
  final int id;
  final String firstName;
  final String lastName;
  final String email;
  final String phone;
  final int age;
  final String gender;
  final String birthDate;
  final String image;
  final String city;
  final String address;
  final String companyName;

  User({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.phone,
    required this.age,
    required this.gender,
    required this.birthDate,
    required this.image,
    required this.city,
    required this.address,
    required this.companyName,
  });

  String get fullName => '$firstName $lastName';

  factory User.fromJson(Map<String, dynamic> json) {
    final addressJson = json['address'] ?? {};
    final companyJson = json['company'] ?? {};

    return User(
      id: json['id'] ?? 0,
      firstName: json['firstName'] ?? '',
      lastName: json['lastName'] ?? '',
      email: json['email'] ?? '',
      phone: json['phone'] ?? '',
      age: json['age'] ?? 0,
      gender: json['gender'] ?? '',
      birthDate: json['birthDate'] ?? '',
      image: json['image'] ?? '',
      city: addressJson['city'] ?? '',
      address: addressJson['address'] ?? '',
      companyName: companyJson['name'] ?? '',
    );
  }
}
