import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:manutencar_mobile/controllers/auth_controller.dart';
import 'package:flutter_svg/flutter_svg.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final AuthController _authController = Get.put(AuthController());
  final _formKey = GlobalKey<FormState>(); // Chave para o Form

  bool _obscurePassword = true; // Estado para ocultar/mostrar senha

  void _togglePasswordVisibility() {
    setState(() {
      _obscurePassword = !_obscurePassword;
    });
  }

  void _handleSubmit() async {
    if (_formKey.currentState!.validate()) { // Valida o Form
      final email = _emailController.text.trim();
      final password = _passwordController.text.trim();

      print('Login - Email: $email, Password: $password'); // Log dos dados

      await _authController.login(email, password);

      if (_authController.errorMessage.isNotEmpty) {
        Get.snackbar("Erro", _authController.errorMessage.value,
            backgroundColor: const Color.fromARGB(255, 255, 0, 0));
        _authController.clearErrorMessage(); // Limpa a mensagem de erro
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form( // Envolve com Form
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: 64,
                  height: 64,
                  decoration: BoxDecoration(
                    color: Colors.blue[100],
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: SvgPicture.asset(
                      'assets/car.svg',
                      width: 32,
                      height: 32,
                      color: Colors.blue,
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  'ManutenCAR',
                  style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87),
                ),
                const SizedBox(height: 8),
                Text(
                  'Seu assistente automotivo pessoal',
                  style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                ),
                const SizedBox(height: 32),
                TextFormField( // Usa TextFormField
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: const InputDecoration(
                    labelText: 'Email',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) { // Validação do Email
                    if (value == null || value.isEmpty) {
                      return 'Por favor, insira o email';
                    }
                    if (!RegExp(
                            r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$')
                        .hasMatch(value)) {
                      return 'Por favor, insira um email válido';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                TextFormField( // Usa TextFormField
                  controller: _passwordController,
                  obscureText: _obscurePassword,
                  decoration: InputDecoration(
                    labelText: 'Senha',
                    border: const OutlineInputBorder(),
                    suffixIcon: IconButton(
                      icon: Icon(
                        _obscurePassword
                            ? Icons.visibility_off
                            : Icons.visibility,
                      ),
                      onPressed: _togglePasswordVisibility,
                    ),
                  ),
                  validator: (value) { // Validação da Senha
                    if (value == null || value.isEmpty) {
                      return 'Por favor, insira a senha';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 24),
                Obx(() {
                  return _authController.isLoading.value
                      ? const CircularProgressIndicator()
                      : SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: _handleSubmit,
                            child: const Text('Entrar'),
                          ),
                        );
                }),
                const SizedBox(height: 16),
                TextButton(
                  onPressed: () => Get.toNamed('/forgot-password'),
                  child: const Text('Esqueceu sua senha?',
                      style: TextStyle(color: Colors.blue)),
                ),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('Não tem uma conta?'),
                    TextButton(
                      onPressed: () => Get.toNamed('/register'),
                      child: const Text('Cadastre-se',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.blue)),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}