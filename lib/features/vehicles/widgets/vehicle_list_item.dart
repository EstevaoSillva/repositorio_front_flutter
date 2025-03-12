import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/vehicle_controller.dart';

class VehicleListItem extends StatelessWidget {
  final Map<String, dynamic> vehicle;

  const VehicleListItem({super.key, required this.vehicle});

  @override
  Widget build(BuildContext context) {
    final VehicleController controller = Get.find<VehicleController>();

    return Card(
      elevation: 3,
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: ListTile(
        leading: const Icon(Icons.directions_car, color: Colors.blue),
        title: Text("${vehicle['marca']} ${vehicle['modelo']}"),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("${vehicle['placa']} • ${vehicle['ano']} • Cor: ${vehicle['cor']}", style: TextStyle(fontSize: 12, color: Colors.grey.shade600)),
          ],
        ),
        trailing: IconButton(
          icon: const Icon(Icons.delete, color: Colors.red),
          onPressed: () => controller.deleteVehicle(vehicle['id']),
        ),
      ),
    );
  }
}