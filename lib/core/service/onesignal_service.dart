import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';

class OnesignalService {
  // OnesignalService({required this.router});

  Future<void> initPlatformState() async {
    OneSignal.initialize(dotenv.env['ONESIGNAL_APP_ID'].toString());
    await OneSignal.Notifications.requestPermission(true);

    // OneSignal.Notifications.addClickListener((event) {
    //   logger.i(event.notification.additionalData);
    //   String route = event.notification.additionalData?['screen'];
    //   logger.i('Route: $route');
    //   if (route.isNotEmpty) {
    //     router.go(route);
    //   }
    // });
  }
}
