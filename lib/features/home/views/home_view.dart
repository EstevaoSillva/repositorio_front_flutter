import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../pages/home_page.dart';
import '../../reports/pages/reports_page.dart';
import '../../vehicles/pages/vehicle_page.dart';
import '../../../shared/styles/app_styles.dart';
import '../../vehicles/maintenance/pages/services_page.dart';
// import '../../settings/pages/settings_page.dart';

class HomeView extends StatelessWidget {
  final _selectedIndex = 0.obs;

  HomeView({super.key});


  @override
  Widget build(BuildContext context) {
    final List<Widget> pages = [
      HomePage(),
      ReportsPage(), // Página de Relatórios
      VehiclePage(), // Página de Veículos
      ServicesPage(), // Página de Serviços
      // FuelPage(), // Página de Abastecer
    ];

    return Scaffold(
      body: Obx(() => IndexedStack(
            index: _selectedIndex.value,
            children: pages,
          )),
      bottomNavigationBar: Obx(
        () => BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          selectedItemColor: AppStyles.primaryColor,
          unselectedItemColor: Colors.grey,
          currentIndex: _selectedIndex.value,
          onTap: (index) {
            _selectedIndex.value = index;
          },
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
            BottomNavigationBarItem(icon: Icon(Icons.bar_chart), label: "Relatórios"),
            BottomNavigationBarItem(icon: Icon(Icons.directions_car), label: "Veículos"),
            BottomNavigationBarItem(icon: Icon(Icons.build), label: "Serviços"),
            BottomNavigationBarItem(icon: Icon(Icons.local_gas_station), label: "Abastecer"),
          ],
        ),
      ),
    );
  }
}