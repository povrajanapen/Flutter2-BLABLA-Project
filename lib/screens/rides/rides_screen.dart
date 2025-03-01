import 'package:flutter/material.dart';
import 'package:week_3_blabla_project/model/ride/ride.dart';
import 'package:week_3_blabla_project/model/ride_pref/ride_pref.dart';
import 'package:week_3_blabla_project/screens/rides/widgets/ride_pref_bar.dart';
import 'package:week_3_blabla_project/screens/rides/widgets/ride_pref_card.dart';
import 'package:week_3_blabla_project/service/rides_service.dart';
import 'package:week_3_blabla_project/theme/theme.dart';

class RidesScreen extends StatefulWidget {

  final RidePref initialRidePref;
  
  const RidesScreen({
    required this.initialRidePref,
    super.key});

  @override
  State<RidesScreen> createState() => _RidesScreenState();
}

class _RidesScreenState extends State<RidesScreen> {
  List <Ride> get matchingRides => 
    RidesService.getRidesFor(widget.initialRidePref);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(
          left: BlaSpacings.m, right: BlaSpacings.m, top: BlaSpacings.s),
        child: Column(
          children: [
            // - search bar header
            RidePrefBar(
              ridePref: widget.initialRidePref,
            ),

            // - list of matching rides
            Expanded(
              child: ListView.builder(
                itemCount: matchingRides.length,
                itemBuilder: (context, index) {
                  final ride = matchingRides[index];
                  return RidePrefCard(
                    ride: ride,
                    onPressed: () {},
                  );
                },
              ),
            ),
          ],
        ),
    ),
    );
  }
}