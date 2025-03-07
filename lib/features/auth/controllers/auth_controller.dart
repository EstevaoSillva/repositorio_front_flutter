import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../../../shared/config/config.dart';
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

      if (accessToken == null || accessToken.isEmpty) {
        errorMessage.value = "Token de acesso inválido ou expirado";
        return;
      }

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

    Get.offAllNamed('ApiConfig.authLogin');
  }

  void clearErrorMessage() {
    errorMessage.value = ''; // Limpa a mensagem de erro
  }


  // Adicione o método register aqui
  Future<void> register({
    required String username,
    required String email,
    required String password,
    required String confirmacaoSenha
  }) async {
    try {
      isLoading.value = true;
      errorMessage.value = ''; // Limpa mensagens de erro anteriores

      if (username.isEmpty || email.isEmpty || password.isEmpty || confirmacaoSenha.isEmpty) {
        errorMessage.value = "Todos os campos são obrigatórios";
        return;
      }

      if (password != confirmacaoSenha) {
        errorMessage.value = "As senhas não coincidem";
        return;
      }

      final dioInstance = dio.Dio(); // Crie uma instância de Dio
      final data = {
            "username": username,
            "email": email,
            "password": password,
            "confirmacao_senha": confirmacaoSenha, 
        };

        print("Dados da requisição: $data"); // Imprime os dados da requisição

        dio.Response response = await dioInstance.post(
            ApiConfig.register,
            data: data,
            options: dio.Options(headers: {"Content-Type": "application/json"}),
        );

        print("Resposta completa da API: ${response.toString()}"); // Imprime a resposta completa
        print("Resposta da API (status ${response.statusCode}): ${response.data}");

      if (response.statusCode == 201) {
            // Verifica se os tokens estão presentes na resposta
            if (response.data is Map && response.data.containsKey('access') && response.data.containsKey('refresh')) {
                SharedPreferences prefs = await SharedPreferences.getInstance();
                await prefs.setString('accessToken', response.data['access']);
                await prefs.setString('refreshToken', response.data['refresh']);
                print("Registro bem-sucedido. Tokens salvos."); // Log para debug
            } else {
              print('Tokens não recebidos na resposta da API.');
            }
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
