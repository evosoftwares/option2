import 'package:flutter/material.dart';
import '../../../core/routes/app_routes.dart';
import '../../../core/theme/colors.dart';
import '../../widgets/animated_button.dart';
import '../../widgets/bouncing_widget.dart';

class DocumentUploadScreen extends StatefulWidget {
  const DocumentUploadScreen({super.key});

  factory DocumentUploadScreen.fromArgs(Map<String, dynamic>? args) {
    return const DocumentUploadScreen();
  }

  @override
  State<DocumentUploadScreen> createState() => _DocumentUploadScreenState();
}

class _DocumentUploadScreenState extends State<DocumentUploadScreen> with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;
  
  bool _licenseUploaded = false;
  bool _insuranceUploaded = false;
  bool _registrationUploaded = false;

  @override
  void initState() {
    super.initState();
    
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1500),
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
      begin: const Offset(0, 0.3),
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

  void _uploadDocument(String type) {
    setState(() {
      switch (type) {
        case 'license':
          _licenseUploaded = true;
          break;
        case 'insurance':
          _insuranceUploaded = true;
          break;
        case 'registration':
          _registrationUploaded = true;
          break;
      }
    });
  }

  void _continueToDriverHome() {
    if (_licenseUploaded && _insuranceUploaded && _registrationUploaded) {
      Navigator.pushReplacementNamed(context, AppRoutes.driverHome);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          'Document Upload',
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
                    'Upload Required Documents',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: AppColors.primary,
                    ),
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'Please upload the following documents to complete your driver registration:',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey,
                    ),
                  ),
                  const SizedBox(height: 40),
                  Expanded(
                    child: Column(
                      children: [
                        _buildDocumentTile(
                          'Driver\'s License',
                          'Upload a clear photo of your driver\'s license',
                          Icons.credit_card,
                          _licenseUploaded,
                          () => _uploadDocument('license'),
                        ),
                        const SizedBox(height: 20),
                        _buildDocumentTile(
                          'Insurance',
                          'Upload your vehicle insurance document',
                          Icons.security,
                          _insuranceUploaded,
                          () => _uploadDocument('insurance'),
                        ),
                        const SizedBox(height: 20),
                        _buildDocumentTile(
                          'Vehicle Registration',
                          'Upload your vehicle registration document',
                          Icons.directions_car,
                          _registrationUploaded,
                          () => _uploadDocument('registration'),
                        ),
                        const Spacer(),
                        AnimatedButton(
                          text: 'Continue',
                          onPressed: (_licenseUploaded && _insuranceUploaded && _registrationUploaded)
                              ? _continueToDriverHome
                              : () {},
                          backgroundColor: (_licenseUploaded && _insuranceUploaded && _registrationUploaded)
                              ? AppColors.primary
                              : Colors.grey,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDocumentTile(
    String title,
    String subtitle,
    IconData icon,
    bool isUploaded,
    VoidCallback onTap,
  ) {
    return BouncingWidget(
      onTap: isUploaded ? () {} : onTap,
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: isUploaded ? AppColors.primary.withOpacity(0.1) : Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isUploaded ? AppColors.primary : Colors.grey[300]!,
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
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                color: isUploaded ? AppColors.primary : Colors.grey[100],
                borderRadius: BorderRadius.circular(30),
              ),
              child: Icon(
                isUploaded ? Icons.check : icon,
                color: isUploaded ? Colors.white : AppColors.primary,
                size: 30,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: isUploaded ? AppColors.primary : Colors.black,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    isUploaded ? 'Uploaded successfully' : subtitle,
                    style: TextStyle(
                      fontSize: 14,
                      color: isUploaded ? AppColors.primary : Colors.grey,
                    ),
                  ),
                ],
              ),
            ),
            if (!isUploaded)
              const Icon(
                Icons.camera_alt,
                color: AppColors.primary,
                size: 24,
              ),
          ],
        ),
      ),
    );
  }
}