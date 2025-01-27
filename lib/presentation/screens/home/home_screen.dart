import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:go_router/go_router.dart';
import 'package:logic_app/core/constants/app_colors.dart';
import 'package:logic_app/core/constants/app_icons.dart';
import 'package:logic_app/core/helper/helper.dart';
import 'package:logic_app/presentation/screens/camera/take_picture_screen.dart';
import 'package:logic_app/presentation/screens/home/home_cubit.dart';
import 'package:logic_app/presentation/screens/home/home_state.dart';
import 'package:logic_app/presentation/widgets/app_bar_widget.dart';
import 'package:logic_app/presentation/widgets/icon_widget.dart';
import 'package:logic_app/presentation/widgets/render_asset_entity_image_widget.dart';
import 'package:logic_app/presentation/widgets/text_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  HomeScreenState createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  final screenCubit = HomeCubit();
  late List<CameraDescription> cameras;

  late AnimationController _animationController;
  late Animation<Offset> _slideAnimation;
  bool _isVisible = false; // Track if the view is visible

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

  void _toggleView() {
    setState(() {
      if (_isVisible) {
        _animationController.reverse(); // Slide down (hide)
      } else {
        _animationController.forward(); // Slide up (show)
      }
      _isVisible = !_isVisible; // Toggle visibility
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppbarWidget(),
      body: BlocConsumer<HomeCubit, HomeState>(
        bloc: screenCubit,
        listener: (BuildContext context, HomeState state) {
          if (state.error != null) {
            // TODO your code here
          }
        },
        builder: (BuildContext context, HomeState state) {
          if (state.isLoading) {
            return Center(child: CircularProgressIndicator());
          }

          return buildBody(state);
        },
      ),
    );
  }

  Widget buildBody(HomeState state) {
    return Center(
      child: ElevatedButton(
        onPressed: () {
          showModalDialog(state);
        },
        child: Text('get photo'),
      ),
    );
  }

  showModalDialog(HomeState state) {
    final records = state.albumsFolders;
    showModalBottomSheet(
      // showDragHandle: true,
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
            return NotificationListener(
              onNotification: (notification) {
                if (notification is ScrollMetricsNotification) {
                  if (notification.metrics.extentInside <= 800) {
                    _animationController.forward();
                  } else {
                    _animationController.reverse();
                  }
                }
                return true;
              },
              child: Column(
                children: [
                  Expanded(
                    child: MasonryGridView.count(
                      padding: EdgeInsets.all(5.scale),
                      controller: scrollController,
                      shrinkWrap: true,
                      itemCount: records.length + 1,
                      crossAxisCount: 3,
                      mainAxisSpacing: 5.scale,
                      crossAxisSpacing: 5.scale,
                      itemBuilder: (context, index) {
                        if (index == 0) {
                          return GestureDetector(
                            onTap: () => context.goNamed(
                              TakePictureScreen.routeName,
                              extra: cameras.first,
                            ),
                            child: SizedBox(
                              width: 150.scale,
                              height: 180.scale,
                              child: Icon(Icons.camera),
                            ),
                          );
                        }
                        return RenderAssetEntityImageWidget(
                          entity: records[index - 1],
                        );
                      },
                    ),
                  ),
                  SlideTransition(
                    position: _slideAnimation,
                    child: Container(
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
                              assetName: albumsSvg, name: 'albums'.tr),
                          _buildBoxIcon(assetName: fileSvg, name: 'file'.tr),
                          _buildBoxIcon(assetName: musicSvg, name: 'music'.tr),
                          _buildBoxIcon(
                              assetName: locationSvg, name: 'location'.tr),
                          _buildBoxIcon(
                              assetName: contactSvg, name: 'contact'.tr),
                        ],
                      ),
                    ),
                  )
                ],
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
