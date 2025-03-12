import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../../../shared/config/config.dart'; // Importe suas configurações de API

class HodometroController extends GetxController {
  final formKey = GlobalKey<FormState>();
  final hodometroController = TextEditingController();
  var isLoading = false.obs;

  Future<void> salvarHodometro(int vehicleId) async {
    if (!formKey.currentState!.validate()) return;

    isLoading.value = true;

    final url = Uri.parse('${ApiConfig.baseUrl}/vehicles/$vehicleId/hodometro/'); // Ajuste a URL
    final response = await http.post(
      url,
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        "hodometro": int.parse(hodometroController.text),
        "veiculo": vehicleId, // Envie o ID do veículo
      }),
    );

    isLoading.value = false;

    if (response.statusCode == 201) {
      Get.snackbar("Sucesso", "Hodômetro cadastrado com sucesso!", backgroundColor: Colors.green);
      Get.back();
    } else {
      Get.snackbar("Erro", "Erro ao cadastrar hodômetro", backgroundColor: Colors.red);
    }
  }

  @override
  void onClose() {
    hodometroController.dispose();
    super.onClose();
  }
}