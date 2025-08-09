import 'package:flutter/material.dart';
import '../../core/theme/colors.dart';
import '../widgets/bouncing_widget.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  late List<Animation<Offset>> _slideAnimations;
  late List<Animation<double>> _fadeAnimations;

  bool _notificationsEnabled = true;
  bool _locationEnabled = true;
  bool _darkModeEnabled = false;
  bool _biometricEnabled = false;

  final List<Map<String, dynamic>> _settingsItems = [
    {
      'title': 'Profile',
      'subtitle': 'Edit your personal information',
      'icon': Icons.person_outline,
      'type': 'navigation',
      'route': null,
    },
    {
      'title': 'Payment Methods',
      'subtitle': 'Manage cards and payment options',
      'icon': Icons.payment,
      'type': 'navigation',
      'route': null,
    },
    {
      'title': 'Notifications',
      'subtitle': 'Push notifications and alerts',
      'icon': Icons.notifications_outlined,
      'type': 'switch',
      'value': true,
    },
    {
      'title': 'Location Services',
      'subtitle': 'Allow location access',
      'icon': Icons.location_on_outlined,
      'type': 'switch',
      'value': true,
    },
    {
      'title': 'Dark Mode',
      'subtitle': 'Switch to dark theme',
      'icon': Icons.dark_mode_outlined,
      'type': 'switch',
      'value': false,
    },
    {
      'title': 'Biometric Login',
      'subtitle': 'Use fingerprint or face ID',
      'icon': Icons.fingerprint,
      'type': 'switch',
      'value': false,
    },
    {
      'title': 'Language',
      'subtitle': 'English',
      'icon': Icons.language,
      'type': 'navigation',
      'route': null,
    },
    {
      'title': 'Privacy Policy',
      'subtitle': 'Read our privacy policy',
      'icon': Icons.privacy_tip_outlined,
      'type': 'navigation',
      'route': null,
    },
    {
      'title': 'Terms of Service',
      'subtitle': 'Read terms and conditions',
      'icon': Icons.description_outlined,
      'type': 'navigation',
      'route': null,
    },
    {
      'title': 'Help & Support',
      'subtitle': 'Get help and contact support',
      'icon': Icons.help_outline,
      'type': 'navigation',
      'route': null,
    },
  ];

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );

    _slideAnimations = List.generate(
      _settingsItems.length,
      (index) => Tween<Offset>(
        begin: const Offset(1, 0),
        end: Offset.zero,
      ).animate(CurvedAnimation(
        parent: _controller,
        curve: Interval(
          index * 0.05,
          0.5 + (index * 0.05),
          curve: Curves.easeOut,
        ),
      )),
    );

    _fadeAnimations = List.generate(
      _settingsItems.length,
      (index) => Tween<double>(
        begin: 0.0,
        end: 1.0,
      ).animate(CurvedAnimation(
        parent: _controller,
        curve: Interval(
          index * 0.05,
          0.5 + (index * 0.05),
          curve: Curves.easeIn,
        ),
      )),
    );

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _handleSettingTap(Map<String, dynamic> item, int index) {
    if (item['type'] == 'navigation' && item['route'] != null) {
      Navigator.pushNamed(context, item['route']);
    } else if (item['type'] == 'switch') {
      setState(() {
        switch (index) {
          case 2: // Notifications
            _notificationsEnabled = !_notificationsEnabled;
            _settingsItems[index]['value'] = _notificationsEnabled;
            break;
          case 3: // Location
            _locationEnabled = !_locationEnabled;
            _settingsItems[index]['value'] = _locationEnabled;
            break;
          case 4: // Dark Mode
            _darkModeEnabled = !_darkModeEnabled;
            _settingsItems[index]['value'] = _darkModeEnabled;
            break;
          case 5: // Biometric
            _biometricEnabled = !_biometricEnabled;
            _settingsItems[index]['value'] = _biometricEnabled;
            break;
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: BouncingWidget(
          onTap: () => Navigator.pop(context),
          child: const Icon(
            Icons.arrow_back,
            color: AppColors.primary,
          ),
        ),
        title: const Text(
          'Settings',
          style: TextStyle(
            color: AppColors.primary,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Column(
          children: [
            // Profile Header
            Container(
              padding: const EdgeInsets.all(24),
              child: Row(
                children: [
                  Container(
                    width: 80,
                    height: 80,
                    decoration: BoxDecoration(
                      color: AppColors.primary.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(40),
                    ),
                    child: const Icon(
                      Icons.person,
                      color: AppColors.primary,
                      size: 40,
                    ),
                  ),
                  const SizedBox(width: 16),
                  const Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'John Doe',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: AppColors.primary,
                          ),
                        ),
                        SizedBox(height: 4),
                        Text(
                          'john.doe@example.com',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ),
                  BouncingWidget(
                    onTap: () {
                      // Handle edit profile
                    },
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: AppColors.primary.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Icon(
                        Icons.edit,
                        color: AppColors.primary,
                        size: 20,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const Divider(height: 1),

            // Settings List
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(vertical: 8),
                itemCount: _settingsItems.length,
                itemBuilder: (context, index) {
                  final item = _settingsItems[index];

                  return SlideTransition(
                    position: _slideAnimations[index],
                    child: FadeTransition(
                      opacity: _fadeAnimations[index],
                      child: AnimatedSettingsTile(
                        item: item,
                        onTap: () => _handleSettingTap(item, index),
                        delay: Duration(milliseconds: index * 50),
                      ),
                    ),
                  );
                },
              ),
            ),

            // App Version
            Padding(
              padding: const EdgeInsets.all(16),
              child: Text(
                'Version 1.0.0',
                style: TextStyle(
                  color: Colors.grey.shade600,
                  fontSize: 14,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class AnimatedSettingsTile extends StatefulWidget {
  final Map<String, dynamic> item;
  final VoidCallback onTap;
  final Duration delay;

  const AnimatedSettingsTile({
    super.key,
    required this.item,
    required this.onTap,
    required this.delay,
  });

  @override
  State<AnimatedSettingsTile> createState() => _AnimatedSettingsTileState();
}

class _AnimatedSettingsTileState extends State<AnimatedSettingsTile>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(milliseconds: 400),
      vsync: this,
    );

    _scaleAnimation = Tween<double>(
      begin: 0.95,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOut,
    ));

    Future.delayed(widget.delay, () {
      if (mounted) {
        _controller.forward();
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      scale: _scaleAnimation,
      child: BouncingWidget(
        onTap: widget.onTap,
        child: Container(
          margin: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 4,
          ),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 10,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Row(
            children: [
              Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  color: AppColors.primary.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(25),
                ),
                child: Icon(
                  widget.item['icon'],
                  color: AppColors.primary,
                  size: 24,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.item['title'],
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      widget.item['subtitle'],
                      style: const TextStyle(
                        fontSize: 14,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),
              if (widget.item['type'] == 'switch')
                Switch(
                  value: widget.item['value'] ?? false,
                  onChanged: (value) => widget.onTap(),
                  activeColor: AppColors.primary,
                )
              else
                const Icon(
                  Icons.arrow_forward_ios,
                  color: Colors.grey,
                  size: 16,
                ),
            ],
          ),
        ),
      ),
    );
  }
}