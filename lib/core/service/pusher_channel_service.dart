import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:logic_app/core/di/injection.dart';
import 'package:logic_app/core/helper/helper.dart';
import 'package:pusher_channels_flutter/pusher_channels_flutter.dart';

class PusherChannelService {
  final pusher = di.get<PusherChannelsFlutter>();

  void initialPusherChannel({String? userId}) async {
    try {
      await pusher.init(
        apiKey: dotenv.env['PUSHER_APP_KEY'].toString(),
        cluster: dotenv.env['PUSHER_APP_CLUSTER'].toString(),
      );
      await pusher.connect();
      await pusher.subscribe(
        channelName: 'logic-channel-chat-$userId',
        onEvent: onEvent,
      );
    } catch (e) {
      logger.e(e);
    }
  }

  void disconnect() async {
    await pusher.disconnect();
  }

  void onEvent(PusherEvent event) {
    logger.i(event);
  }
}
