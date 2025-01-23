import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:logic_app/core/di/injection.dart';
import 'package:logic_app/core/helper/helper.dart';
import 'package:logic_app/core/service/photo_manager_service.dart';
import 'package:logic_app/presentation/screens/home/home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeState(isLoading: true));
  final photoManagerService = di.get<PhotoManagerService>();

  Future<void> checkPermissions() async {
    try {
      emit(state.copyWith(isLoading: true));
      final result = await photoManagerService.checkPermissions();
      if (result) {
        await getAssetPathList();
        await getAlbumsFolders();
      }
      emit(state.copyWith(isLoading: false));
    } catch (error) {
      addError(error);
      emit(state.copyWith(isLoading: false));
    }
  }

  Future<void> getAssetPathList() async {
    try {
      final listAlbumsFolders = await photoManagerService.getAssetPathList();
      emit(state.copyWith(assetPathList: listAlbumsFolders));
    } catch (error) {
      addError(error);
    }
  }

  Future<void> getAlbumsFolders() async {
    try {
      final listAlbumsFolders = await photoManagerService.getAlbumsFolders();
      emit(state.copyWith(albumsFolders: listAlbumsFolders));
    } catch (error) {
      addError(error);
    }
  }

  @override
  void addError(Object error, [StackTrace? stackTrace]) {
    logger.e(error, stackTrace: stackTrace);
    super.addError(error, stackTrace);
  }

  // @override
  // HomeState? fromJson(Map<String, dynamic> json) {
  //   try {
  //     return HomeState.fromJson(json);
  //   } catch (error) {
  //     addError(error);
  //     return null;
  //   }
  // }

  // @override
  // Map<String, dynamic>? toJson(HomeState state) {
  //   try {
  //     return state.toJson();
  //   } catch (error) {
  //     addError(error);
  //     return null;
  //   }
  // }
}
