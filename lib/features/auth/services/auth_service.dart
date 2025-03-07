import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../../../shared/config/config.dart';

class AuthService {
  Future<bool> login(String email, String password) async {
    try {
      final response = await http.post(
        Uri.parse(ApiConfig.authLogin),
        body: json.encode({"email": email, "password": password}),
        headers: {
          "Content-Type": "application/json",
          "Accept": "application/json",
        },
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString('accessToken', data['access']);
        print("Token salvo: ${data['access']}");
        return true;
      } else if (response.statusCode == 401) {
          print("Credenciais inválidas");
          return false;
      } else {
          print("Erro ao fazer o login, código do erro: ${response.statusCode}");
          return false;
      }
    } catch (e) {
      print("Erro ao fazer login: $e");
      return false;
    }
  }

  Future<void> logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('accessToken');
  }
}