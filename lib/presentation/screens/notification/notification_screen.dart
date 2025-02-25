import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:logic_app/core/constants/app_space.dart';
import 'package:logic_app/core/helper/helper.dart';
import 'package:logic_app/data/models/notification_model.dart';
import 'package:logic_app/presentation/screens/notification/notification_cubit.dart';
import 'package:logic_app/presentation/screens/notification/notification_state.dart';
import 'package:logic_app/presentation/widgets/app_bar_widget.dart';
import 'package:logic_app/presentation/widgets/catch_image_network_widget.dart';
import 'package:logic_app/presentation/widgets/text_widget.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});
  static const routeName = 'notification';
  static const routePath = '/notification';
  @override
  NotificationScreenState createState() => NotificationScreenState();
}

class NotificationScreenState extends State<NotificationScreen> {
  final screenCubit = NotificationCubit();

  // Dummy notifications list
  List<NotificationModel> notifications = [
    NotificationModel(
      title: "Order success",
      message: "Your order has been placed successfully.",
      imageUrl:
          "https://media.istockphoto.com/id/1437816897/photo/business-woman-manager-or-human-resources-portrait-for-career-success-company-we-are-hiring.jpg?s=612x612&w=0&k=20&c=tyLvtzutRh22j9GqSGI33Z4HpIwv9vL_MZw_xOE19NQ=",
      timestamp: DateTime.now(), // Today
    ),
    NotificationModel(
      title: "New Promotion",
      message: "Check out our new deals for today!",
      imageUrl:
          "https://media.istockphoto.com/id/1437816897/photo/business-woman-manager-or-human-resources-portrait-for-career-success-company-we-are-hiring.jpg?s=612x612&w=0&k=20&c=tyLvtzutRh22j9GqSGI33Z4HpIwv9vL_MZw_xOE19NQ=",
      timestamp: DateTime.now().subtract(Duration(hours: 3)), // Today
    ),
    NotificationModel(
      title: "Payment Received",
      message: "Your payment was successfully processed.",
      imageUrl:
          "https://media.istockphoto.com/id/1437816897/photo/business-woman-manager-or-human-resources-portrait-for-career-success-company-we-are-hiring.jpg?s=612x612&w=0&k=20&c=tyLvtzutRh22j9GqSGI33Z4HpIwv9vL_MZw_xOE19NQ=",
      timestamp: DateTime.now().subtract(Duration(days: 1)), // Yesterday
    ),
  ];

  // Function to group notifications
  Map<String, List<NotificationModel>> groupNotifications(
      List<NotificationModel> notifications) {
    final today = DateTime.now();
    final yesterday = today.subtract(Duration(days: 1));

    return {
      "Today":
          notifications.where((n) => isSameDay(n.timestamp, today)).toList(),
      "Yesterday": notifications
          .where((n) => isSameDay(n.timestamp, yesterday))
          .toList(),
    };
  }

// Check if two dates are the same day
  bool isSameDay(DateTime date1, DateTime date2) {
    return date1.year == date2.year &&
        date1.month == date2.month &&
        date1.day == date2.day;
  }

  @override
  void initState() {
    screenCubit.loadInitialData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppbarWidget(title: 'notifications'.tr),
      body: BlocConsumer<NotificationCubit, NotificationState>(
        bloc: screenCubit,
        listener: (BuildContext context, NotificationState state) {
          if (state.error != null) {
            // TODO your code here
          }
        },
        builder: (BuildContext context, NotificationState state) {
          if (state.isLoading) {
            return centerLoading();
          }

          return buildBody(state);
        },
      ),
    );
  }

  Widget buildBody(NotificationState state) {
    Map<String, List<NotificationModel>> groupedNotifications =
        groupNotifications(notifications);

    return ListView(
      padding: EdgeInsets.all(appPedding.scale),
      children: groupedNotifications.entries.expand((entry) {
        return [
          Padding(
            padding: EdgeInsets.symmetric(vertical: 8.0),
            child: TextWidget(
                text: entry.key, // "Today" or "Yesterday"
                fontWeight: FontWeight.bold,
                fontSize: 18),
          ),
          ...entry.value.map((notification) {
            return ListTile(
              contentPadding: EdgeInsets.zero,
              onTap: () {
                // TODO: Handle tap
              },
              leading: CatchImageNetworkWidget(
                imageUrl: notification.imageUrl,
                blurHash: 'LEHV6nWB2yk8pyo0adR*.7kCMdnj',
                width: 40.scale,
                height: 40.scale,
                borderRadius: BorderRadius.circular(100.scale),
                boxFit: BoxFit.cover,
              ),
              title: TextWidget(text: notification.title),
              subtitle: TextWidget(text: notification.message),
              trailing: TextWidget(
                  text: DateFormat('hh:mm a')
                      .format(notification.timestamp)), // Format time
            );
          }).toList()
        ];
      }).toList(),
    );
  }
}
