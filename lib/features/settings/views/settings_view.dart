import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/settings_controller.dart';
import '../widgets/settings_menu_item.dart';
import 'package:lucide_icons/lucide_icons.dart'; // Importe seus ícones

class SettingsView extends StatelessWidget {
  const SettingsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final SettingsController controller = Get.find(); // Encontre o controlador

    return GetBuilder<SettingsController>( // Use GetBuilder
      init: controller,
      builder: (_) {
        return AnimatedOpacity(
          opacity: 1.0, // Você pode adicionar animações aqui se precisar
          duration: Duration(milliseconds: 300),
          child: Column(
            children: [
              SettingsMenuItem(
                icon: LucideIcons.user,
                title: 'Dados Pessoais',
                subtitle: 'Editar informações do perfil',
                onTap: () => Get.toNamed('/settings/profile'), // Use suas rotas GetX
              ),
              SizedBox(height: 16),
              SettingsMenuItem(
                icon: LucideIcons.car,
                title: 'Configurações do Veículo',
                subtitle: 'Gerenciar veículos e preferências',
                onTap: () => Get.toNamed('/settings/vehicle'), // Use suas rotas GetX
              ),
              SizedBox(height: 16),
              SettingsMenuItem(
                icon: LucideIcons.bell,
                title: 'Notificações',
                subtitle: 'Configurar alertas e lembretes',
                onTap: () =>
                    Get.toNamed('/settings/notifications'), // Use suas rotas GetX
              ),
              SizedBox(height: 16),
              SettingsMenuItem(
                icon: LucideIcons.shield,
                title: 'Segurança',
                subtitle: 'Senha e autenticação',
                onTap: () => Get.toNamed('/settings/security'), // Use suas rotas GetX
              ),
              SizedBox(height: 32),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: () => controller.handleLogout(), // Chamar o método do controlador
                  icon: Icon(LucideIcons.logOut),
                  label: Text('Sair da conta'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    foregroundColor: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}