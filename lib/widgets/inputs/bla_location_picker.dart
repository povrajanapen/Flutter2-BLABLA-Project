import 'package:flutter/material.dart';
import 'package:week_3_blabla_project/model/ride/locations.dart';
import 'package:week_3_blabla_project/service/locations_service.dart';
import 'package:week_3_blabla_project/theme/theme.dart';

//
// A full screen modal to pick a location
//

class BlaLocationPicker extends StatefulWidget {
  final Location? initialLocation;
  const BlaLocationPicker({
    required this.initialLocation,
    super.key});

  @override
  State<BlaLocationPicker> createState() => _BlaLocationPickerState();
}

class _BlaLocationPickerState extends State<BlaLocationPicker> {
  List<Location> filteredLocation = [];
  List<Location> allLocations = [];

  @override
  void initState() {
    super.initState();
    filteredLocation = [];
    allLocations = LocationsService.availableLocations;
  }

  void onBack() {
    Navigator.of(context).pop();
  }

  void onLocationSelect(Location location) {
    Navigator.of(context).pop(location);
  }

  // - search for a location
  void onSearch(String searchText) {
    setState(() {
      if (searchText.isEmpty) {
        filteredLocation = [];
      } else {
        filteredLocation = allLocations
            .where((location) => location.name.toLowerCase().contains(searchText.toLowerCase()))
            .toList();
      }
    });
  }

  // - get locations for a search text
  List<Location> getLocationsFor(String text) {
    return LocationsService.availableLocations
        .where((location) => location.name.toLowerCase().contains(text.toLowerCase()))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: 40),
        child: Column(
          children: [
            BlaSearch(
              onBack: onBack,
              onSearch: onSearch,
            ),
            if (filteredLocation.isNotEmpty)
              BlaLocationList(
                location: filteredLocation.first,
                onSelect: onLocationSelect,
              ),
          ],
        ),
      ),
    );
  }
}

//
// A list of locations display when input is focused
//

class BlaLocationList extends StatelessWidget {
  final Location location;
  final Function(Location location) onSelect;

  const BlaLocationList({
    required this.location,
    required this.onSelect,
    super.key});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(location.name),
      subtitle: Text(location.country.name),
      onTap: () => onSelect(location),
    );
  }
}

//
// The search bar with input ,and navigation back button, and clear button when input is focused
//

class BlaSearch extends StatefulWidget {
  final Function(String) onSearch;
  final VoidCallback onBack;

  const BlaSearch({
    required this.onSearch,
    required this.onBack,
    super.key,
  });

  @override
  State<BlaSearch> createState() => _BlaSearchState();
}

class _BlaSearchState extends State<BlaSearch> {
  final TextEditingController _controller = TextEditingController();
  final FocusNode _focusNode = FocusNode();

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(BlaSpacings.m),
      child: Row(
        children: [
          // - back button
          IconButton(
            icon: const Icon(Icons.arrow_back_ios),
            onPressed: widget.onBack,
          ),

          // - search input
          Expanded(
            child: TextField(
              controller: _controller,
              decoration: const InputDecoration(
                hintText: 'Search location',
              ),
              onChanged: widget.onSearch,
            ),
          ),

          // - clear button
          if (_controller.text.isNotEmpty)
            IconButton(
              icon: const Icon(Icons.clear),
              onPressed: () {
                _controller.clear();
                widget.onSearch('');
              },
            ),
        ],
      ),
    );
  }
}