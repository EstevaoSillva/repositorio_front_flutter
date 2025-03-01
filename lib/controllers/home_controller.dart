import 'package:get/get.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../config.dart';
import 'package:flutter/material.dart'; // Importe o Material para cores

class HomeController extends GetxController {
  var nomeUsuario = "".obs;
  var isLoading = true.obs;
  var odometer = 0.obs;
  var selectedVehicle = "".obs;
  var vehicles = <String>[].obs;
  var notifications = <String>[].obs;
  var errorMessage = ''.obs; // Adicionado para mensagens de erro
  var services = <Map<String, dynamic>>[].obs; // Adicionado para dados de serviços

  final Dio _dio = Dio();

  @override
  void onInit() {
    super.onInit();
    fetchUserData();
    fetchServices(); // Busca os serviços ao inicializar
  }

  Future<void> fetchUserData() async {
    try {
      isLoading.value = true;
      errorMessage.value = ''; // Limpa mensagens de erro anteriores

      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('accessToken');

      if (token == null) {
        errorMessage.value = "Usuário não autenticado.";
        Get.snackbar("Erro", errorMessage.value);
        return;
      }

      final response = await _dio.get(
        "${ApiConfig.baseUrl}/userInfo",
        options: Options(headers: {"Authorization": "Bearer $token"}),
      );
      print("Resposta getUserInfo: ${response.statusCode} - ${response.data}");
      if (response.statusCode == 200) {
        nomeUsuario.value = response.data["Nome"];
        vehicles.value = List<String>.from(response.data["vehicles"]);
        if (vehicles.isNotEmpty) {
          selectedVehicle.value = vehicles.first;
          fetchOdometer();
        }
      } else {
        errorMessage.value = "Não foi possível carregar os dados.";
        Get.snackbar("Erro", errorMessage.value);
      }
    } catch (e) {
      errorMessage.value = "Não foi possível carregar os dados: $e";
      Get.snackbar("Erro", errorMessage.value);
      print("Erro getUserInfo: $e");
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> fetchOdometer() async {
    if (selectedVehicle.value.isEmpty) return;

    try {
      errorMessage.value = ''; // Limpa mensagens de erro anteriores

      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('accessToken');

      if (token == null) {
        errorMessage.value = "Usuário não autenticado.";
        Get.snackbar("Erro", errorMessage.value);
        return;
      }

      final response = await _dio.get(
        "${ApiConfig.baseUrl}/odometer/${selectedVehicle.value}",
        options: Options(headers: {"Authorization": "Bearer $token"}),
      );

      if (response.statusCode == 200) {
        odometer.value = response.data["odometer"];
      } else {
        errorMessage.value = "Não foi possível carregar o hodômetro.";
        Get.snackbar("Erro", errorMessage.value);
      }
    } catch (e) {
      errorMessage.value = "Não foi possível carregar o hodômetro: $e";
      Get.snackbar("Erro", errorMessage.value);
    }
  }

  Future<void> updateOdometer(int newOdometer) async {
    if (selectedVehicle.value.isEmpty) return;

    try {
      errorMessage.value = ''; // Limpa mensagens de erro anteriores

      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('accessToken');

      if (token == null) {
        errorMessage.value = "Usuário não autenticado.";
        Get.snackbar("Erro", errorMessage.value);
        return;
      }

      final response = await _dio.put(
        "${ApiConfig.baseUrl}/odometer/${selectedVehicle.value}",
        data: {"odometer": newOdometer},
        options: Options(headers: {"Authorization": "Bearer $token", "Content-Type": "application/json"}),
      );

      if (response.statusCode == 200) {
        odometer.value = newOdometer;
        Get.snackbar("Sucesso", "Hodômetro atualizado!");
      } else {
        errorMessage.value = "Não foi possível atualizar o hodômetro.";
        Get.snackbar("Erro", errorMessage.value);
      }
    } catch (e) {
      errorMessage.value = "Não foi possível atualizar o hodômetro: $e";
      Get.snackbar("Erro", errorMessage.value);
    }
  }

  // Adicionado método para buscar serviços
  Future<void> fetchServices() async {
    try {
      services.value = [
        {"name": "Óleo", "km": 52555, "color": Colors.orange},
        {"name": "Pneus", "km": 60000, "color": Colors.green},
        {"name": "Filtros", "km": 50000, "color": Colors.red},
        {"name": "Correia", "km": 50000, "color": Colors.orange},
      ];
    } catch (e) {
      errorMessage.value = "Não foi possível carregar os serviços: $e";
      Get.snackbar("Erro", errorMessage.value);
    }
  }
}