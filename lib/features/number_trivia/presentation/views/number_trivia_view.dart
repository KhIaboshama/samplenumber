import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:samplenumber/features/number_trivia/presentation/views/notification_badge.dart';
import 'package:sizer/sizer.dart';

import '../../../../core/model/push_notification.dart';
import '../bloc/number_trivia_bloc.dart';

class NumberTriviaView extends StatefulWidget {
  const NumberTriviaView({Key? key}) : super(key: key);

  @override
  State<NumberTriviaView> createState() => _NumberTriviaViewState();
}

class _NumberTriviaViewState extends State<NumberTriviaView> {
  late final FirebaseMessaging _messaging;
  late int _totalNotifications;
  PushNotification? _notificationInfo;
  String header = 'Starting search';
  TextEditingController controller = TextEditingController();
  bool isLoading = false;

  @override
  void initState() {
    _totalNotifications = 0;
    registerNotification();
    // For handling notification when the app is in background
    // but not terminated
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      PushNotification notification = PushNotification(
        title: message.notification?.title,
        body: message.notification?.body,
        dataTitle: message.data['title'],
        dataBody: message.data['body'],
      );
      setState(() {
        _notificationInfo = notification;
        _totalNotifications++;
      });
    });
    checkForInitialMessage();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<NumberTriviaBloc, NumberTriviaState>(
      listener: (context, state) {
        setState(() {
          if (state is NumberTriviaInitialState) {
            isLoading = false;
            header = 'Starting search';
          } else if (state is NumberTriviaLoadingState) {
            isLoading = true;
          } else if (state is NumberTriviaLoadedState) {
            isLoading = false;
            header = (state).numberTrivia.description;
          } else if (state is NumberTriviaErrorState) {
            isLoading = false;
            header = (state).message;
          }
        });
      },
      child: Scaffold(
          resizeToAvoidBottomInset: true,
          appBar: AppBar(
            title: const Text('Number trivia'),
          ),
          body: SingleChildScrollView(
            child: Column(
              children: [
                _notificationInfo != null
                    ? Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'TITLE: ${_notificationInfo!.dataTitle ?? _notificationInfo!.title}',
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16.0,
                            ),
                          ),
                          const SizedBox(height: 8.0),
                          Text(
                            'BODY: ${_notificationInfo!.dataBody ?? _notificationInfo!.body}',
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16.0,
                            ),
                          ),
                          Text(
                            'number: $_totalNotifications',
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16.0,
                            ),
                          ),
                        ],
                      )
                    : Container(),
                Container(
                  margin: EdgeInsetsDirectional.only(top: 20.h),
                  child: getHeaderWidget(),
                ),
                Container(
                  margin: EdgeInsetsDirectional.only(
                      top: 10.h, start: 5.w, end: 5.w),
                  child: TextField(
                    controller: controller,
                    decoration: const InputDecoration(hintText: 'Input number'),
                  ),
                ),
                Container(
                  alignment: Alignment.topCenter,
                  margin: EdgeInsetsDirectional.only(top: 5.h),
                  child: Row(
                    children: [
                      Expanded(
                        child: Container(
                          margin:
                              EdgeInsetsDirectional.only(start: 5.w, end: 2.w),
                          child: TextButton(
                            onPressed: () {
                              context.read<NumberTriviaBloc>().add(
                                  GetConcreteNumberEvent(
                                      number: controller.text));
                            },
                            child: const Text('search'),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          margin:
                              EdgeInsetsDirectional.only(start: 2.w, end: 5.w),
                          child: TextButton(
                            onPressed: () {
                              context
                                  .read<NumberTriviaBloc>()
                                  .add(GetRandomNumberEvent());
                            },
                            child: const Text('Random Number'),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          )),
    );
  }

  Widget getHeaderWidget() {
    if (isLoading) {
      return const Center(child: CircularProgressIndicator());
    } else {
      return Center(child: Text(header));
    }
  }

  void registerNotification() async {
    await Firebase.initializeApp();
    _messaging = FirebaseMessaging.instance;
    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

    NotificationSettings settings = await _messaging.requestPermission(
        alert: true, badge: true, provisional: false, sound: true);
    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      print('grand permission');
      FirebaseMessaging.onMessage.listen((RemoteMessage message) {
        PushNotification notification = PushNotification(
          title: message.notification?.title,
          body: message.notification?.body,
          dataTitle: message.data['title'],
          dataBody: message.data['body'],
        );
        setState(() {
          _notificationInfo = notification;
          _totalNotifications++;
        });
        if (_notificationInfo != null) {
          showSimpleNotification(
            Text(_notificationInfo!.title!),
            leading:
                NotificationBadgeView(totalNotifications: _totalNotifications),
            subtitle: Text(_notificationInfo!.body!),
            background: Colors.cyan.shade700,
            duration: const Duration(seconds: 2),
          );
        }
      });
    } else {
      print('not grand permission');
    }
  }

  // For handling notification when the app is in terminated state
  checkForInitialMessage() async {
    await Firebase.initializeApp();
    RemoteMessage? initialMessage =
        await FirebaseMessaging.instance.getInitialMessage();

    if (initialMessage != null) {
      PushNotification notification = PushNotification(
        title: initialMessage.notification?.title,
        body: initialMessage.notification?.body,
      );
      setState(() {
        _notificationInfo = notification;
        _totalNotifications++;
      });
    }
  }
}

Future _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  print("Handling a background message: ${message.notification?.title}");
}
