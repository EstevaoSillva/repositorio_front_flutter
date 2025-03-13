import 'package:get/get.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter/material.dart';
import 'package:manutencar_mobile/shared/config/config.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsController extends GetxController {
  // Variáveis observáveis (se precisar)
  var isLoading = false.obs;
  var errorMessage = ''.obs;

  // Métodos

  // Exemplo: Método para lidar com o logout
  Future<void> handleLogout() async {
    try {
      isLoading.value = true;
      // Limpar dados do usuário (exemplo: token, etc.)
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.remove('accessToken'); // Substitua pela sua chave de token
      // Exibir Toast
      showToast("Logout realizado");
      // Redirecionar para a tela de login
      Get.offAllNamed(ApiConfig.authLogin); // Use suas rotas GetX
    } catch (e) {
      errorMessage.value = "Erro ao fazer logout: $e";
      Get.snackbar("Erro", errorMessage.value);
    } finally {
      isLoading.value = false;
    }
  }

  // Método para exibir Toast
  void showToast(String message) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.grey[800],
      textColor: Colors.white,
      fontSize: 16.0,
    );
  }
}