class UserModel {
  final String uid;
  final String firstName;
  final String lastName;
  final String email;
  final String password;
  final String? dateOfBirth;
  final String? weight;
  final String? height;
  final int? avgCycle;
  final String? startDate;
  final String? endDate;

  UserModel(
      {required this.uid,
      required this.firstName,
      required this.lastName,
      required this.email,
      required this.password,
      this.dateOfBirth,
      this.weight,
      this.height,
      this.avgCycle,
      this.startDate,
      this.endDate});

  toJson() {
    return {
      "FirstName": firstName,
      "LastName": lastName,
      "Email": email,
      "Password": password,
      "DateOfBirth": dateOfBirth,
      "Weight": weight,
      "Height": height,
      "AvgCycle": avgCycle,
      "StartDate": startDate,
      "EndDate": endDate,
    };
  }
}
