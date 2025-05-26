import 'package:flutter/material.dart';
import 'settings_features.dart';

class SettingsScreen extends StatelessWidget {
  final bool showAppBar;
  const SettingsScreen({super.key, this.showAppBar = true});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: showAppBar ? AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text('Settings'),
      ) : null,
      backgroundColor: Colors.white,
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
        children: [
          const SizedBox(height: 8),
          const SectionHeader(title: 'Account'),
          const SizedBox(height: 8),
          ListTile(
            leading: CircleAvatar(
              radius: 28,
              backgroundImage: NetworkImage('https://i.imgur.com/1bX5QH6.png'), // Placeholder image
            ),
            title: const Text(
              'Profile',
              style: TextStyle(fontWeight: FontWeight.w500, fontSize: 18),
            ),
            subtitle: const Text(
              'View and edit your profile',
              style: TextStyle(color: Colors.grey, fontSize: 15),
            ),
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (_) => const ProfileScreen()),
              );
            },
          ),
          const SizedBox(height: 8),
          SettingsTile(
            icon: Icons.settings,
            title: 'Account Settings',
            subtitle: 'Manage your account settings',
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (_) => const AccountSettingsScreen()),
              );
            },
          ),
          const SizedBox(height: 24),
          const SectionHeader(title: 'Preferences'),
          const SizedBox(height: 8),
          SettingsTile(
            icon: Icons.cookie_outlined,
            title: 'App Preferences',
            subtitle: 'Customize your app experience',
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (_) => const AppPreferencesScreen()),
              );
            },
          ),
          const SizedBox(height: 8),
          SettingsTile(
            icon: Icons.notifications_none,
            title: 'Notifications',
            subtitle: 'Manage notifications',
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (_) => const NotificationsScreen()),
              );
            },
          ),
          const SizedBox(height: 24),
          const SectionHeader(title: 'Support'),
          const SizedBox(height: 8),
          SettingsTile(
            icon: Icons.help_outline,
            title: 'Help & Support',
            subtitle: 'Get help and support',
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (_) => const HelpSupportScreen()),
              );
            },
          ),
          const SizedBox(height: 8),
          SettingsTile(
            icon: Icons.campaign_outlined,
            title: 'Send Feedback',
            subtitle: 'Send feedback',
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (_) => const SendFeedbackScreen()),
              );
            },
          ),
        ],
      ),
      bottomNavigationBar: null,
    );
  }
}

class SectionHeader extends StatelessWidget {
  final String title;
  const SectionHeader({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: const TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 20,
      ),
    );
  }
}

class SettingsTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback? onTap;
  const SettingsTile({
    super.key,
    required this.icon,
    required this.title,
    required this.subtitle,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Container(
        width: 48,
        height: 48,
        decoration: BoxDecoration(
          color: const Color(0xFFF5F6FA),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Icon(icon, color: Colors.black, size: 28),
      ),
      title: Text(
        title,
        style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 18),
      ),
      subtitle: Text(
        subtitle,
        style: const TextStyle(color: Colors.grey, fontSize: 15),
      ),
      onTap: onTap,
    );
  }
}