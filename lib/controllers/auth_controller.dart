import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../config.dart';
import '../services/auth_service.dart';
import 'package:dio/dio.dart' as dio;

class AuthController extends GetxController {
  final AuthService _authService = AuthService();
  var isAuthenticated = false.obs;
  var userInfo = {}.obs;
  var isLoading = false.obs;
  var errorMessage = ''.obs; // Adicionado para mensagens de erro

  Future<void> login(String email, String password) async {
    try {
      isLoading.value = true;
      errorMessage.value = ''; // Limpa mensagens de erro anteriores

      bool success = await _authService.login(email, password);

      if (success) {
        isAuthenticated.value = true;
        Get.offAllNamed("/home");
      } else {
        errorMessage.value = "Email ou senha incorretos";
      }
    } catch (e) {
      errorMessage.value = "Ocorreu um erro ao fazer login: $e";
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> getUserInfo() async {
    try {
      isLoading.value = true;
      errorMessage.value = ''; // Limpa mensagens de erro anteriores

      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? accessToken = prefs.getString('accessToken');

      if (accessToken == null) {
        errorMessage.value = "Token de acesso não encontrado";
        return;
      }

      // TODO: Adicionar validação do token aqui (se necessário)

      final response = await http.get(
        Uri.parse(ApiConfig.userInfo),
        headers: {
          "Authorization": "Bearer $accessToken",
        },
      );

      if (response.statusCode == 200) {
        userInfo.value = json.decode(response.body);
      } else {
        errorMessage.value = "Erro ao obter informações do usuário: ${response.statusCode}";
      }
    } catch (e) {
      errorMessage.value = "Erro ao buscar informações do usuário: $e";
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('accessToken');
    await prefs.remove('refreshToken');

    isAuthenticated.value = false;
    userInfo.value = {};

    Get.offAllNamed('/login');
  }

  void clearErrorMessage() {
    errorMessage.value = ''; // Limpa a mensagem de erro
  }


  // Adicione o método register aqui
  Future<void> register({
    required String username,
    required String email,
    required String telefone,
    required String password,
  }) async {
    try {
      isLoading.value = true;
      errorMessage.value = ''; // Limpa mensagens de erro anteriores

      final dio.Dio _dio = dio.Dio(); // Instancia o Dio

      dio.Response response = await _dio.post(
        ApiConfig.register,
        data: {
          "username": username,
          "email": email,
          "telefone": telefone,
          "password": password,
        },
        options: dio.Options(headers: {"Content-Type": "application/json"}),
      );

      print("Resposta da API (status ${response.statusCode}): ${response.data}");

      if (response.statusCode == 201) {
        // Armazena os tokens de acesso e de atualização
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString('accessToken', response.data['access']);
        await prefs.setString('refreshToken', response.data['refresh']);

        // Redireciona para a tela de login
        // Get.offNamed('/login'); // Remova daqui, a tela de registro faz o redirecionamento
      } else {
        errorMessage.value = "Erro ao registrar: ${response.data}";
      }
    } catch (e) {
      errorMessage.value = "Erro ao conectar ao servidor: $e";
    } finally {
      isLoading.value = false;
    }
  }
}
