import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:go_router/go_router.dart';
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

class HomeScreenState extends State<HomeScreen> {
  final screenCubit = HomeCubit();
  late List<CameraDescription> cameras;
  @override
  void initState() {
    initializedAvailableCameras();
    screenCubit.checkPermissions();
    super.initState();
  }

  void initializedAvailableCameras() async {
    cameras = await availableCameras();
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
    return ListView(
      children: [
        // TODO your code here

        ElevatedButton(
          onPressed: () {
            showModalDialog(state);
          },
          child: Text('get photo'),
        ),
      ],
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
                  final offset = notification.metrics.pixels;
                  print(notification.metrics.viewportDimension);

                  // if (offset >= 1.0) {
                  //   print('Offset reached 1.0 or more: $offset');
                  // } else {
                  //   print('Offset is less than 1.0: $offset');
                  // }
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
                              height: 100.scale,
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
                  // AnimatedSwitcher(
                  //   duration: Duration(milliseconds: 300),
                  //   child: SizedBox(
                  //     height: 60.h,
                  //     child: ListView(
                  //       shrinkWrap: true,
                  //       padding: EdgeInsets.all(10).w,
                  //       scrollDirection: Axis.horizontal,
                  //       children: [
                  //         _buildBoxIcon(assetName: albumsSvg, name: 'albums'.tr),
                  //         _buildBoxIcon(assetName: fileSvg, name: 'file'.tr),
                  //         _buildBoxIcon(assetName: musicSvg, name: 'music'.tr),
                  //       ],
                  //     ),
                  //   ),
                  // )
                ],
              ),
            );
          },
        );
      },
    );
  }

  Widget _buildBoxIcon({required String assetName, required String name}) {
    return Padding(
      padding: EdgeInsets.only(right: 8.scale),
      child: ElevatedButton.icon(
        onPressed: () {
          //
        },
        icon: IconWidget(
          assetName: assetName,
          width: 24.scale,
          height: 24.scale,
        ),
        label: TextWidget(text: name),
      ),
    );
  }
}
