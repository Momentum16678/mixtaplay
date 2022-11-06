import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiCalls {
  Future signUp(String email, String username, String password,
      String passwordConfirm) async {
    try {
      final url = Uri.parse(
          "https://mixtaplay.herokuapp.com/users/signup");
      final response = await http.post(url,
          headers: {'Content-Type': 'application/json'},
          body: json.encode({
            "email": email,
            "userName": username,
            "password": password,
            "passwordConfirm": passwordConfirm
          }));
      if (response.statusCode == 200) {
        var data = jsonDecode(response.body.toString());
        print(data['token']);
      } else {
        print('failed');
      }
    } catch (e) {
      print(e.toString());
    }
  }

}
