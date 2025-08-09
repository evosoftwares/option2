import 'dart:math';
import '../models/driver.dart';

class DriverRepository {
  // TODO: Replace mock with real API service
  Future<List<Driver>> fetchAvailableDrivers({int limit = 10}) async {
    await Future.delayed(const Duration(seconds: 1));
    
    final random = Random();
    final names = ['João Silva', 'Maria Santos', 'Pedro Costa', 'Ana Oliveira', 'Carlos Ferreira'];
    final carModels = ['Honda Civic 2020', 'Toyota Corolla 2021', 'Volkswagen Jetta 2019', 'Nissan Sentra 2022'];
    
    return List.generate(limit, (i) {
      return Driver(
        id: 'driver_$i',
        name: names[random.nextInt(names.length)],
        carModel: carModels[random.nextInt(carModels.length)],
        rating: 4.0 + random.nextDouble(),
        price: 15.0 + random.nextDouble() * 20,
        eta: 2 + random.nextInt(8),
      );
    });
  }
}