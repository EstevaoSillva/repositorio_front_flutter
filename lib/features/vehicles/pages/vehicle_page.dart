import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../../../shared/config/config.dart'; // Configuração das URLs

class VehiclePage extends StatefulWidget {
  const VehiclePage({super.key});

  @override
  _VehiclePageState createState() => _VehiclePageState();
}

class _VehiclePageState extends State<VehiclePage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _marcaController = TextEditingController();
  final TextEditingController _modeloController = TextEditingController();
  final TextEditingController _anoController = TextEditingController();
  final TextEditingController _corController = TextEditingController();
  final TextEditingController _placaController = TextEditingController();

  bool _isLoading = false;

  Future<void> _salvarVeiculo() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() {
      _isLoading = true;
    });

    final url = Uri.parse(ApiConfig.veiculos);
    final response = await http.post(
      url,
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        "marca": _marcaController.text,
        "modelo": _modeloController.text,
        "ano": _anoController.text,
        "cor": _corController.text,
        "placa": _placaController.text,
      }),
    );

    setState(() {
      _isLoading = false;
    });

    if (response.statusCode == 201 || response.statusCode == 200) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Veículo cadastrado com sucesso!")),
      );
      Navigator.pop(context);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Erro ao salvar veículo")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Novo Veículo")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _placaController,
                decoration: InputDecoration(labelText: "Placa"),
                validator: (value) => value!.isEmpty ? "Digite a placa" : null,
              ),
              TextFormField(
                controller: _marcaController,
                decoration: InputDecoration(labelText: "Marca"),
                validator: (value) => value!.isEmpty ? "Digite a marca" : null,
              ),
              TextFormField(
                controller: _modeloController,
                decoration: InputDecoration(labelText: "Modelo"),
                validator: (value) => value!.isEmpty ? "Digite o modelo" : null,
              ),
              TextFormField(
                controller: _anoController,
                decoration: InputDecoration(labelText: "Ano"),
                keyboardType: TextInputType.number,
                validator: (value) => value!.isEmpty ? "Digite o ano" : null,
              ),
              TextFormField(
                controller: _corController,
                decoration: InputDecoration(labelText: "Cor"),
                validator: (value) => value!.isEmpty ? "Digite a cor" : null,
              ),
              SizedBox(height: 20),
              _isLoading
                  ? CircularProgressIndicator()
                  : ElevatedButton(
                      onPressed: _salvarVeiculo,
                      child: Text("Salvar Veículo"),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
