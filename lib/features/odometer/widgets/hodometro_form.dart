import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/hodometro_controller.dart';

class HodometroForm extends StatelessWidget {
  final HodometroController controller = Get.find<HodometroController>();
  final int vehicleId; // Adicione o vehicleId como parâmetro

  HodometroForm({required this.vehicleId, super.key}); // Adicione o vehicleId ao construtor

  @override
  Widget build(BuildContext context) {
    return Form(
      key: controller.formKey,
      child: Column(
        children: [
          TextFormField(
            controller: controller.hodometroController,
            decoration: InputDecoration(labelText: "Hodômetro"),
            keyboardType: TextInputType.number,
            validator: (value) => value!.isEmpty ? "Digite o hodômetro" : null,
          ),
          SizedBox(height: 20),
          Obx(() => controller.isLoading.value
              ? CircularProgressIndicator()
              : ElevatedButton(
                  onPressed: () async {
                    await controller.salvarHodometro(vehicleId); // Chama o método com o vehicleId
                  },
                  child: Text("Salvar Hodômetro"),
                )),
        ],
      ),
    );
  }
}