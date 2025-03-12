import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/home_controller.dart';
import '../../auth/controllers/auth_controller.dart';
import '../../../shared/styles/app_styles.dart';
import '../widgets/service_bar.dart';
import '../widgets/odometer_card.dart';
import '../widgets/search_bar.dart';

class HomePage extends StatelessWidget {
  final AuthController authController = Get.find<AuthController>();
  final HomeController homeController = Get.find<HomeController>();

  HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    print("HomePage construída");

    return Scaffold(
      backgroundColor: AppStyles.backgroundColor,
      appBar: AppBar(
        backgroundColor: AppStyles.primaryColor,
        title: Obx(() => Text(
              'Bem-vindo, ${authController.userInfo['nome'] ?? 'Usuário'}!',
              style: TextStyle(color: Colors.white),
            )),
        actions: [
          IconButton(
            icon: Icon(Icons.notifications, color: Colors.white),
            onPressed: () => Get.snackbar("Notificações", homeController.notifications.join("\n")),
          ),
          IconButton(
            icon: Icon(Icons.settings, color: Colors.white),
            onPressed: () {
              Get.toNamed('/settings');
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Obx(() {
          if (homeController.isLoading.value) {
            return Center(child: CircularProgressIndicator());
          }

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              DropdownButton<String>(
                value: homeController.selectedVehicle.value.isEmpty ? null : homeController.selectedVehicle.value,
                hint: Text("Selecione um veículo"),
                onChanged: (value) {
                  if (value != null) {
                    homeController.selectedVehicle.value = value;
                    homeController.fetchOdometer();
                  }
                },
                // Acessa a lista interna com .value
                items: homeController.vehicles.map<DropdownMenuItem<String>>((vehicle) {
                  return DropdownMenuItem<String>(
                    value: vehicle['id'].toString(), // Usa o ID como valor
                    child: Text(vehicle['placa'].toString()), // Exibe o nome do veículo
                  );
                }).toList(),
              ),
              SizedBox(height: 10),
              SearchBarWidget(),
              SizedBox(height: 20),
              OdometerCard(),
              SizedBox(height: 20),
              Text("Próximos Serviços", style: AppStyles.title),
              Obx(() {
                return Column(
                  children: homeController.services.map((service) {
                    return ServiceBar(
                      serviceName: service['name'],
                      serviceKm: service['km'],
                      color: service['color'],
                    );
                  }).toList(),
                );
              }),
            ],
          );
        }),
      ),
    );
  }
}