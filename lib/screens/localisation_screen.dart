import 'dart:async';

import 'package:call_me_app/core/theme/app_palette.dart';
import 'package:call_me_app/core/utils/show_toast.dart';
import 'package:call_me_app/core/widgets/custom_textfield.dart';
import 'package:call_me_app/viewmodel/localisation_provider.dart';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:go_router/go_router.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:toastification/toastification.dart';

class LocalisationScreen extends StatefulWidget {
  const LocalisationScreen({super.key});

  @override
  State<LocalisationScreen> createState() => _LocalisationScreenState();
}

class _LocalisationScreenState extends State<LocalisationScreen> {
  late GoogleMapController mapController;
  final numberController = TextEditingController();
  final pseudoController = TextEditingController();
  Position currentPosition = Position(
    latitude: 0,
    longitude: 0,
    timestamp: DateTime.now(),
    accuracy: 0,
    altitude: 0,
    heading: 0,
    speed: 0,
    speedAccuracy: 0,
    isMocked: false,
    altitudeAccuracy: 0,
    headingAccuracy: 0,
  );
  LatLng? selectedPosition;

  @override
  void initState() {
    super.initState();
    if (mounted) {
      Provider.of<LocalisationProvider>(context, listen: false).fetchLocations(
        onError: (error) {
          showToast(
              message: error, context: context, type: ToastificationType.error);
        },
      );
    }
    _getCurrentLocation();
  }

  Future<void> _getCurrentLocation() async {
    try {
      final position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
      setState(() {
        currentPosition = position;
      });

      mapController.animateCamera(
        CameraUpdate.newLatLng(
          LatLng(currentPosition.latitude, currentPosition.longitude),
        ),
      );
    } catch (e) {
      showToast(
        message: e.toString(),
        context: context,
        type: ToastificationType.error,
      );
    }
  }

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  void _onMapTap(LatLng position) {
    setState(() {
      selectedPosition = position;
    });

    _showAddLocationDialog();
  }

  void _showAddLocationDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(
            'Add Location',
            style: TextStyle(
                fontSize: 16, color: Theme.of(context).colorScheme.primary),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CustomTextfield(
                controller: numberController,
                hintText: 'Number',
                inputType: TextInputType.number,
              ),
              const SizedBox(height: 20),
              CustomTextfield(
                controller: pseudoController,
                hintText: 'Pseudo',
                inputType: TextInputType.text,
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                _clearForm();
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                if (numberController.text.isNotEmpty &&
                    pseudoController.text.isNotEmpty &&
                    selectedPosition != null) {
                  Provider.of<LocalisationProvider>(context, listen: false)
                      .addLocation(
                    latitude: selectedPosition!.latitude,
                    longitude: selectedPosition!.longitude,
                    number: int.parse(numberController.text),
                    pseudo: pseudoController.text,
                  );
                  context.pop();
                  _clearForm();
                } else {
                  showToast(
                    message: 'Please fill in all fields',
                    context: context,
                    type: ToastificationType.warning,
                  );
                }
              },
              child: const Text('Save'),
            ),
          ],
        );
      },
    );
  }

  void _clearForm() {
    numberController.clear();
    pseudoController.clear();
    selectedPosition = null;
  }

  Set<Marker> _buildMarkers() {
    final savedMarkers = Provider.of<LocalisationProvider>(context)
        .locations
        .map(
          (location) => Marker(
            markerId: MarkerId(location.id.toString()),
            position: LatLng(location.latitude, location.longitude),
            infoWindow: InfoWindow(title: location.pseudo),
          ),
        )
        .toSet();

    final currentMarker = Marker(
      markerId: const MarkerId('current'),
      position: LatLng(currentPosition.latitude, currentPosition.longitude),
    );

    return savedMarkers..add(currentMarker);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Your Best Locations',
          style: TextStyle(
              fontSize: 16,
              color: Theme.of(context).colorScheme.primary,
              fontWeight: FontWeight.w700),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: GoogleMap(
              onMapCreated: _onMapCreated,
              initialCameraPosition: CameraPosition(
                target:
                    LatLng(currentPosition.latitude, currentPosition.longitude),
                zoom: 15,
              ),
              markers: _buildMarkers(),
              onTap: _onMapTap,
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Expanded(
            child: Consumer<LocalisationProvider>(
              builder: (context, provider, child) {
                return ListView.separated(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  separatorBuilder: (context, index) => const SizedBox(
                    height: 10,
                  ),
                  itemCount: provider.locations.length,
                  itemBuilder: (context, index) {
                    final location = provider.locations[index];
                    return ListTile(
                      contentPadding:
                          const EdgeInsets.symmetric(horizontal: 10),
                      shape: BeveledRectangleBorder(
                          borderRadius: BorderRadius.circular(3),
                          side: const BorderSide(
                              color: AppPalette.lightGrey, width: 0.1)),
                      title: Text(
                        location.pseudo,
                        style: const TextStyle(fontWeight: FontWeight.w700),
                      ),
                      subtitle: Text(
                        'Latitude: ${location.latitude}, Longitude: ${location.longitude}',
                        style: const TextStyle(
                            fontSize: 12, color: AppPalette.lightGrey),
                      ),
                      leading: IconButton(
                        icon: Icon(
                          Icons.place,
                          color: AppPalette.blue,
                        ),
                        onPressed: () {
                          mapController.animateCamera(
                            CameraUpdate.newLatLng(
                              LatLng(location.latitude, location.longitude),
                            ),
                          );
                        },
                      ),
                      trailing: IconButton(
                        icon: const Icon(Icons.delete, color: Colors.red),
                        onPressed: () async {
                          final res = await provider.deleteLocation(
                              pseudo: location.pseudo);
                          showToast(
                              message: res,
                              context: context,
                              type: ToastificationType.success);
                        },
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
