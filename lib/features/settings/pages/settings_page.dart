import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:fluttertoast/fluttertoast.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1,
        leading: IconButton(
          icon: Icon(LucideIcons.arrowLeft, color: Colors.grey[600]),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text('Configurações', style: TextStyle(fontWeight: FontWeight.w600)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SettingsList(),
      ),
    );
  }
}

class SettingsList extends StatefulWidget {
  const SettingsList({super.key});

  @override
  _SettingsListState createState() => _SettingsListState();
}

class _SettingsListState extends State<SettingsList>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _opacityAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _opacityAnimation = Tween<double>(begin: 0, end: 1).animate(
        CurvedAnimation(parent: _animationController, curve: Curves.easeOut));
    _slideAnimation = Tween<Offset>(begin: Offset(0, 0.1), end: Offset.zero)
        .animate(
            CurvedAnimation(parent: _animationController, curve: Curves.easeOut));
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _showToast(String message) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.grey[800],
      textColor: Colors.white,
      fontSize: 16.0,
    );
  }

  void _handleLogout(BuildContext context) {
    _showToast("Logout realizado");
    Navigator.pushReplacementNamed(context, '/login');
  }

  Widget _buildMenuItem(
      BuildContext context, IconData icon, String title, String subtitle,
      {required VoidCallback onTap}) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              spreadRadius: 1,
              blurRadius: 3,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.blue[100],
                borderRadius: BorderRadius.circular(100),
              ),
              child: Icon(icon, color: Colors.blue),
            ),
            SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: TextStyle(fontWeight: FontWeight.w500)),
                  Text(subtitle, style: TextStyle(color: Colors.grey[500], fontSize: 14)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      opacity: _opacityAnimation.value,
      duration: Duration(milliseconds: 300),
      child: SlideTransition(
        position: _slideAnimation,
        child: Column(
          children: [
            _buildMenuItem(context, LucideIcons.user, 'Dados Pessoais',
                'Editar informações do perfil',
                onTap: () => Navigator.pushNamed(context, '/settings/profile')),
            SizedBox(height: 16),
            _buildMenuItem(context, LucideIcons.car, 'Configurações do Veículo',
                'Gerenciar veículos e preferências',
                onTap: () => Navigator.pushNamed(context, '/settings/vehicle')),
            SizedBox(height: 16),
            _buildMenuItem(context, LucideIcons.bell, 'Notificações',
                'Configurar alertas e lembretes',
                onTap: () =>
                    Navigator.pushNamed(context, '/settings/notifications')),
            SizedBox(height: 16),
            _buildMenuItem(context, LucideIcons.shield, 'Segurança',
                'Senha e autenticação',
                onTap: () => Navigator.pushNamed(context, '/settings/security')),
            SizedBox(height: 32),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: () => _handleLogout(context),
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
      ),
    );
  }
}