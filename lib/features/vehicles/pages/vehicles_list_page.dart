import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:manutencar_mobile/features/vehicles/views/vehicle_form_view.dart';
import '../controllers/vehicle_controller.dart';
import '../views/vehicle_list_view.dart';
// import '../../reports/pages/reports_page.dart';
// import '../../vehicles/maintenance/pages/services_page.dart';
// import '../../fuel/pages/fuel_page.dart';

class VehiclesListPage extends StatelessWidget {
  VehiclesListPage({super.key});

  final VehicleController controller = Get.put(VehicleController());

   @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: VehicleListView(), 
      floatingActionButton: FloatingActionButton(
        onPressed: () => Get.to(() => VehicleFormView()), // <<<<<<< o erro está aqui
        child: const Icon(Icons.add),
      ),
    );
  }
}