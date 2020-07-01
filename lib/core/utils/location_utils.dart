import 'package:geocoder/geocoder.dart';
import 'package:location/location.dart';

class LocationUtils {

  double latitude;
  double longitude;
  static LocationUtils instance = LocationUtils();

  void getLocation() async {
    Location location = new Location();

    var _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return;
      }
    }

    var _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return;
      }
    }

    var _locationData = await location.getLocation();
    latitude = _locationData.latitude;
    longitude = _locationData.longitude;
  }

  Future<String> getAddress() async {
    var addresses = await Geocoder.local.findAddressesFromCoordinates(Coordinates(
      latitude,
      longitude
    ));
    return addresses.first.addressLine;
  }
}