import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class FuelPage extends StatefulWidget {
  @override
  _FuelPageState createState() => _FuelPageState();
}

class _FuelPageState extends State<FuelPage> {
  bool showForm = false;
  List<Map<String, dynamic>> refuelings = [
    {
      'id': 1,
      'odometer': 52555,
      'liters': 40.0,
      'pricePerLiter': 5.29,
      'date': "2024-03-15",
      'previousOdometer': 52055,
      'previousDate': "2024-03-01"
    }
  ];

  Map<String, double> calculateMetrics(Map<String, dynamic> refueling) {
    // ... (código do calculateMetrics)
  }

  // ... (controllers)

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // ... (código do Scaffold)
    );
  }

  Widget _buildSummary() {
    return Container(
      padding: EdgeInsets.all(16.0),
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
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    padding: EdgeInsets.all(8.0),
                    decoration: BoxDecoration(
                      color: Colors.blue[100],
                      borderRadius: BorderRadius.circular(100.0),
                    ),
                    child: Icon(LucideIcons.fuel, color: Colors.blue, size: 24),
                  ),
                  SizedBox(width: 8.0),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Último Abastecimento',
                          style: TextStyle(fontWeight: FontWeight.w500)),
                      Text('15/03/2024',
                          style: TextStyle(fontSize: 12, color: Colors.grey[500])),
                    ],
                  ),
                ],
              ),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    showForm = true;
                  });
                },
                child: Row(
                  children: [
                    Icon(LucideIcons.plus, size: 16),
                    SizedBox(width: 4.0),
                    Text('Novo'),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildForm() {
    return Container(
      // ... (código do _buildForm)
    );
  }

  Widget _buildMetrics() {
    var metrics = calculateMetrics(refuelings.first);
    return Row(
      children: [
        Expanded(
          child: Container(
            padding: EdgeInsets.all(16.0),
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
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Desempenho',
                    style: TextStyle(fontSize: 12, color: Colors.grey[500])),
                Text('${metrics['performance']?.toStringAsFixed(1)} km/L',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              ],
            ),
          ),
        ), // Fechamento da Expanded
        SizedBox(width: 16.0),
        Expanded(
          child: Container(
            padding: EdgeInsets.all(16.0),
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
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Total Gasto',
                    style: TextStyle(fontSize: 12, color: Colors.grey[500])),
                Text('R\$ ${metrics['totalPrice']?.toStringAsFixed(2)}',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              ],
            ),
          ),
        ), // Fechamento da Expanded
      ],
    );
  }

  Widget _buildHistory() {
    return Column(
      children: refuelings.map((refueling) {
        var metrics = calculateMetrics(refueling);
        return Container(
          margin: EdgeInsets.only(bottom: 16.0),
          padding: EdgeInsets.all(16.0),
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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                DateFormat('dd/MM/yyyy').format(DateTime.parse(refueling['date'])),
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Hodômetro: ${refueling['odometer']} km'),
                  Text('Litros: ${refueling['liters']} L'),
                ],
              ),
              SizedBox(height: 4.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Preço/L: R\$ ${refueling['pricePerLiter'].toStringAsFixed(2)}'),
                  Text('Total: R\$ ${metrics['totalPrice']?.toStringAsFixed(2)}'),
                ],
              ),
              SizedBox(height: 4.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Desempenho: ${metrics['performance']?.toStringAsFixed(1)} km/L'),
                  Text('Km/dia: ${metrics['kmPerDay']?.toStringAsFixed(1)} km'),
                ],
              ),
            ],
          ),
        );
      }).toList(),
    );
  }
}