class FeedbackForm {
  String name;
  String email;
  String phoneNumber;
  String address;
  String orderNumber;
  String dateTime;
  String namesAll;
  String priceAll;
  String quantityAll;
  String finalTotal;

  FeedbackForm(
      this.name,
      this.email,
      this.phoneNumber,
      this.address,
      this.orderNumber,
      this.dateTime,
      this.namesAll,
      this.priceAll,
      this.quantityAll,
      this.finalTotal);

  // Method to make GET parameters.
  //
  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    
    map['name'] = name;
    map['email'] = email;
    map['phoneNumber'] = phoneNumber;
    map['address'] = address;
    map['orderNumber'] = orderNumber;
    map['dateTime'] = dateTime;
    map['namesAll'] = namesAll;
    map['priceAll'] = priceAll;
    map['quantityAll'] = quantityAll;
    map['finalTotal'] = finalTotal;
    return map;
  }
  String toParams() =>
      "?name=$name&email=$email&phoneNumber=$phoneNumber&address=$address&orderNumber=$orderNumber&dateTime=$dateTime&namesAll=$namesAll&priceAll=$priceAll&quantityAll=$quantityAll&finalTotal=$finalTotal";
}
