import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:logic_app/presentation/screens/home/home_cubit.dart';
import 'package:logic_app/presentation/screens/home/home_state.dart';
import 'package:logic_app/presentation/widgets/app_bar_widget.dart';
import 'package:logic_app/presentation/widgets/render_asset_entity_image_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  HomeScreenState createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  final screenCubit = HomeCubit();

  @override
  void initState() {
    screenCubit.checkPermissions();
    super.initState();
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
          initialChildSize: 0.7,
          minChildSize: 0.5,
          expand: false,
          snap: true,
          builder: (context, scrollController) {
            return Column(
              children: [
                Expanded(
                  child: MasonryGridView.count(
                    padding: EdgeInsets.all(5).w,
                    controller: scrollController,
                    shrinkWrap: true,
                    itemCount: records.length,
                    crossAxisCount: 3,
                    mainAxisSpacing: 5.sp,
                    crossAxisSpacing: 5.sp,
                    itemBuilder: (context, index) {
                      return RenderAssetEntityImageWidget(
                        entity: records[index],
                      );
                    },
                  ),
                ),
                SizedBox(
                  height: 60.h,
                  child: ListView(
                    shrinkWrap: true,
                    padding: EdgeInsets.all(10).w,
                    scrollDirection: Axis.horizontal,
                    children: [
                      IconButton(
                        onPressed: () {
                          //
                        },
                        icon: Icon(Icons.photo_album),
                      ),
                      IconButton(
                        onPressed: () {
                          //
                        },
                        icon: Icon(Icons.photo_album),
                      ),
                      IconButton(
                        onPressed: () {
                          //
                        },
                        icon: Icon(Icons.photo_album),
                      ),
                    ],
                  ),
                )
              ],
            );
          },
        );
      },
    );
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
}
