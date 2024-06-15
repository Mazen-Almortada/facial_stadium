// ignore_for_file: public_member_api_docs, sort_constructors_first

class UserModel {
  String? firstName;
  String? lastName;
  String? email;
  String? address1;
  String? address2;
  String? password;
  String? imageUrl;
  String? phoneNumber;
  UserModel({
    this.firstName,
    this.lastName,
    this.email,
    this.imageUrl,
    this.address1,
    this.address2,
    this.password,
    this.phoneNumber,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'firstName': firstName,
      'lastName': lastName,
      'email': email,
      'address1': address1,
      'address2': address2,
      'password': password,
      'imageUrl': imageUrl,
      'phoneNumber': phoneNumber
    };
  }

  factory UserModel.fromMap(dynamic map) {
    return UserModel(
      firstName: map['firstName'] as String?,
      lastName: map['lastName'] as String?,
      email: map['email'] as String?,
      address1: map['address1'] as String?,
      address2: map['address2'] as String?,
      password: map['password'] as String?,
      imageUrl: map['imageUrl'] as String?,
      phoneNumber: map['phoneNumber'] as String?,
    );
  }
}
