import 'package:flutter/material.dart';

class ServiceBar extends StatelessWidget {
  final String serviceName;
  final int serviceKm;
  final Color color;

  const ServiceBar({super.key, 
    required this.serviceName,
    required this.serviceKm,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 10),
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: color.withOpacity(0.2),
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