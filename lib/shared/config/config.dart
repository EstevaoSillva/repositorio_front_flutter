class ApiConfig {
  static const String baseUrl = "http://192.168.100.87:8000"; // Ip de casa
  // static const String baseUrl = "http://10.31.2.253:8000"; // Ip do curso
  // static const String baseUrl = "http://127.0.0.1:8000"; // Localhost
  static const String apiUrl = "$baseUrl/api"; // URL base da API
  static const String authLogin = "$apiUrl/login/"; // Rota de autenticação
  static const String register = "$apiUrl/register/"; // Rota de registro
  static const String userInfo = "$apiUrl/user/"; // Rota de informações do usuário
  static const String veiculos = "$apiUrl/veiculos/";
  static const String hodometros = "$apiUrl/hodometros/";
  static const String abastecimentos = "$apiUrl/abastecimentos/";
}

