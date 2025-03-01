import 'package:flutter/material.dart';
import 'package:week_3_blabla_project/model/ride/ride.dart';
import 'package:week_3_blabla_project/theme/theme.dart';
import 'package:week_3_blabla_project/utils/date_time_util.dart';

class RidePrefCard extends StatelessWidget {
  final Ride ride;
  final VoidCallback onPressed;
  
  const RidePrefCard({super.key, required this.ride, required this.onPressed});

  String get departure => "Departure: ${ride.departureLocation.name}";
  String get arrival => "Arrival: ${ride.arrivalLocation.name}";
  String get date => "Time: ${DateTimeUtils.formatTime(ride.departureDate)}";
  String get price => "Price: ${ride.pricePerSeat}";

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Card(
        child: ListTile(
          title: Text(departure,
            style: BlaTextStyles.label.copyWith(color: BlaColors.textNormal),),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(arrival,
                style: BlaTextStyles.label.copyWith(color: BlaColors.textNormal),),
              Text(date,
                style: BlaTextStyles.label.copyWith(color: BlaColors.textNormal),),
              Text(price,
                style: BlaTextStyles.label.copyWith(color: BlaColors.textNormal),),
            ],
          ),
        ),
        ),
    );
  }
}