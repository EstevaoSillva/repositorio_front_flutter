import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:get/get.dart'; // Para GetX (navegação e gerenciamento de estado)

class ReportsPage extends StatefulWidget {
  @override
  _ReportsPageState createState() => _ReportsPageState();
}

class _ReportsPageState extends State<ReportsPage> {
  DateTime selectedDate = DateTime.now();

  void handlePreviousMonth() {
    setState(() {
      selectedDate = DateTime(selectedDate.year, selectedDate.month - 1);
    });
  }

  void handleNextMonth() {
    setState(() {
      selectedDate = DateTime(selectedDate.year, selectedDate.month + 1);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: Text('Relatórios'),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 1,
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(60.0),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  icon: Icon(LucideIcons.chevronLeft, color: Colors.grey[600]),
                  onPressed: handlePreviousMonth,
                ),
                Text(
                  DateFormat('MMMM ஆண்டுகள்', 'pt_BR').format(selectedDate),
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500), // Corrigido aqui
                ),
                IconButton(
                  icon: Icon(LucideIcons.chevronRight, color: Colors.grey[600]),
                  onPressed: handleNextMonth,
                ),
              ],
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            Wrap(
              spacing: 16.0,
              runSpacing: 16.0,
              children: [
                ReportCard(
                  icon: Icon(LucideIcons.trendingUp, color: Colors.blue),
                  title: 'Consumo Médio',
                  value: '12,5 km/L',
                ),
                ReportCard(
                  icon: Icon(LucideIcons.calendar, color: Colors.blue),
                  title: 'Última Manutenção',
                  value: '15 dias atrás',
                ),
                ReportCard(
                  icon: Icon(LucideIcons.barChart3, color: Colors.blue),
                  title: 'Gasto Mensal',
                  value: 'R\$ 450,00',
                ),
                ReportCard(
                  icon: Icon(LucideIcons.wrench, color: Colors.blue),
                  title: 'Próx. Revisão',
                  value: '500 km',
                ),
              ],
            ),
            SizedBox(height: 16.0),
            Container(
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
                  Text('Resumo do Período',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Total de Gastos',
                            style: TextStyle(color: Colors.grey[500])),
                        Text('R\$ 550,00',
                            style: TextStyle(fontWeight: FontWeight.bold)),
                      ],
                    ),
                  ),
                  ExpenseItem(
                    title: 'Manutenção',
                    date: '15/03/2024',
                    amount: 350.00,
                  ),
                  ExpenseItem(
                    title: 'Combustível',
                    date: '10/03/2024',
                    amount: 150.00,
                  ),
                  ExpenseItem(
                    title: 'Lavagem',
                    date: '05/03/2024',
                    amount: 50.00,
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        selectedDate = DateTime.now();
                      });
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: Colors.grey[600],
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      elevation: 1,
                    ),
                    child: Text('Mês Atual'),
                  ),
                  SizedBox(width: 8.0),
                  ElevatedButton(
                    onPressed: () {
                      // TODO: Implementar exportação
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue[100],
                      foregroundColor: Colors.blue,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                    child: Text('Exportar Relatório'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ReportCard extends StatelessWidget {
  final Icon icon;
  final String title;
  final String value;

  ReportCard({required this.icon, required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.45,
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
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                  color: Colors.blue[100],
                  borderRadius: BorderRadius.circular(100.0),
                ),
                child: icon,
              ),
              SizedBox(width: 8.0),
              Text(title, style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500)), // Corrigido aqui
            ],
          ),
          SizedBox(height: 8.0),
          Text(value, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}

class ExpenseItem extends StatelessWidget {
  final String title;
  final String date;
  final double amount;

  ExpenseItem({required this.title, required this.date, required this.amount});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: TextStyle(fontWeight: FontWeight.w500)),
              Text(date, style: TextStyle(fontSize: 12, color: Colors.grey[500])),
            ],
          ),
          Text(
            'R\$ ${amount.toStringAsFixed(2)}',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}