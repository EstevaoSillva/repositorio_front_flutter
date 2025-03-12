import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/hodometro_controller.dart';
import '../widgets/hodometro_form.dart';

class HodometroPage extends StatelessWidget {
  final int vehicleId;

  HodometroPage({required this.vehicleId, super.key});

  final HodometroController controller = Get.put(HodometroController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Novo Hodômetro")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: HodometroForm(vehicleId: vehicleId),
      ),
    );
  }
}