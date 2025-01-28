import 'package:photo_manager/photo_manager.dart';

class ChatRoomState {
  final bool isLoading;
  final String? error;
  final List<AssetPathEntity> assetPathList;
  final List<AssetEntity> albumsFolders;
  const ChatRoomState({
    this.isLoading = false,
    this.error,
    this.assetPathList = const [],
    this.albumsFolders = const [],
  });

  ChatRoomState copyWith({
    bool? isLoading,
    String? error,
    List<AssetPathEntity>? assetPathList,
    List<AssetEntity>? albumsFolders,
  }) {
    return ChatRoomState(
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
      assetPathList: assetPathList ?? this.assetPathList,
      albumsFolders: albumsFolders ?? this.albumsFolders,
    );
  }
}
