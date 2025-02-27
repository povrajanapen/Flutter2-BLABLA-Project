import 'package:flutter/material.dart';
import 'package:week_3_blabla_project/screens/ride_pref/widgets/ride_pref_tile.dart';
import 'package:week_3_blabla_project/screens/rides/rides_screen.dart';
import 'package:week_3_blabla_project/theme/theme.dart';
import 'package:week_3_blabla_project/utils/date_time_util.dart';
import 'package:week_3_blabla_project/widgets/actions/bla_button.dart';
import 'package:week_3_blabla_project/widgets/display/bla_divider.dart';
import 'package:week_3_blabla_project/widgets/inputs/bla_location_picker.dart';
import '../../../model/ride/locations.dart';
import '../../../model/ride_pref/ride_pref.dart';
 
///
/// A Ride Preference From is a view to select:
///   - A depcarture location
///   - An arrival location
///   - A date
///   - A number of seats
///
/// The form can be created with an existing RidePref (optional).
///
class RidePrefForm extends StatefulWidget {
  // The form can be created with an optional initial RidePref.
  final RidePref? initRidePref;

  const RidePrefForm({super.key, this.initRidePref});

  @override
  State<RidePrefForm> createState() => _RidePrefFormState();
}

class _RidePrefFormState extends State<RidePrefForm> {
  Location? departure;
  late DateTime departureDate;
  Location? arrival;
  late int requestedSeats;


  // ----------------------------------
  // Initialize the Form attributes
  // ----------------------------------

  @override
  void initState() {
    super.initState();
    final prefs = widget.initRidePref;

    if (prefs != null) {
      departure = prefs.departure;
      arrival = prefs.arrival;
      departureDate = prefs.departureDate;
      requestedSeats = prefs.requestedSeats;
      
    } else {
      departure = null;
      arrival = null;
      departureDate = DateTime.now(); 
      requestedSeats = 1;
    }
  }

  // ----------------------------------
  // Handle events
  // ----------------------------------

  // 1 - Handle the selection of the departure location
  void onDepartureSelected() async {
    // - Navigate to the location selection screen
    Location? selectedLocation = await Navigator.of(context).push<Location>(
      MaterialPageRoute(builder: (context) => BlaLocationPicker()),
    );

    // - Update the state with the selected location
    if (selectedLocation != null) {
      setState(() {
        departure = selectedLocation;
      });
    }
  }

  // 2 - Handle the selection of the arrival location
  void onArrivalSelected() async {
    // - Navigate to the location selection screen
    Location? selectedLocation = await Navigator.of(context).push<Location>(
      MaterialPageRoute(builder: (context) => BlaLocationPicker()),
    );
   
    setState(() {
      arrival = selectedLocation;
    });
  }

  // 3 - Handle the selection of the departure date
  onDepartureDateSelected(DateTime date) {
    setState(() {
      departureDate = date;
    });
  }

  // 4 - Handle the selection of the number of seats
  onRequestedSeatsSelected(int seats) {
    setState(() {
      requestedSeats = seats;
    });
  }

  // 5 - Handle the search button
  void onSearch() {
    // - Create a new RidePref with the current state
    if(departure != null && arrival != null) {
    RidePref newRidePref = RidePref(
      departure: departure!,
      arrival: arrival!,
      departureDate: departureDate,
      requestedSeats: requestedSeats,
    );

    // - Navigate to the rides screen
    Navigator.of(context).push(
      MaterialPageRoute(builder: (context) => RidesScreen(initialRidePref: newRidePref)),
    );
    }
  }

  void onSwitchLocations() {
    setState(() {
      Location? temp = departure;
      departure = arrival;
      arrival = temp;
    });
  }

  // ----------------------------------
  // Compute the widgets rendering
  // ----------------------------------
  String get departureName => departure?.name ?? "Leaving from";
  String get arrivalName => arrival?.name ?? "Going to";
  String get departureDateLabel => DateTimeUtils.formatDateTime(departureDate);
  String get requestedSeatsNumber => requestedSeats.toString();

  bool isSwitchEnabled() => departure != null && arrival != null;

  // ----------------------------------
  // Build the widgets
  // ----------------------------------

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(BlaSpacings.m),
      child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [ 

            // 1 - Departure location
            RidePrefTile(
              title: departureName,
              iconLeft: Icons.location_on,
              iconRight: isSwitchEnabled()? Icons.swap_vert : null,
              onRightIconTap: isSwitchEnabled()? onSwitchLocations : null,
              onPressed: onDepartureSelected,
            ),
            const BlaDivider(),
            // 2 - Arrival location
            
            RidePrefTile(
              title: arrivalName,
              iconLeft: Icons.location_on,
              onPressed: onArrivalSelected,
              ),
            const BlaDivider(),
            // 3 - Departure date
            RidePrefTile(
              title: departureDateLabel,
              iconLeft: Icons.calendar_month_rounded,
              isSelected: true,
              onPressed: () {
              },
            ),
            const BlaDivider(),

            // // 4 - Number of seats
            RidePrefTile(
              title: requestedSeatsNumber,
              iconLeft: Icons.person_outline,
              isSelected: true,
              onPressed: () {
              },
            ),

            // 5 - Search button
            BlaButton(text: "Search", onPressed: onSearch)

      ]),
    );
  }
}
