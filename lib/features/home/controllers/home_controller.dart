import 'package:get/get.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../shared/config/config.dart';
import 'package:flutter/material.dart'; 
import 'package:manutencar_mobile/features/vehicles/controllers/vehicle_controller.dart';

class HomeController extends GetxController {
  var nomeUsuario = "".obs;
  var isLoading = true.obs;
  var odometer = 0.obs;
  var selectedVehicle = "".obs;
  var vehicles = <Map<String, dynamic>>[].obs;
  var notifications = <String>[].obs;
  var errorMessage = ''.obs; 
  var services = <Map<String, dynamic>>[].obs; 

  final Dio _dio = Dio();
  final VehicleController vehicleController = Get.find<VehicleController>(); // Obtenha uma instância do VehicleController

  @override
  void onInit() {
    super.onInit();
    fetchUserData();
    fetchServices(); 
    fetchVehicles();
  }

  Future<void> fetchVehicles() async {
    isLoading.value = true;
    try {
      vehicles.assignAll(await vehicleController.getVehicles()); // Busque os veículos e atualize a lista
    } catch (e) {
      print("Erro ao buscar veículos: $e");
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> fetchUserData() async {
    try {
      isLoading.value = true;
      errorMessage.value = ''; 

      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('accessToken');

      if (token == null) {
        errorMessage.value = "Usuário não autenticado.";
        Get.snackbar("Erro", errorMessage.value);
        return;
      }

      final response = await _dio.get(
        ApiConfig.userInfo,
        options: Options(headers: {"Authorization": "Bearer $token"}),
      );
      print("Resposta getUserInfo: ${response.statusCode} - ${response.data}");
      
      // Verifica se a resposta foi bem sucedida
      if (response.statusCode == 200) {
        // Armazena o nome do usuário em nomeUsuario
        nomeUsuario.value = response.data["nome"];

        // Armazena os objetos completos dos veículos em vehicles
        vehicles.value = List<Map<String, dynamic>>.from(response.data["vehicles"]);

        // Se houver veículos, seleciona o primeiro e busca o hodômetro
        if (vehicles.isNotEmpty) {

          // Converte o ID do veículo para String
          selectedVehicle.value = vehicles.first['id'].toString();

          // Busca o hodômetro
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
      print("Carregamento concluído");
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
        "${ApiConfig.hodometros}/${selectedVehicle.value}",
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
        "${ApiConfig.hodometros}${selectedVehicle.value}",
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
        {"name": "Óleo", "km": 0, "color": Colors.orange},
        {"name": "Pneus", "km": 0, "color": Colors.green},
        {"name": "Filtros", "km": 0, "color": Colors.red},
        {"name": "Correia", "km": 0, "color": Colors.orange},
      ];
    } catch (e) {
      errorMessage.value = "Não foi possível carregar os serviços: $e";
      Get.snackbar("Erro", errorMessage.value);
    }
  }
}