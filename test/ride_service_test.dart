import 'package:flutter_test/flutter_test.dart';
import 'package:week_3_blabla_project/model/ride/locations.dart';
import 'package:week_3_blabla_project/model/ride_pref/ride_pref.dart';
import 'package:week_3_blabla_project/repository/mock/mock_rides_repository.dart';
import 'package:week_3_blabla_project/service/rides_service.dart';


/// TEST FAIL

void main(){

  // initialize the RidesService with the MockRidesRepository
  RidesService.initialize(MockRidesRepository());
  final ridesService = RidesService.instance;
  

  test('T1: Create a ride preference - from Battambang - to SiemReap - today - 1 passenger', () async {
    // - create ride pref

    final ridePreference = RidePreference(
        departure: Location(name: 'Battambang', country: Country.cambodia),
        arrival: Location(name: 'Siem Reap', country: Country.cambodia),
        departureDate: DateTime.now(),
        requestedSeats: 1,
      );

      // get rides based on the preferences
      final rides = ridesService.getRides(ridePreference, null);

      // assert that 5 rides are displayed
      expect(rides.length, equals(5));

      // check for a warning about a full ride
      final fullRides = rides.where((ride) => ride.availableSeats == 0);
      expect(fullRides.length, equals(1));
  }
  );

  test('T2: Create a ride preference - from Battambang - to SiemReap - today - 1 passenger - Pet Allowed', () async {

    final ridePreference = RidePreference(
        departure: Location(name: 'Battambang', country: Country.cambodia),
        arrival: Location(name: 'Siem Reap', country: Country.cambodia),
        departureDate: DateTime.now(),
        requestedSeats: 1,
      );


      // create a ride filter (pet allowed)
      final filter = RidesFilter(acceptPet: true); 

      // Get rides based on the preference and filter
      final rides = ridesService.getRides(ridePreference, filter);

      // Assert that only one ride matches the filter
      expect(rides.length, equals(1));

      // Assert the driver name is Mengtech
      expect(rides.first.driver.firstName, equals('Mengtech'));
  }
  );

}