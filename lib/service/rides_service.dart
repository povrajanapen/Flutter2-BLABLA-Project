import 'package:week_3_blabla_project/model/ride_pref/ride_pref.dart';
import 'package:week_3_blabla_project/repository/mock/mock_rides_repository.dart';
import 'package:week_3_blabla_project/repository/rides_repository.dart';
import '../dummy_data/dummy_data.dart';
import '../model/ride/ride.dart';

////
///   This service handles:
///   - The list of available rides
///
class RidesService {

  static List<Ride> availableRides = fakeRides;

  ///
  ///  Return the relevant rides, given the passenger preferences
  ///
  static List<Ride> getRidesFor(RidePreference preferences) {
 
    // For now, just a test
    return availableRides.where( (ride) => ride.departureLocation == preferences.departure && ride.arrivalLocation == preferences.arrival).toList();
  }

  // - ride service single pattern
  
  static RidesService? _instance;
  final RidesRepository repository;

  RidesService._internal(this.repository);


  /// - initialize the rides list that will be used in the service
  static void initialize(RidesRepository repository){
    _instance = RidesService._internal(repository);
  }

  static RidesService get instance{
    _instance ??= RidesService._internal(MockRidesRepository());
    return _instance!;
  }


  /// - returns a list of rides based on passenger preferences and optional filters
  List<Ride> getRides(RidePreference preference, RidesFilter? filter) {
    return repository.getRides(preference, filter);
  }
}


class RidesFilter{
  final bool acceptPet;

  RidesFilter({required this.acceptPet});
}