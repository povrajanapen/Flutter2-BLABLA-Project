import 'package:week_3_blabla_project/model/ride/locations.dart';
import 'package:week_3_blabla_project/repository/locations_repository.dart';
import 'package:week_3_blabla_project/repository/mock/mock_locations_repository.dart';

import '../dummy_data/dummy_data.dart';

////
///   This service handles:
///   - The list of available rides
///
class LocationsService {

  static LocationsService? _instance;
  final LocationsRepository repository;

  LocationsService._internal(this.repository){}

  static void initialize(LocationsRepository repository){
    _instance = LocationsService._internal(repository);
  }

  static LocationsService get instance{
    _instance ??= LocationsService._internal(MockLocationsRepository());
    return _instance!;
  }

  List<Location> getLocations(){
    return repository.getLocations();
  }

  static const List<Location> availableLocations = fakeLocations; 
 
}
