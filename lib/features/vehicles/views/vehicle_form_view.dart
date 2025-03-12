import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/vehicle_controller.dart';

class VehicleFormView extends StatelessWidget {
  const VehicleFormView({super.key});

  @override
  Widget build(BuildContext context) {
    final VehicleController controller = Get.find<VehicleController>();

    return Scaffold( // Adicione o Scaffold aqui
      appBar: AppBar(title: const Text("Novo Veículo")), 
      body: Form(
        key: controller.formKey,
        child: SingleChildScrollView( // Adicione SingleChildScrollView para permitir rolagem
          child: Padding( // Adicione padding para melhor espaçamento
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                TextFormField(
                  controller: controller.placaController,
                  decoration: const InputDecoration(labelText: "Placa"),
                  validator: (value) => value!.isEmpty ? "Digite a placa" : null,
                ),
                TextFormField(
                  controller: controller.marcaController,
                  decoration: const InputDecoration(labelText: "Marca"),
                  validator: (value) => value!.isEmpty ? "Digite a marca" : null,
                ),
                TextFormField(
                  controller: controller.modeloController,
                  decoration: const InputDecoration(labelText: "Modelo"),
                  validator: (value) => value!.isEmpty ? "Digite o modelo" : null,
                ),
                TextFormField(
                  controller: controller.anoController,
                  decoration: const InputDecoration(labelText: "Ano"),
                  keyboardType: TextInputType.number,
                  validator: (value) => value!.isEmpty ? "Digite o ano" : null,
                ),
                TextFormField(
                  controller: controller.corController,
                  decoration: const InputDecoration(labelText: "Cor"),
                  validator: (value) => value!.isEmpty ? "Digite a cor" : null,
                ),
                const SizedBox(height: 20),
                Obx(() => controller.isLoading.value
                    ? const CircularProgressIndicator()
                    : ElevatedButton(
                        onPressed: controller.salvarVeiculo,
                        child: const Text("Salvar Veículo"),
                      )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}