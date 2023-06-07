import 'package:flutter/cupertino.dart';

class NotificationBadgeView extends StatelessWidget {
  final int totalNotifications;

  const NotificationBadgeView({super.key, required this.totalNotifications});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text("total notification = $totalNotifications"),
    );
  }
}
