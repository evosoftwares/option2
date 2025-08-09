import 'package:flutter/material.dart';
import '../../../core/routes/app_routes.dart';
import '../../../core/theme/colors.dart';
import '../../widgets/animated_button.dart';
import '../../widgets/bouncing_widget.dart';

class RideOptionsScreen extends StatefulWidget {
  const RideOptionsScreen({super.key});

  @override
  State<RideOptionsScreen> createState() => _RideOptionsScreenState();
}

class _RideOptionsScreenState extends State<RideOptionsScreen> with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;
  
  String _selectedRideType = 'standard';
  Map<String, bool> _preferences = {
    'ac': false,
    'pet': false,
    'trunk': false,
    'condo': false,
  };

  final Map<String, Map<String, dynamic>> _rideTypes = {
    'pool': {
      'name': 'UberPool',
      'description': 'Share your ride',
      'price': 8.50,
      'time': '5-10 min',
      'icon': Icons.people,
    },
    'standard': {
      'name': 'UberX',
      'description': 'Affordable, everyday rides',
      'price': 12.30,
      'time': '3-8 min',
      'icon': Icons.directions_car,
    },
    'premium': {
      'name': 'UberBlack',
      'description': 'Premium rides',
      'price': 18.90,
      'time': '5-12 min',
      'icon': Icons.star,
    },
    'xl': {
      'name': 'UberXL',
      'description': 'Larger vehicles',
      'price': 15.60,
      'time': '4-10 min',
      'icon': Icons.airport_shuttle,
    },
  };

  @override
  void initState() {
    super.initState();
    
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1200),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeIn,
    ));

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.2),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOut,
    ));

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _selectRideType(String type) {
    setState(() {
      _selectedRideType = type;
    });
  }

  void _togglePreference(String key) {
    setState(() {
      _preferences[key] = !_preferences[key]!;
    });
  }

  void _confirmRide() {
    Navigator.pushNamed(context, AppRoutes.driverSelection);
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
          'Choose Your Ride',
          style: TextStyle(
            color: AppColors.primary,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: FadeTransition(
            opacity: _fadeAnimation,
            child: SlideTransition(
              position: _slideAnimation,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Select ride type',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: AppColors.primary,
                    ),
                  ),
                  const SizedBox(height: 20),
                  
                  // Ride Types
                  Expanded(
                    flex: 2,
                    child: ListView.builder(
                      itemCount: _rideTypes.length,
                      itemBuilder: (context, index) {
                        final type = _rideTypes.keys.elementAt(index);
                        final rideData = _rideTypes[type]!;
                        final isSelected = _selectedRideType == type;
                        
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 12),
                          child: BouncingWidget(
                            onTap: () => _selectRideType(type),
                            child: Container(
                              padding: const EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                color: isSelected ? AppColors.primary.withOpacity(0.1) : Colors.white,
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(
                                  color: isSelected ? AppColors.primary : Colors.grey[300]!,
                                  width: 2,
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.05),
                                    blurRadius: 10,
                                    offset: const Offset(0, 5),
                                  ),
                                ],
                              ),
                              child: Row(
                                children: [
                                  Container(
                                    width: 50,
                                    height: 50,
                                    decoration: BoxDecoration(
                                      color: isSelected ? AppColors.primary : Colors.grey[100],
                                      borderRadius: BorderRadius.circular(25),
                                    ),
                                    child: Icon(
                                      rideData['icon'],
                                      color: isSelected ? Colors.white : AppColors.primary,
                                      size: 24,
                                    ),
                                  ),
                                  const SizedBox(width: 16),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          rideData['name'],
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                            color: isSelected ? AppColors.primary : Colors.black,
                                          ),
                                        ),
                                        Text(
                                          rideData['description'],
                                          style: TextStyle(
                                            fontSize: 14,
                                            color: isSelected ? AppColors.primary : Colors.grey,
                                          ),
                                        ),
                                        Text(
                                          rideData['time'],
                                          style: TextStyle(
                                            fontSize: 12,
                                            color: isSelected ? AppColors.primary : Colors.grey,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Text(
                                    '\$${rideData['price'].toStringAsFixed(2)}',
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: isSelected ? AppColors.primary : Colors.black,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  
                  const SizedBox(height: 20),
                  
                  // Preferences
                  const Text(
                    'Ride preferences',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: AppColors.primary,
                    ),
                  ),
                  const SizedBox(height: 16),
                  
                  Expanded(
                    flex: 1,
                    child: GridView.count(
                      crossAxisCount: 2,
                      crossAxisSpacing: 12,
                      mainAxisSpacing: 12,
                      childAspectRatio: 3,
                      children: [
                        _buildPreferenceTile('AC', Icons.ac_unit, 'ac'),
                        _buildPreferenceTile('Pet Friendly', Icons.pets, 'pet'),
                        _buildPreferenceTile('Trunk Space', Icons.luggage, 'trunk'),
                        _buildPreferenceTile('Condo Access', Icons.apartment, 'condo'),
                      ],
                    ),
                  ),
                  
                  const SizedBox(height: 20),
                  
                  // Confirm Button
                  AnimatedButton(
                    text: 'Confirm Ride',
                    onPressed: _confirmRide,
                    delay: 0,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildPreferenceTile(String title, IconData icon, String key) {
    final isSelected = _preferences[key]!;
    
    return BouncingWidget(
      onTap: () => _togglePreference(key),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.primary.withOpacity(0.1) : Colors.white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: isSelected ? AppColors.primary : Colors.grey[300]!,
            width: 1,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              color: isSelected ? AppColors.primary : Colors.grey,
              size: 16,
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                title,
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  color: isSelected ? AppColors.primary : Colors.grey,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }
}