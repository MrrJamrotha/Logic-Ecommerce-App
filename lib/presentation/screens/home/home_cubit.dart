import 'dart:isolate';

import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:logic_app/core/di/injection.dart';
import 'package:logic_app/core/helper/helper.dart';
import 'package:logic_app/core/service/photo_manager_service.dart';
import 'package:logic_app/presentation/screens/home/home_state.dart';
import 'package:photo_manager/photo_manager.dart';

class HomeCubit extends HydratedCubit<HomeState> {
  HomeCubit() : super(HomeState(isLoading: true));
  final photoManagerService = di.get<PhotoManagerService>();

  Future<void> checkPermissions() async {
    try {
      emit(state.copyWith(isLoading: true));
      final result = await photoManagerService.checkPermissions();
      if (result) {
        final paths = await getAssetPathList();
        logger.i(paths);
        final photos = await getAlbumsFolders();

        logger.i(photos);
        emit(state.copyWith(
          albumsFolders: photos ?? [],
          assetPathList: paths ?? [],
        ));
      }
      emit(state.copyWith(isLoading: false));
    } catch (error) {
      addError(error);
      emit(state.copyWith(isLoading: false));
    }
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
    } catch (error) {
      addError(error);
      return [];
    }
    return [];
  }

  Future<List<AssetEntity>?> getAlbumsFolders() async {
    try {
      final listAlbumsFolders = await photoManagerService.getAlbumsFolders();
      final data = await Isolate.run(() {
        return listAlbumsFolders.toList();
      });
      return data;
    } catch (error) {
      addError(error);
      return [];
    }
  }

  @override
  void addError(Object error, [StackTrace? stackTrace]) {
    logger.e(error, stackTrace: stackTrace);
    super.addError(error, stackTrace);
  }

  @override
  HomeState? fromJson(Map<String, dynamic> json) {
    try {
      return HomeState.fromJson(json);
    } catch (error) {
      addError(error);
      return null;
    }
  }

  @override
  Map<String, dynamic>? toJson(HomeState state) {
    try {
      return state.toJson();
    } catch (error) {
      addError(error);
      return null;
    }
  }
}
