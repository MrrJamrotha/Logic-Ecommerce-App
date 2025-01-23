import 'dart:isolate';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logic_app/core/di/injection.dart';
import 'package:logic_app/core/service/photo_manager_service.dart';
import 'package:logic_app/presentation/screens/home/home_cubit.dart';
import 'package:logic_app/presentation/screens/home/home_state.dart';
import 'package:logic_app/presentation/widgets/app_bar_widget.dart';
import 'package:photo_manager/photo_manager.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  HomeScreenState createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  final screenCubit = HomeCubit();
  final photoManagerService = di.get<PhotoManagerService>();
  final GlobalKey _bottomSheetKey = GlobalKey();

  @override
  void initState() {
    screenCubit.loadInitialData();
    super.initState();
  }

  Future<List<AssetPathEntity>?> getAssetPathList() async {
    try {
      final result = await photoManagerService.checkPermissions();
      if (result) {
        final listAlbumsFolders = await photoManagerService.getAssetPathList();
        final data = await Isolate.run(() {
          return listAlbumsFolders.toList();
        });
        return data;
      }
    } catch (e) {
      debugPrint('error ${e.toString()}');
      return [];
    }
  }

  showModalDialog() {
    showModalBottomSheet(
      // showDragHandle: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(5.0)),
      ),
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
            return SingleChildScrollView(
              controller: scrollController,
              child: Column(
                children: [
                  //
                  //
                  SizedBox(
                    height: 80,
                  )
                ],
              ),
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
            // getAssetPathList();
            showModalDialog();
          },
          child: Text('get photo'),
        ),
      ],
    );
  }
}
