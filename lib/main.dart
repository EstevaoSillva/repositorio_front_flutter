import 'package:flutter/material.dart';
import 'package:get/get.dart'; 
import 'pages/login_page.dart';
import 'pages/home_page.dart';
import 'pages/register_page.dart';
import '../controllers/auth_controller.dart'; // Importe o AuthController

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    
    // Coloca o AuthController no Get
    Get.put(AuthController());

    return GetMaterialApp( // Usando GetMaterialApp para navegação com GetX
      title: 'ManutenCAR',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/', // Tela inicial
      getPages: [ // Define as rotas
        GetPage(name: '/', page: () => LoginPage()),
        GetPage(name: '/home', page: () => HomePage()),
        GetPage(name: '/register', page: () => RegisterScreen()),
      ],
    );
  }
}