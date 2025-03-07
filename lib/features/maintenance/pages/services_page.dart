import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:get/get.dart';

class ServicesPage extends StatelessWidget {
  final List<Map<String, dynamic>> services = [
    {
      'id': 1,
      'title': "Troca de Óleo",
      'icon': LucideIcons.circleDot,
      'description': "Troca de óleo do motor e filtro de óleo",
      'route': "/oil-change"
    },
    {
      'id': 2,
      'title': "Filtros",
      'icon': LucideIcons.filter,
      'description': "Troca dos filtros de ar, combustível e cabine",
      'route': "/filters"
    },
    {
      'id': 3,
      'title': "Correia Dentada",
      'icon': LucideIcons.clock4,
      'description': "Substituição da correia dentada e tensionadores",
      'route': "/timing-belt"
    },
    {
      'id': 4,
      'title': "Alinhamento",
      'icon': LucideIcons.gauge,
      'description': "Alinhamento e balanceamento das rodas",
      'route': "/alignment"
    },
    {
      'id': 5,
      'title': "Bateria",
      'icon': LucideIcons.battery,
      'description': "Teste e substituição da bateria",
      'route': "/battery"
    },
    {
      'id': 6,
      'title': "Fluido de Freio",
      'icon': LucideIcons.droplets,
      'description': "Troca do fluido de freio",
      'route': "/brake-fluid"
    },
    {
      'id': 7,
      'title': "Pneus",
      'icon': LucideIcons.circleDashed,
      'description': "Rodízio e substituição dos pneus",
      'route': "/tires"
    },
    {
      'id': 8,
      'title': "Ar Condicionado",
      'icon': LucideIcons.wind,
      'description': "Manutenção e recarga do ar condicionado",
      'route': "/air-conditioning"
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: Text('Serviços'),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 1,
      ),
      body: GridView.builder(
        padding: EdgeInsets.all(16.0),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 16.0,
          mainAxisSpacing: 16.0,
          childAspectRatio: 0.8,
        ),
        itemCount: services.length,
        itemBuilder: (context, index) {
          final service = services[index];
          return GestureDetector(
            onTap: () => Get.toNamed(service['route']),
            child: TweenAnimationBuilder(
              tween: Tween<double>(begin: 0, end: 1),
              duration: Duration(milliseconds: 300 + (index * 100)),
              builder: (context, value, child) {
                return Transform.translate(
                  offset: Offset(0, 50 * (1 - value)),
                  child: Opacity(
                    opacity: value,
                    child: child,
                  ),
                );
              },
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.2),
                      spreadRadius: 2,
                      blurRadius: 5,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      padding: EdgeInsets.all(16.0),
                      decoration: BoxDecoration(
                        color: Colors.blue[100],
                        borderRadius: BorderRadius.circular(100.0),
                      ),
                      child: Icon(service['icon'], color: Colors.blue, size: 32),
                    ),
                    SizedBox(height: 8.0),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Text(
                        service['title'],
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    SizedBox(height: 4.0),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Text(
                        service['description'],
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey[500],
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}