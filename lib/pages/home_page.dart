import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/home_controller.dart';
import '../controllers/auth_controller.dart';
import '../styles/app_styles.dart';

class HomePage extends StatelessWidget {
  final AuthController authController = Get.find<AuthController>();
  final HomeController homeController = Get.put(HomeController());
  final TextEditingController odometerController = TextEditingController();
  final RxBool showOdometerInput = false.obs;

  HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppStyles.backgroundColor,
      appBar: AppBar(
        backgroundColor: AppStyles.primaryColor,
        title: Obx(() => Text(
              'Bem-vindo, ${authController.userInfo['nome'] ?? 'Usuário'}!', // Verifica se 'nome' existe
              style: TextStyle(color: Colors.white),
            )),
        actions: [
          IconButton(
            icon: Icon(Icons.notifications, color: Colors.white),
            onPressed: () => Get.snackbar("Notificações", homeController.notifications.join("\n")),
          ),
          IconButton(
            icon: Icon(Icons.settings, color: Colors.white),
            onPressed: () {},
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
                items: homeController.vehicles.map((String vehicle) {
                  return DropdownMenuItem<String>(
                    value: vehicle,
                    child: Text(vehicle),
                  );
                }).toList(),
              ),
              SizedBox(height: 10),
              TextField(
                decoration: InputDecoration(
                  hintText: "Pesquisar veículos ou serviços...",
                  prefixIcon: Icon(Icons.search),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
                ),
              ),
              SizedBox(height: 20),
              Container(
                padding: EdgeInsets.all(16),
                decoration: AppStyles.cardDecoration,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Hodômetro Atual", style: AppStyles.title),
                    SizedBox(height: 8),
                    Obx(() => showOdometerInput.value
                        ? Row(
                            children: [
                              Expanded(
                                child: TextFormField( // Usa TextFormField
                                  controller: odometerController,
                                  keyboardType: TextInputType.number,
                                  decoration: InputDecoration(
                                    hintText: "Novo valor",
                                    border: OutlineInputBorder(),
                                  ),
                                  validator: (value) { // Validação do Hodômetro
                                    if (value == null || value.isEmpty) {
                                      return 'Por favor, insira um valor';
                                    }
                                    if (int.tryParse(value) == null) {
                                      return 'Por favor, insira um número válido';
                                    }
                                    return null;
                                  },
                                ),
                              ),
                              IconButton(
                                icon: Icon(Icons.check, color: Colors.green),
                                onPressed: () {
                                  int newOdometer = int.tryParse(odometerController.text) ?? homeController.odometer.value;
                                  homeController.updateOdometer(newOdometer);
                                  showOdometerInput.value = false;
                                  Get.snackbar("Sucesso", "Hodômetro atualizado", backgroundColor: Colors.green, colorText: Colors.white); // Feedback
                                },
                              ),
                            ],
                          )
                        : Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("${homeController.odometer.value} km", style: AppStyles.odometerText),
                              IconButton(
                                icon: Icon(Icons.edit, color: Colors.blue),
                                onPressed: () {
                                  odometerController.text = homeController.odometer.value.toString();
                                  showOdometerInput.value = true;
                                },
                              ),
                            ],
                          )),
                  ],
                ),
              ),
              SizedBox(height: 20),
              Text("Próximos Serviços", style: AppStyles.title),
              Obx(() { // Usando Obx para rebuild quando necessário
                return Column(
                  children: homeController.services.map((service) {
                    return _buildServiceBar(service['name'], service['km'], service['color']);
                  }).toList(),
                );
              }),
            ],
          );
        }),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        selectedItemColor: AppStyles.primaryColor,
        unselectedItemColor: Colors.grey,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.bar_chart), label: "Relatórios"),
          BottomNavigationBarItem(icon: Icon(Icons.directions_car), label: "Veículos"),
          BottomNavigationBarItem(icon: Icon(Icons.build), label: "Serviços"),
          BottomNavigationBarItem(icon: Icon(Icons.local_gas_station), label: "Abastecer"),
        ],
      ),
    );
  }

  Widget _buildServiceBar(String serviceName, int serviceKm, Color color) {
    return Container(
      margin: EdgeInsets.only(bottom: 10),
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.2),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(serviceName, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          Text("$serviceKm km", style: TextStyle(fontSize: 16, color: Colors.grey[700])),
        ],
      ),
    );
  }
}