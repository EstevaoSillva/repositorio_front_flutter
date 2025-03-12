import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:manutencar_mobile/features/vehicles/pages/vehicles_list_page.dart';
import '../controllers/vehicle_controller.dart';

class VehiclePage extends StatelessWidget {
  VehiclePage({super.key});

  final VehicleController controller = Get.put(VehicleController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Meus Veiculos")),
      body: Center(
        child: VehiclesListPage(),
      )
    );
  }
}