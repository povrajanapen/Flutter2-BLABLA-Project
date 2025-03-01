import 'package:flutter/material.dart';
import 'package:week_3_blabla_project/model/ride_pref/ride_pref.dart';
import 'package:week_3_blabla_project/theme/theme.dart';
import 'package:week_3_blabla_project/utils/date_time_util.dart';

class RidePrefBar extends StatefulWidget {
  final RidePref ridePref;
  
  
  const RidePrefBar({required this.ridePref,super.key});

  @override
  State<RidePrefBar> createState() => _RidePrefBarState();
}

class _RidePrefBarState extends State<RidePrefBar> {
  void onBack() {
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.all(BlaSpacings.s),
      decoration: BoxDecoration(
        color: BlaColors.backgroundAccent,
        borderRadius: BorderRadius.circular(BlaSpacings.radius),
      ),

      child: Row(
        children: [
          IconButton(
            icon: Icon(Icons.arrow_back_ios, color: BlaColors.iconNormal),
            onPressed: onBack,
          ),
          const SizedBox(width: BlaSpacings.s),
          RidePrefSummary(ridePref: widget.ridePref),
        ], 
      ),
    );
  }
}

class RidePrefSummary extends StatelessWidget {
  final RidePref ridePref;
  
  const RidePrefSummary({super.key, required this.ridePref});

  String get title => "${ridePref.departure.name} → ${ridePref.arrival.name}";
  String get subTitle =>
      "${DateTimeUtils.formatDateTime(ridePref.departureDate)},  ${ridePref.requestedSeats} passenger${ridePref.requestedSeats > 1 ? "s" : ""}";

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, 
          style: BlaTextStyles.body.copyWith(color: BlaColors.textNormal)),
        Text(subTitle, 
          style: BlaTextStyles.label.copyWith(color: BlaColors.textLight)),
      ],
    );
  }
}