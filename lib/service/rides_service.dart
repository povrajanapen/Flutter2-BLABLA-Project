import 'package:week_3_blabla_project/model/ride_pref/ride_pref.dart';
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

   /// - singleton instance
  static final RidesService _instance = RidesService._internal();
  static late RidesRepository _repository;
  


  /// - private constructor, to prevent creating new instance from outside
  RidesService._internal();

  // - factory constructor, to return the same instance everytime
  factory RidesService(){
    return _instance;
  }

  /// - initialize the rides list that will be used in the service
  
  static void initialize(RidesRepository repository){
    _repository = repository;
  }

  /// - returns a list of rides based on passenger preferences and optional filters
  List<Ride> getRides(RidePreference preference, RidesFilter? filter) {
    return _repository.getRides(preference, filter);
  }
}


class RidesFilter{
  final bool acceptPet;

  RidesFilter({required this.acceptPet});
}