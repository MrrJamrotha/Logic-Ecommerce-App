import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:logic_app/core/constants/app_colors.dart';
import 'package:logic_app/core/constants/app_icons.dart';
import 'package:logic_app/core/helper/helper.dart';
import 'package:logic_app/presentation/screens/chat_room/chat_room_cubit.dart';
import 'package:logic_app/presentation/screens/chat_room/chat_room_state.dart';
import 'package:logic_app/presentation/screens/chat_room/components/albmus_image_grid.dart';
import 'package:logic_app/presentation/screens/chat_room/components/preview_image.dart';
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
  late List<CameraDescription> cameras;

  late AnimationController _animationController;
  late Animation<Offset> _slideAnimation;

  final _pathValue = ValueNotifier<String>("");
  final _isVisible = ValueNotifier<bool>(false);
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

    initializedAvailableCameras();
    screenCubit.checkPermissions();
    super.initState();
  }

  void initializedAvailableCameras() async {
    cameras = await availableCameras();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _animationController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
            return Center(child: CircularProgressIndicator());
          }

          return buildBody(state);
        },
      ),
    );
  }

  Widget buildBody(ChatRoomState state) {
    return ListView(
      children: [
        // TODO your code here
        ElevatedButton(
          onPressed: () {
            showModalDialog();
          },
          child: TextWidget(text: 'get albums'),
        )
      ],
    );
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
                    _isVisible.value = false;
                  } else {
                    _animationController.reverse();
                    _isVisible.value = true;
                  }
                }
                return true;
              },
              child: BlocBuilder<ChatRoomCubit, ChatRoomState>(
                bloc: screenCubit,
                builder: (context, state) {
                  final records = state.albumsFolders;

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
                      Expanded(
                        child: AlbmusImageGrid(
                          records: records,
                          scrollController: scrollController,
                          cameras: cameras,
                          onTap: () {
                            context.pop();
                            context.goNamed(
                              PreviewImage.routeName,
                              extra: records,
                            );
                          },
                        ),
                      ),
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
      children: [
        Container(
          padding: EdgeInsets.all(20.scale),
          margin: EdgeInsets.symmetric(horizontal: 20.scale),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: primary,
          ),
          child: IconWidget(
            assetName: assetName,
            width: 40.scale,
            height: 40.scale,
            colorFilter: ColorFilter.mode(appWhite, BlendMode.srcIn),
          ),
        ),
        TextWidget(text: name),
      ],
    );
  }
}
