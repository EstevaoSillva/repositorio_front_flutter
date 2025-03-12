import 'package:flutter/material.dart';
import 'package:get/get.dart'; 
import 'features/auth/pages/login_page.dart';
import 'features/home/views/home_view.dart';
import 'features/auth/pages/register_page.dart';
import 'features/settings/pages/settings_page.dart';
import 'features/vehicles/pages/vehicle_page.dart';

// Controllers
import 'features/vehicles/controllers/vehicle_controller.dart';
import 'features/auth/controllers/auth_controller.dart'; 
import 'features/home/controllers/home_controller.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    
    // Coloca os Controller no Get
    Get.put(AuthController());
    Get.put(VehicleController());
    Get.put(HomeController());

    return GetMaterialApp( 
      title: 'ManutenCAR',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/', // Tela inicial
      getPages: [ // Define as rotas
        GetPage(name: '/', page: () => LoginPage()),
        GetPage(name: '/home', page: () => HomeView()),
        GetPage(name: '/register', page: () => RegisterScreen()),
        GetPage(name: '/settings', page: () => SettingsPage()),
        GetPage(name: '/veiculos', page: () => VehiclePage()),
      ],
    );
  }
}