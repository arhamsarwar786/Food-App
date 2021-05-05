import 'dart:convert' as convert;
import 'model.dart';
import 'package:http/http.dart' as http;
import 'dart:core';

class FormController {
  // Callback function to give response of status of current request.
  final void Function(String) callback;

  // Google App Script Web URL
  static const String URL =
      "https://script.google.com/macros/s/AKfycbwXv10BiVAD-G6qpiyZi4hZj8uXuMZ0XhPVOWXAH4xG1UJkAF4f_1ynk98-zoGOVjmR/exec";

  static const STATUS_SUCCESS = "SUCCESS";

  FormController(this.callback);

  void submitForm(FeedbackForm feedbackForm) async {
    var url = Uri.https(
        "script.google.com",
        "/macros/s/AKfycbwXv10BiVAD-G6qpiyZi4hZj8uXuMZ0XhPVOWXAH4xG1UJkAF4f_1ynk98-zoGOVjmR/exec",
        feedbackForm.toMap());
    try {
      await http.get(url).then((response) {
        callback(convert.jsonDecode(response.body)['status']);
      });
    } catch (e) {
      print(e);
    }
  }
}
// Encode::::
// throw

// Url
// --- Get method
// --- Post method
// 
