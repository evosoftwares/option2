import '../models/saved_place.dart';

class SavedPlacesService {
  static final SavedPlacesService _instance = SavedPlacesService._internal();
  factory SavedPlacesService() => _instance;
  SavedPlacesService._internal();

  // Mock data for demonstration - in a real app this would come from a database
  final List<SavedPlace> _savedPlaces = [
    SavedPlace(
      id: '1',
      name: 'Casa',
      address: 'Rua das Flores, 123 - Centro',
      iconName: 'home',
      latitude: -23.5505,
      longitude: -46.6333,
    ),
    SavedPlace(
      id: '2',
      name: 'Trabalho',
      address: 'Av. Paulista, 1000 - Bela Vista',
      iconName: 'work',
      latitude: -23.5618,
      longitude: -46.6565,
    ),
  ];

  Future<List<SavedPlace>> getSavedPlaces() async {
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 500));
    return List.from(_savedPlaces);
  }

  Future<void> addSavedPlace(SavedPlace place) async {
    await Future.delayed(const Duration(milliseconds: 300));
    _savedPlaces.add(place);
  }

  Future<void> removeSavedPlace(String id) async {
    await Future.delayed(const Duration(milliseconds: 300));
    _savedPlaces.removeWhere((place) => place.id == id);
  }

  Future<void> updateSavedPlace(SavedPlace updatedPlace) async {
    await Future.delayed(const Duration(milliseconds: 300));
    final index = _savedPlaces.indexWhere((place) => place.id == updatedPlace.id);
    if (index != -1) {
      _savedPlaces[index] = updatedPlace;
    }
  }
}