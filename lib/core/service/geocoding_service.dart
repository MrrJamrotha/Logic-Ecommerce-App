import 'package:geocoding/geocoding.dart';

class GeocodingService {
  Future<String> getAddressFromCoordinates(
    double latitude,
    double longitude,
  ) async {
    try {
      var placemarks = await placemarkFromCoordinates(latitude, longitude);
      if (placemarks.isNotEmpty) {
        Placemark place = placemarks.first;
        return '${place.street}, ${place.locality}, ${place.postalCode}, ${place.country}';
      } else {
        return 'No address found';
      }
    } catch (e) {
      throw Exception(e);
    }
  }
}
