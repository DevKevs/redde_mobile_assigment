import 'package:flutter/material.dart';

class DeveloperInfoWidget extends StatelessWidget {
  final String developerName;
  final String email;
  final String? github;
  final String? linkedin;
  final String? portfolio;
  final Color? backgroundColor;
  final Color? textColor;

  const DeveloperInfoWidget({
    super.key,
    required this.developerName,
    required this.email,
    this.github,
    this.linkedin,
    this.portfolio,
    this.backgroundColor,
    this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      decoration: BoxDecoration(
        color: backgroundColor ?? Colors.grey[900],
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 4,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            height: 1,
            width: 50,
            color: Colors.grey[600],
            margin: const EdgeInsets.only(bottom: 8),
          ),

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.code, size: 16, color: textColor ?? Colors.white70),
              const SizedBox(width: 8),
              Text(
                'Desarrollado por $developerName',
                style: TextStyle(
                  fontSize: 12,
                  color: textColor ?? Colors.white70,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),

          const SizedBox(height: 4),

          TextButton.icon(
            onPressed: () => _showContactDialog(context),
            label: const Text(
              'Ficha de Información',
              style: TextStyle(fontSize: 12, color: Colors.black),
            ),
            icon: const Icon(Icons.contact_mail, size: 12, color: Colors.black),
            style: TextButton.styleFrom(
              backgroundColor: Colors.white,
              foregroundColor: textColor ?? Colors.white70,
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            ),
          ),
        ],
      ),
    );
  }

  void _showContactDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Row(
            children: [
              Icon(Icons.code, color: Colors.teal),
              const SizedBox(width: 8),
              Text('Dev Info'),
            ],
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildInfoRow(Icons.person, 'Nombre:', developerName),
              const SizedBox(height: 12),
              _buildInfoRow(Icons.email, 'Email:', email),
              if (github != null) ...[
                const SizedBox(height: 12),
                _buildInfoRow(Icons.code, 'GitHub:', github!),
              ],
              if (linkedin != null) ...[
                const SizedBox(height: 12),
                _buildInfoRow(Icons.work, 'LinkedIn:', linkedin!),
              ],
              if (portfolio != null) ...[
                const SizedBox(height: 12),
                _buildInfoRow(Icons.web, 'Portfolio:', portfolio!),
              ],
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cerrar', style: TextStyle(color: Colors.teal)),
            ),
          ],
        );
      },
    );
  }

  Widget _buildInfoRow(IconData icon, String label, String value) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, size: 16, color: Colors.grey[600]),
        const SizedBox(width: 8),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey[600],
                  fontWeight: FontWeight.w500,
                ),
              ),
              Text(
                value,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class DeveloperInfoBottomBar extends StatelessWidget {
  final String developerName;
  final String email;
  final String? github;
  final String? linkedin;
  final String? portfolio;

  const DeveloperInfoBottomBar({
    super.key,
    required this.developerName,
    required this.email,
    this.github,
    this.linkedin,
    this.portfolio,
  });

  @override
  Widget build(BuildContext context) {
    return DeveloperInfoWidget(
      developerName: developerName,
      email: email,
      github: github,
      linkedin: linkedin,
      portfolio: portfolio,
    );
  }
}
