import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/vehicle_controller.dart';
import '../widgets/vehicle_list_item.dart';

class VehicleListView extends StatelessWidget {
  const VehicleListView({super.key});

  @override
  Widget build(BuildContext context) {
    final VehicleController controller = Get.find<VehicleController>();

    return Obx(() {
      if (controller.isLoading.value) {
        return const Center(child: CircularProgressIndicator());
      } else if (controller.vehicles.isEmpty) {
        return const Center(child: Text("Nenhum veículo cadastrado."));
      } else {
        return ListView.builder(
          itemCount: controller.vehicles.length,
          itemBuilder: (context, index) {
            return VehicleListItem(vehicle: controller.vehicles[index]);
          },
        );
      }
    });
  }
}