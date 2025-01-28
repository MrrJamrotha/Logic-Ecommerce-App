import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logic_app/core/di/injection.dart';
import 'package:logic_app/core/helper/helper.dart';
import 'package:logic_app/core/service/photo_manager_service.dart';
import 'package:logic_app/presentation/screens/chat_room/chat_room_state.dart';

class ChatRoomCubit extends Cubit<ChatRoomState> {
  ChatRoomCubit() : super(ChatRoomState(isLoading: true));

  final photoManagerService = di.get<PhotoManagerService>();

  Future<void> checkPermissions() async {
    try {
      emit(state.copyWith(isLoading: true));
      final result = await photoManagerService.checkPermissions();
      if (result) {
        await getAssetPathList();
        await getAlbumsFolders(relativePath: state.assetPathList.last.name);
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

  Future<void> getAlbumsFolders({String? relativePath}) async {
    try {
      final listAlbumsFolders = await photoManagerService.getAlbumsFolders(
        relativePath: relativePath,
      );

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
}
