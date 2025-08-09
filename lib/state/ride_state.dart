import 'package:flutter/foundation.dart';
import '../data/models/driver.dart';
import '../data/repositories/driver_repository.dart';

class RideState extends ChangeNotifier {
  final DriverRepository _driverRepository = DriverRepository();
  
  List<Driver> _availableDrivers = [];
  Driver? _selectedDriver;
  String _rideStatus = 'idle'; // idle, searching, found, accepted, inProgress, completed
  String _origin = '';
  String _destination = '';
  List<String> _stops = [];
  String _selectedRideType = 'standard';
  Map<String, bool> _ridePreferences = {
    'ac': false,
    'pet': false,
    'trunk': false,
    'condo': false,
  };
  double _estimatedPrice = 0.0;
  int _estimatedTime = 0;

  // Getters
  List<Driver> get availableDrivers => _availableDrivers;
  Driver? get selectedDriver => _selectedDriver;
  String get rideStatus => _rideStatus;
  String get origin => _origin;
  String get destination => _destination;
  List<String> get stops => _stops;
  String get selectedRideType => _selectedRideType;
  Map<String, bool> get ridePreferences => _ridePreferences;
  double get estimatedPrice => _estimatedPrice;
  int get estimatedTime => _estimatedTime;

  // Methods
  Future<void> fetchAvailableDrivers() async {
    try {
      _availableDrivers = await _driverRepository.fetchAvailableDrivers();
      notifyListeners();
    } catch (e) {
      debugPrint('Error fetching drivers: $e');
    }
  }

  void setOrigin(String origin) {
    _origin = origin;
    notifyListeners();
  }

  void setDestination(String destination) {
    _destination = destination;
    _calculateEstimates();
    notifyListeners();
  }

  void addStop(String stop) {
    _stops.add(stop);
    _calculateEstimates();
    notifyListeners();
  }

  void removeStop(int index) {
    if (index >= 0 && index < _stops.length) {
      _stops.removeAt(index);
      _calculateEstimates();
      notifyListeners();
    }
  }

  void setRideType(String rideType) {
    _selectedRideType = rideType;
    _calculateEstimates();
    notifyListeners();
  }

  void updateRidePreference(String key, bool value) {
    _ridePreferences[key] = value;
    _calculateEstimates();
    notifyListeners();
  }

  void selectDriver(Driver driver) {
    _selectedDriver = driver;
    _rideStatus = 'found';
    notifyListeners();
  }

  void acceptRide() {
    _rideStatus = 'accepted';
    notifyListeners();
  }

  void startRide() {
    _rideStatus = 'inProgress';
    notifyListeners();
  }

  void completeRide() {
    _rideStatus = 'completed';
    notifyListeners();
  }

  void resetRide() {
    _selectedDriver = null;
    _rideStatus = 'idle';
    _origin = '';
    _destination = '';
    _stops.clear();
    _selectedRideType = 'standard';
    _ridePreferences = {
      'ac': false,
      'pet': false,
      'trunk': false,
      'condo': false,
    };
    _estimatedPrice = 0.0;
    _estimatedTime = 0;
    notifyListeners();
  }

  void _calculateEstimates() {
    // Mock calculation based on distance, ride type, and preferences
    double basePrice = 10.0;
    int baseTime = 15;

    // Add price for stops
    basePrice += _stops.length * 2.0;
    baseTime += _stops.length * 5;

    // Add price for ride type
    switch (_selectedRideType) {
      case 'premium':
        basePrice *= 1.5;
        break;
      case 'xl':
        basePrice *= 1.3;
        break;
      case 'pool':
        basePrice *= 0.8;
        break;
    }

    // Add price for preferences
    if (_ridePreferences['ac'] == true) basePrice += 2.0;
    if (_ridePreferences['pet'] == true) basePrice += 3.0;
    if (_ridePreferences['trunk'] == true) basePrice += 1.0;
    if (_ridePreferences['condo'] == true) basePrice += 5.0;

    _estimatedPrice = basePrice;
    _estimatedTime = baseTime;
  }
}