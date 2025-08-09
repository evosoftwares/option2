import 'package:flutter/material.dart';
import '../../presentation/screens/splash_screen.dart';
import '../../presentation/screens/login_screen.dart';
import '../../presentation/screens/role_selection_screen.dart';
import '../../presentation/screens/passenger/passenger_home_screen.dart';
import '../../presentation/screens/driver/document_upload_screen.dart';
import '../../presentation/screens/passenger/search_screen.dart';
import '../../presentation/screens/passenger/ride_options_screen.dart';
import '../../presentation/screens/driver/driver_selection_screen.dart';
import '../../presentation/screens/passenger/waiting_for_driver_screen.dart';
import '../../presentation/screens/passenger/driver_arriving_screen.dart';
import '../../presentation/screens/passenger/driver_en_route_screen.dart';
import '../../presentation/screens/passenger/on_trip_screen.dart';
import '../../presentation/screens/passenger/rating_screen.dart';
import '../../presentation/screens/driver/driver_home_screen.dart';
import '../../presentation/screens/driver/accept_trip_screen.dart';
import '../../presentation/screens/driver/pickup_passenger_screen.dart';
import '../../presentation/screens/driver/en_route_to_destination_screen.dart';
import '../../presentation/screens/driver/rate_passenger_screen.dart';
import '../../presentation/screens/wallet_screen.dart';
import '../../presentation/screens/menu_screen.dart';
import '../../presentation/screens/trips_history_screen.dart';
import '../../presentation/screens/settings_screen.dart';
import '../../presentation/screens/home_screen.dart';

class AppRoutes {
  static const String splash = '/';
  static const String login = '/login';
  static const String role = '/role';
  static const String roleSelection = '/role';
  static const String documentUpload = '/driver/docs';
  static const String passengerHome = '/passenger-home';
  static const String driverHome = '/driver-home';
  static const String driverDocs = '/driver/docs';
  static const String search = '/search';
  static const String rideOptions = '/ride-options';
  static const String driverSelection = '/driver-selection';
  static const String waitingForDriver = '/waiting-for-driver';
  static const String driverArriving = '/driver-arriving';
  static const String driverEnRoute = '/driver-en-route';
  static const String onTrip = '/on-trip';
  static const String rating = '/rating';
  static const String acceptTrip = '/accept-trip';
  static const String pickupPassenger = '/pickup-passenger';
  static const String enRouteToDestination = '/en-route-to-destination';
  static const String ratePassenger = '/rate-passenger';
  static const String wallet = '/wallet';
  static const String menu = '/menu';
  static const String tripsHistory = '/trips-history';
  static const String settings = '/settings';

  static Route<dynamic>? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => const SplashScreen());
      case '/login':
        return MaterialPageRoute(builder: (_) => const LoginScreen());
      case '/role':
        return MaterialPageRoute(builder: (_) => const RoleSelectionScreen());
      case '/passenger-home':
        return MaterialPageRoute(builder: (_) => const PassengerHomeScreen());
      case '/driver-home':
        return MaterialPageRoute(builder: (_) => const DriverHomeScreen());
      case '/driver/docs':
        final args = settings.arguments as Map<String, dynamic>?;
        return MaterialPageRoute(builder: (_) => DocumentUploadScreen.fromArgs(args));
      case '/search':
        return MaterialPageRoute(builder: (_) => const SearchScreen());
      case '/ride-options':
        return MaterialPageRoute(builder: (_) => const RideOptionsScreen());
      case '/driver-selection':
        return MaterialPageRoute(builder: (_) => const DriverSelectionScreen());
      case '/waiting-for-driver':
        return MaterialPageRoute(builder: (_) => const WaitingForDriverScreen());
      case '/driver-arriving':
        return MaterialPageRoute(builder: (_) => const DriverArrivingScreen());
      case '/driver-en-route':
        return MaterialPageRoute(builder: (_) => const DriverEnRouteScreen());
      case '/on-trip':
        return MaterialPageRoute(builder: (_) => const OnTripScreen());
      case '/rating':
        return MaterialPageRoute(builder: (_) => const RatingScreen());
      case '/accept-trip':
        return MaterialPageRoute(builder: (_) => const AcceptTripScreen());
      case '/pickup-passenger':
        return MaterialPageRoute(builder: (_) => const PickupPassengerScreen());
      case '/en-route-to-destination':
        return MaterialPageRoute(builder: (_) => const EnRouteToDestinationScreen());
      case '/rate-passenger':
        return MaterialPageRoute(builder: (_) => const RatePassengerScreen());
      case '/wallet':
        return MaterialPageRoute(builder: (_) => const WalletScreen());
      case '/menu':
        final args = settings.arguments as Map<String, dynamic>?;
        return MaterialPageRoute(builder: (_) {
          final isDriver = args?['isDriver'] as bool? ?? false;
          return MenuScreen(isDriver: isDriver);
        });
      case '/trips-history':
        return MaterialPageRoute(builder: (_) => const TripsHistoryScreen());
      case '/settings':
        return MaterialPageRoute(builder: (_) => const SettingsScreen());
      default:
        return null;
    }
  }
}