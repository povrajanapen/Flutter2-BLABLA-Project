import 'package:week_3_blabla_project/model/ride/locations.dart';
import 'package:week_3_blabla_project/model/ride/ride.dart';
import 'package:week_3_blabla_project/model/ride_pref/ride_pref.dart';
import 'package:week_3_blabla_project/model/user/user.dart';
import 'package:week_3_blabla_project/repository/rides_repository.dart';
import 'package:week_3_blabla_project/service/rides_service.dart';

class MockRidesRepository extends RidesRepository{
  DateTime now = DateTime.now();
  late Ride ride1, ride2, ride3, ride4, ride5;

  MockRidesRepository() {
    ride1 = Ride(
      departureLocation: Location(name: 'Battambang', country: Country.cambodia),
      departureDate: DateTime(now.year, now.month, now.day, 5, 30),
      arrivalLocation: Location(name: 'Siem Reap', country: Country.cambodia),
      arrivalDateTime: DateTime(now.year, now.month, now.day, 7, 30),
      driver: User(
        firstName: 'Kannika',
        lastName: '',
        email: 'kannika@example.com',
        phone: '123456789',
        profilePicture: '',
        verifiedProfile: true,
      ),
      availableSeats: 2,
      pricePerSeat: 10.0,
      acceptPet: false,

    );

     ride2 = Ride(
      departureLocation: Location(name: 'Battambang', country: Country.cambodia),
      departureDate: DateTime(now.year, now.month, now.day, 20, 00),
      arrivalLocation: Location(name: 'Siem Reap', country: Country.cambodia),
      arrivalDateTime: DateTime(now.year, now.month, now.day, 22, 00),
      driver: User(
        firstName: 'Chaylim',
        lastName: '',
        email: 'chaylim@example.com',
        phone: '123456789',
        profilePicture: '',
        verifiedProfile: true,
      ),
      availableSeats: 0,
      pricePerSeat: 10.0,
      acceptPet: false,
    );

    ride3 = Ride(
      departureLocation: Location(name: 'Battambang', country: Country.cambodia),
      departureDate: DateTime(now.year, now.month, now.day, 5, 00),
      arrivalLocation: Location(name: 'Siem Reap', country: Country.cambodia),
      arrivalDateTime: DateTime(now.year, now.month, now.day, 8, 00),
      driver: User(
        firstName: 'Mengtech',
        lastName: '',
        email: 'mengtech@example.com',
        phone: '123456789',
        profilePicture: '',
        verifiedProfile: true,
      ),
      availableSeats: 1,
      pricePerSeat: 10.0,
      acceptPet: true,
    );

    ride4 = Ride(
      departureLocation: Location(name: 'Battambang', country: Country.cambodia),
      departureDate: DateTime(now.year, now.month, now.day, 20, 00),
      arrivalLocation: Location(name: 'Siem Reap', country: Country.cambodia),
      arrivalDateTime: DateTime(now.year, now.month, now.day, 22, 00),
      driver: User(
        firstName: 'Limhao',
        lastName: '',
        email: 'limhao@example.com',
        phone: '123456789',
        profilePicture: '',
        verifiedProfile: true,
      ),
      availableSeats: 2,
      pricePerSeat: 10.0,
      acceptPet: false,
    );

    ride5 = Ride(
      departureLocation: Location(name: 'Battambang', country: Country.cambodia),
      departureDate: DateTime(now.year, now.month, now.day, 5, 00),
      arrivalLocation: Location(name: 'Siem Reap', country: Country.cambodia),
      arrivalDateTime: DateTime(now.year, now.month, now.day, 8, 00),
      driver: User(
        firstName: 'Sovanda',
        lastName: '',
        email: 'sovanda@example.com',
        phone: '123456789',
        profilePicture: '',
        verifiedProfile: true,
      ),
      availableSeats: 1,
      pricePerSeat: 10.0,
      acceptPet: false,
    );
  }

  @override
  List<Ride> getRides(RidePreference preference, RidesFilter? filter) {
    List<Ride> rides = [ride1, ride2, ride3, ride4, ride5];
    return rides.where((ride) =>
       ride.departureLocation.name == preference.departure.name &&
          ride.arrivalLocation.name == preference.arrival.name &&
          ride.departureDate.isAfter(preference.departureDate)
          && ride.availableSeats >= preference.requestedSeats
          && (filter == null || filter.acceptPet == ride.filter?.acceptPet)
    ).toList();
  }
}