class Customer {
  int? id;
  String name;
  String email;
  String phone;
  String address;
  String password;
  DateTime dob;

  Customer(
      {required this.id,
      required this.name,
      required this.email,
      required this.phone,
      required this.address,
      required this.password,
      required this.dob});

  Customer.empty()
      : name = "",
        email = "",
        phone = "",
        address = "",
        password = "",
        dob = DateTime.now();

  factory Customer.fromJson(Map<String, dynamic> json) {
    return Customer(
        id: json['id'],
        name: json["name"],
        email: json["email"],
        phone: json["phone"],
        address: json["address"],
        password: json["password"] ?? "",
        dob: DateTime.parse(json["dob"]));
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "name": name,
      "email": email,
      "password": password,
      "phone": phone,
      "address": address,
      "dob": dob.toString().split(" ")[0]
    };
  }

  @override
  String toString() {
    return "name = $name\n"
        "email = $email\n"
        "email = $email\n"
        "phone = $phone\n"
        "address = $address\n"
        "dob = $dob\n"
        "password = $password\n";
  }
}
