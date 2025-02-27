import 'package:audio_waveforms/audio_waveforms.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logic_app/core/constants/app_colors.dart';
import 'package:logic_app/core/constants/app_enum.dart';
import 'package:logic_app/core/constants/app_icons.dart';
import 'package:logic_app/core/helper/helper.dart';
import 'package:logic_app/presentation/screens/chat_room/chat_room_cubit.dart';
import 'package:logic_app/presentation/screens/chat_room/chat_room_state.dart';
import 'package:logic_app/presentation/screens/chat_room/components/voice_message_bubble.dart';
import 'package:logic_app/presentation/widgets/icon_widget.dart';
import 'package:logic_app/presentation/widgets/text_widget.dart';

class ChatRoomScreen extends StatefulWidget {
  static const routeName = 'chat_room';
  const ChatRoomScreen({super.key});

  @override
  ChatRoomScreenState createState() => ChatRoomScreenState();
}

class ChatRoomScreenState extends State<ChatRoomScreen>
    with SingleTickerProviderStateMixin {
  final screenCubit = ChatRoomCubit();

  late AnimationController _animationController;
  late Animation<Offset> _slideAnimation;

  final _pathValue = ValueNotifier<String>("");
  final _isVisible = ValueNotifier<bool>(false);

  final scrollController = ScrollController();
  final focusNode = FocusNode();

  final _isCollapsed = ValueNotifier<bool>(false);
  final _isSend = ValueNotifier<bool>(false);
  final _messageTextController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  String? recordedFilePath;
  final RecorderController recorderController = RecorderController();

  @override
  void initState() {
    // Initialize the AnimationController
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 200), // Duration of the slide animation
    );

    // Define the slide animation (slide from bottom to top)
    _slideAnimation = Tween<Offset>(
      begin: Offset(0, 1), // Start off-screen (bottom)
      end: Offset(0, 0), // End on-screen
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ));

    screenCubit.checkPermissions();
    super.initState();
  }

  @override
  void dispose() {
    recorderController.dispose();
    _animationController.dispose();

    super.dispose();
  }

  Future<void> onSubmitTextMessage() async {
    if (_formKey.currentState!.validate()) {
      // screenCubit.sendMessage(_messageTextController.text);
      // _messageTextController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(),
      body: BlocConsumer<ChatRoomCubit, ChatRoomState>(
        bloc: screenCubit,
        listener: (BuildContext context, ChatRoomState state) {
          if (state.error != null) {
            // TODO your code here
          }
        },
        builder: (BuildContext context, ChatRoomState state) {
          if (state.isLoading) {
            return centerLoading();
          }

          return buildBody(state);
        },
      ),
    );
  }

  Widget buildBody(ChatRoomState state) {
    return Column(
      children: [
        Expanded(
          child: GestureDetector(
            onTap: () {
              _isCollapsed.value = false;
              FocusScope.of(context).unfocus();
            },
            child: Align(
              alignment: Alignment.topCenter,
              child: ListView.separated(
                reverse: true,
                shrinkWrap: true,
                padding: EdgeInsets.all(16.scale),
                controller: scrollController,
                itemBuilder: (context, index) {
                  return VoiceMessageBubble(
                    url:
                        'https://codeskulptor-demos.commondatastorage.googleapis.com/pang/paza-moduless.mp3',
                    timestamp: '14:30',
                    isRead: false,
                    type: BubbleType.sendBubble,
                  );
                  // return LocationMessageBubble(
                  //   lat: 11.5564,
                  //   long: 104.9282,
                  //   timestamp: '15:30',
                  //   type: BubbleType.sendBubble,
                  //   isRead: true,
                  // );
                  // return PictureMessageBubble(
                  //   records: [
                  //     {
                  //       'imageUrl':
                  //           'https://thumbs.dreamstime.com/b/chameleon-full-body-frame-shot-colorful-aligned-right-blue-background-ai-created-content-chameleon-full-body-frame-323142324.jpg',
                  //       'blurHash': 'LGF5?xYk^6#M@-5c,1J5@[or[Q6.',
                  //     },
                  //     {
                  //       'imageUrl':
                  //           'https://thumbs.dreamstime.com/b/chameleon-full-body-frame-shot-colorful-aligned-right-blue-background-ai-created-content-chameleon-full-body-frame-323142324.jpg',
                  //       'blurHash': 'LGF5?xYk^6#M@-5c,1J5@[or[Q6.',
                  //     },
                  //     {
                  //       'imageUrl':
                  //           'https://thumbs.dreamstime.com/b/chameleon-full-body-frame-shot-colorful-aligned-right-blue-background-ai-created-content-chameleon-full-body-frame-323142324.jpg',
                  //       'blurHash': 'LGF5?xYk^6#M@-5c,1J5@[or[Q6.',
                  //     },
                  //     {
                  //       'imageUrl':
                  //           'https://thumbs.dreamstime.com/b/chameleon-full-body-frame-shot-colorful-aligned-right-blue-background-ai-created-content-chameleon-full-body-frame-323142324.jpg',
                  //       'blurHash': 'LGF5?xYk^6#M@-5c,1J5@[or[Q6.',
                  //     },
                  //     {
                  //       'imageUrl':
                  //           'https://thumbs.dreamstime.com/b/chameleon-full-body-frame-shot-colorful-aligned-right-blue-background-ai-created-content-chameleon-full-body-frame-323142324.jpg',
                  //       'blurHash': 'LGF5?xYk^6#M@-5c,1J5@[or[Q6.',
                  //     },
                  //   ],
                  //   type: BubbleType.receiverBubble,
                  //   isRead: true,
                  //   timestamp: '15:30',
                  // );
                  // return TextMessageBubble(
                  //   message:
                  //       "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.",
                  //   timestamp: '15:30',
                  //   type: BubbleType.sendBubble,
                  //   isRead: true,
                  // );
                },
                separatorBuilder: (context, index) {
                  return SizedBox(height: 10);
                },
                itemCount: 10,
              ),
            ),
          ), // <- Chat list view
        ),
        _bottomInputField(), // <- Fixed bottom TextField widget
      ],
    );
  }

  Widget _bottomInputField() {
    return ValueListenableBuilder(
      valueListenable: _isCollapsed,
      builder: (context, value, child) {
        return Form(
          key: _formKey,
          child: Container(
            padding: EdgeInsets.all(8.0.scale),
            decoration: BoxDecoration(
              color: appWhite,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                if (value)
                  IconButton(
                    onPressed: () {
                      _isCollapsed.value = false;
                    },
                    icon: Icon(Icons.arrow_forward_ios),
                  ),
                if (!value)
                  IconButton(
                    onPressed: () {
                      // TODO: Implement your code here
                    },
                    icon: Icon(Icons.add_circle),
                  ),
                if (!value)
                  IconButton(
                    onPressed: () {
                      // TODO: Implement your code here
                    },
                    icon: Icon(Icons.camera_alt_rounded),
                  ),
                if (!value)
                  IconButton(
                    onPressed: () {
                      showModalDialog();
                    },
                    icon: Icon(Icons.image),
                  ),
                if (!value)
                  IconButton(
                    onPressed: () {
                      recordVoidMessage();
                    },
                    icon: Icon(Icons.mic),
                  ),
                Expanded(
                  child: TextFormField(
                    controller: _messageTextController,
                    focusNode: focusNode,
                    onTap: () => _isCollapsed.value = true,
                    onChanged: (value) {
                      if (value.isNotEmpty) {
                        _isSend.value = true;
                      } else {
                        _isSend.value = false;
                      }
                    },
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.all(10),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30.scale),
                      ),
                    ),
                  ),
                ),
                ValueListenableBuilder(
                  valueListenable: _isSend,
                  builder: (context, isSend, child) {
                    if (!isSend) return SizedBox.shrink();
                    return IconButton(
                      onPressed: () {
                        onSubmitTextMessage();
                      },
                      icon: Icon(Icons.send),
                    );
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void recordVoidMessage() {
    recorderController.checkPermission();
    if (recorderController.hasPermission) {
      showMediaRecorder();
    }
  }

  showMediaRecorder() {
    showModalBottomSheet<void>(
        isDismissible: true,
        context: context,
        backgroundColor: Colors.transparent,
        builder: (BuildContext context) {
          return Container(
            color: appWhite,
            height: 100.scale,
            width: double.infinity,
            child: Row(
              children: [
                IconButton(
                  onPressed: () async {
                    if (recorderController.isRecording) {
                      recordedFilePath = await recorderController.stop();
                    }
                  },
                  icon: Icon(Icons.stop),
                ),
                IconButton(
                  onPressed: () async {
                    if (recorderController.isRecording) {
                      await recorderController.pause();
                    }
                  },
                  icon: Icon(Icons.pause),
                ),
                // AudioWaveforms(
                //   decoration: BoxDecoration(
                //     borderRadius: BorderRadius.circular(30.scale),
                //     color: appBlueAccent,
                //     // backgroundColor: appBlueAccent,
                //   ),
                //   enableGesture: true,
                //   size: Size(300, 50),
                //   recorderController: recorderController,
                //   shouldCalculateScrolledPosition: true,
                //   waveStyle: WaveStyle(
                //     waveThickness: 2.5,
                //     spacing: 5,
                //     middleLineColor: Colors.transparent,
                //     waveCap: StrokeCap.round,
                //     extendWaveform: true,
                //     scaleFactor: 100,
                //     waveColor: appWhite,
                //     // backgroundColor: appWhite,
                //   ),
                // ),
                IconButton(
                  onPressed: () {
                    if (recorderController.hasPermission) {
                      recorderController.record(
                        androidEncoder: AndroidEncoder.aac,
                        androidOutputFormat: AndroidOutputFormat.aac_adts,
                        iosEncoder: IosEncoder.kAudioFormatMPEG4AAC,
                      ); // By default saves file with datetime as name.
                    }
                  },
                  icon: Icon(Icons.play_arrow),
                ),
              ],
            ),
          );
        });
  }

  showModalDialog() {
    showModalBottomSheet(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(5.0)),
      ),
      showDragHandle: true,
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      builder: (context) {
        return DraggableScrollableSheet(
          initialChildSize: 0.6,
          minChildSize: 0.5,
          expand: false,
          snap: true,
          builder: (context, scrollController) {
            // print(_draggableScrollableController.sizeToPixels(1));
            return NotificationListener(
              onNotification: (notification) {
                if (notification is ScrollMetricsNotification) {
                  if (notification.metrics.pixels == 0.0) {
                    _animationController.forward();
                    // _isVisible.value = false;
                  } else {
                    _animationController.reverse();
                    // _isVisible.value = true;
                  }
                }
                return true;
              },
              child: BlocBuilder<ChatRoomCubit, ChatRoomState>(
                bloc: screenCubit,
                builder: (context, state) {
                  // final records = state.albumsFolders;

                  return Column(
                    children: [
                      Row(
                        children: [
                          Padding(
                            padding: EdgeInsets.all(8.0.scale),
                            child: ValueListenableBuilder(
                              valueListenable: _pathValue,
                              builder: (context, value, child) {
                                // Remove duplicates from assetPathList
                                final uniqueItems = state.assetPathList
                                    .map((e) => e.name)
                                    .toSet() // Ensure uniqueness
                                    .toList();

                                // Validate the selected value
                                final selectedValue =
                                    uniqueItems.contains(value)
                                        ? value
                                        : (uniqueItems.isNotEmpty
                                            ? uniqueItems.last
                                            : null);

                                return DropdownButton<String>(
                                  underline: SizedBox.shrink(),
                                  value:
                                      selectedValue, // Ensure value matches an item
                                  items: uniqueItems
                                      .map<DropdownMenuItem<String>>((name) {
                                    return DropdownMenuItem(
                                      value: name,
                                      child: Text(name),
                                    );
                                  }).toList(),
                                  onChanged: (newValue) {
                                    if (newValue != null) {
                                      _pathValue.value = newValue;
                                      screenCubit.getAlbumsFolders(
                                          relativePath: newValue);
                                    }
                                  },
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                      // Expanded(
                      //   child: AlbmusImageGrid(
                      //     records: records,
                      //     scrollController: scrollController,
                      //     cameras: cameras,
                      //     onTap: () {
                      //       Navigator.pop(context);
                      //     },
                      //   ),
                      // ),
                      ValueListenableBuilder(
                        valueListenable: _isVisible,
                        builder: (context, value, child) {
                          return AnimatedOpacity(
                            opacity: value ? 0.0 : 1.0,
                            duration: Duration(milliseconds: 500),
                            child: SlideTransition(
                              position: _slideAnimation,
                              child: value
                                  ? SizedBox.shrink()
                                  : Container(
                                      height: 130.scale,
                                      decoration: BoxDecoration(
                                        color: appWhite,
                                        boxShadow: [
                                          BoxShadow(
                                            color: appBlack.withOpacity(0.2),
                                            spreadRadius: 1.0,
                                            offset: Offset(1, 0),
                                          )
                                        ],
                                      ),
                                      child: ListView(
                                        padding: EdgeInsets.all(10.scale),
                                        scrollDirection: Axis.horizontal,
                                        children: [
                                          _buildBoxIcon(
                                              assetName: albumsSvg,
                                              name: 'albums'.tr),
                                          _buildBoxIcon(
                                              assetName: fileSvg,
                                              name: 'file'.tr),
                                          _buildBoxIcon(
                                              assetName: musicSvg,
                                              name: 'music'.tr),
                                          _buildBoxIcon(
                                              assetName: locationSvg,
                                              name: 'location'.tr),
                                          _buildBoxIcon(
                                              assetName: contactSvg,
                                              name: 'contact'.tr),
                                        ],
                                      ),
                                    ),
                            ),
                          );
                        },
                      )
                    ],
                  );
                },
              ),
            );
          },
        );
      },
    );
  }

  Widget _buildBoxIcon({required String assetName, required String name}) {
    // return Padding(
    //   padding: EdgeInsets.only(right: 10.scale),
    //   child: ElevatedButton.icon(
    //     onPressed: () {
    //       //
    //     },
    //     icon: IconWidget(
    //       assetName: assetName,
    //       width: 24.scale,
    //       height: 24.scale,
    //     ),
    //     label: TextWidget(text: name),
    //   ),
    // );
    return Column(
      spacing: 5.scale,
      children: [
        Container(
          padding: EdgeInsets.all(15.scale),
          margin: EdgeInsets.symmetric(horizontal: 14.scale),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: primary,
          ),
          child: IconWidget(
            assetName: assetName,
            width: 20.scale,
            height: 20.scale,
            colorFilter: ColorFilter.mode(appWhite, BlendMode.srcIn),
          ),
        ),
        TextWidget(text: name),
      ],
    );
  }
}
