import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/auth_controller.dart'; // Importe o AuthController

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _telefoneController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();
  final _formKey = GlobalKey<FormState>(); // Chave para o Form
  final AuthController _authController = Get.find(); // Obtém o AuthController

  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;

  void _togglePasswordVisibility() {
    setState(() {
      _obscurePassword = !_obscurePassword;
    });
  }

  void _toggleConfirmPasswordVisibility() {
    setState(() {
      _obscureConfirmPassword = !_obscureConfirmPassword;
    });
  }

  Future<void> _register() async {
    if (_formKey.currentState!.validate()) {
      if (_passwordController.text != _confirmPasswordController.text) {
        Get.snackbar("Erro", "As senhas não coincidem", backgroundColor: Colors.red, colorText: Colors.white);
        return;
      }

      try {
        print(" Enviando dados para API: ${_usernameController.text}, ${_emailController.text}, ${_telefoneController.text}");

        await _authController.register( // Usa AuthController
          username: _usernameController.text,
          email: _emailController.text,
          telefone: _telefoneController.text,
          password: _passwordController.text,
        );

        if (_authController.errorMessage.isEmpty) {
          Get.snackbar("Sucesso", "Cadastro realizado com sucesso!", backgroundColor: Colors.green, colorText: Colors.white);
          Get.offNamed('/login');
        } else {
          Get.snackbar("Erro", _authController.errorMessage.value, backgroundColor: Colors.red, colorText: Colors.white);
        }

        print(" Resposta da API: ${_authController.errorMessage.value}");
      } catch (e) {
        Get.snackbar("Erro", "Erro ao conectar ao servidor", backgroundColor: Colors.red, colorText: Colors.white);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Criar Conta")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form( // Envolve com Form
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField( // Usa TextFormField
                controller: _usernameController,
                decoration: InputDecoration(labelText: "Nome de usuário"),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, insira o nome de usuário';
                  }
                  return null;
                },
              ),
              TextFormField( // Usa TextFormField
                controller: _emailController,
                decoration: InputDecoration(labelText: "Email"),
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, insira o email';
                  }
                  if (!RegExp(r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$')
                      .hasMatch(value)) {
                    return 'Por favor, insira um email válido';
                  }
                  return null;
                },
              ),
              TextFormField( // Usa TextFormField
                controller: _telefoneController,
                decoration: InputDecoration(labelText: "Telefone"),
                keyboardType: TextInputType.phone,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, insira o telefone';
                  }
                  // Adicione validação de telefone aqui, se necessário
                  return null;
                },
              ),
              TextFormField( // Usa TextFormField
                controller: _passwordController,
                decoration: InputDecoration(
                  labelText: "Senha",
                  suffixIcon: IconButton(
                    icon: Icon(
                      _obscurePassword ? Icons.visibility_off : Icons.visibility,
                    ),
                    onPressed: _togglePasswordVisibility,
                  ),
                ),
                obscureText: _obscurePassword,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, insira a senha';
                  }
                  return null;
                },
              ),
              TextFormField( // Usa TextFormField
                controller: _confirmPasswordController,
                decoration: InputDecoration(
                  labelText: "Confirmar Senha",
                  suffixIcon: IconButton(
                    icon: Icon(
                      _obscureConfirmPassword ? Icons.visibility_off : Icons.visibility,
                    ),
                    onPressed: _toggleConfirmPasswordVisibility,
                  ),
                ),
                obscureText: _obscureConfirmPassword,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, insira a confirmação de senha';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _register,
                child: Text("Criar conta"),
              ),
              TextButton(
                onPressed: () => Get.toNamed('/login'),
                child: Text("Já tem uma conta? Entrar"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}