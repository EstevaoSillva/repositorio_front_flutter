import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../shared/config/config.dart';

class VehicleController extends GetxController {
  final formKey = GlobalKey<FormState>();
  final marcaController = TextEditingController();
  final modeloController = TextEditingController();
  final anoController = TextEditingController();
  final corController = TextEditingController();
  final placaController = TextEditingController();

  var isLoading = false.obs;
  var vehicles = <Map<String, dynamic>>[].obs;
  var userId = 0.obs;

  @override
  void onInit() {
    super.onInit();
    fetchUserId();
    fetchVehicles();
  }

  /// Obtém o ID do usuário autenticado e armazena no SharedPreferences
  Future<void> fetchUserId() async {
    final dio = Dio();
    final url = ApiConfig.userInfo; // Endpoint correto para buscar as informações do usuário

    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('accessToken');

      if (token == null) {
        Get.snackbar("Erro", "Usuário não autenticado.", backgroundColor: Colors.red);
        return;
      }

      final response = await dio.get(
        url,
        options: Options(
          headers: {
            "Authorization": "Bearer $token",
          },
        ),
      );

      if (response.statusCode == 200) {
        final userData = response.data;
        await prefs.setInt('userId', userData['id']); // Salvar o ID corretamente
        userId.value = userData['id']; // Atualizar variável observável
      }
    } catch (e) {
      print("Erro ao buscar dados do usuário: $e");
    }
  }

  Future<void> fetchVehicles() async {
    isLoading.value = true;
    final dio = Dio();
    final url = ApiConfig.veiculos;

    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('accessToken');

      if (token == null) {
        isLoading.value = false;
        Get.snackbar("Erro", "Usuário não autenticado.", backgroundColor: Colors.red);
        return;
      }

      final response = await dio.get(
        url,
        options: Options(
          headers: {
            "Authorization": "Bearer $token",
          },
        ),
      );

      if (response.statusCode == 200) {
        vehicles.assignAll(List<Map<String, dynamic>>.from(response.data));
      } else {
        Get.snackbar("Erro", "Erro ao carregar veículos", backgroundColor: Colors.red);
      }
    } catch (e) {
      isLoading.value = false;
      Get.snackbar("Erro", "Erro ao carregar veículos: $e", backgroundColor: Colors.red);
      print("Erro ao carregar veículos: $e");
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> salvarVeiculo() async {
    if (!formKey.currentState!.validate()) return;

    isLoading.value = true;

    final dio = Dio();
    final url = ApiConfig.veiculos;

    try {
      // Recuperar o ID do usuário das preferências compartilhadas
      SharedPreferences prefs = await SharedPreferences.getInstance();
      int? userId = prefs.getInt('userId'); // Substitua 'userId' pela chave correta
      print("ID do usuário salvo: ${prefs.getInt('userId')}");

      if (userId == null) {
        isLoading.value = false;
        Get.snackbar("Erro", "ID do usuário não encontrado.", backgroundColor: Colors.red);
        return;
      }

      // Adicionar o ID do usuário aos dados do veículo
      final data = {
        "usuario": userId.toString(), // Converter o ID para String
        "marca": marcaController.text,
        "modelo": modeloController.text,
        "ano": anoController.text,
        "cor": corController.text,
        "placa": placaController.text,
      };

      String? token = prefs.getString('accessToken');

      if (token == null) {
        isLoading.value = false;
        Get.snackbar("Erro", "Usuário não autenticado.", backgroundColor: Colors.red);
        return;
      }

      final response = await dio.post(
        url,
        data: data,
        options: Options(
          headers: {
            "Content-Type": "application/json",
            "Authorization": "Bearer $token",
          },
        ),
      );

      isLoading.value = false;

      if (response.statusCode == 201 || response.statusCode == 200) {
        Get.snackbar("Sucesso", "Veículo cadastrado com sucesso!", backgroundColor: Colors.green);
        Get.back();
        fetchVehicles();
      } else {
        Get.snackbar("Erro", "Erro ao salvar veículo", backgroundColor: Colors.red);
      }
    } catch (e) {
      isLoading.value = false;
      Get.snackbar("Erro", "Erro ao salvar veículo: $e", backgroundColor: Colors.red);
      print("Erro ao salvar veículo: $e");
    }
  }

  Future<void> deleteVehicle(int id) async {
    isLoading.value = true;
    final dio = Dio();
    final url = '${ApiConfig.veiculos}$id/';

    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('accessToken');

      if (token == null) {
        isLoading.value = false;
        Get.snackbar("Erro", "Usuário não autenticado.", backgroundColor: Colors.red);
        return;
      }

      final response = await dio.delete(
        url,
        options: Options(
          headers: {
            "Authorization": "Bearer $token",
          },
        ),
      );

      isLoading.value = false;

      if (response.statusCode == 204) {
        Get.snackbar("Sucesso", "Veículo deletado com sucesso!", backgroundColor: Colors.green);
        fetchVehicles();
      } else {
        Get.snackbar("Erro", "Erro ao deletar veículo", backgroundColor: Colors.red);
      }
    } catch (e) {
      isLoading.value = false;
      Get.snackbar("Erro", "Erro ao deletar veículo: $e", backgroundColor: Colors.red);
      print("Erro ao deletar veículo: $e");
    }
  }

  @override
  void onClose() {
    marcaController.dispose();
    modeloController.dispose();
    anoController.dispose();
    corController.dispose();
    placaController.dispose();
    super.onClose();
  }

  Future<List<Map<String, dynamic>>> getVehicles() async {
    try {
      final response = await Dio().get(ApiConfig.veiculos);
      final List<dynamic> data = response.data;

      final List<Map<String, dynamic>> vehicles = data.map((vehicle) => {
        'id': vehicle['id'],
        'placa': vehicle['placa'],
      }).toList();

      return vehicles;
    } catch (e) {
      print("Erro ao buscar veículos: $e");
      rethrow;
    }
  }
}