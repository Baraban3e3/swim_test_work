import 'package:flutter/material.dart';
import 'package:swim_test/features/users/domain/entities/user_entity.dart';

class UserDetailScreen extends StatelessWidget {
  final UserEntity user;

  const UserDetailScreen({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(user.name),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 50,
              backgroundColor: Colors.blueAccent.withValues(alpha: 0.2),
              child: Text(
                user.name.substring(0, 1),
                style: const TextStyle(fontSize: 48, color: Colors.blueAccent, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 16),
            Text(
              user.name,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            Text(
              '@${user.username}',
              style: const TextStyle(fontSize: 16, color: Colors.blueAccent),
            ),
            const SizedBox(height: 32),
            _buildInfoTile(Icons.email, 'Email', user.email),
            _buildInfoTile(Icons.phone, 'Phone', user.phone),
            _buildInfoTile(Icons.language, 'Website', user.website),
            _buildInfoTile(Icons.business, 'Company', user.companyName),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoTile(IconData icon, String label, String value) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF2C2C2E),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          Icon(icon, color: Colors.white54),
          const SizedBox(width: 16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(label, style: const TextStyle(color: Colors.white54, fontSize: 12)),
              const SizedBox(height: 4),
              Text(value, style: const TextStyle(fontSize: 16)),
            ],
          ),
        ],
      ),
    );
  }
}
