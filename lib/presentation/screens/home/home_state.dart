import 'package:equatable/equatable.dart';
import 'package:photo_manager/photo_manager.dart';

class HomeState extends Equatable {
  final bool isLoading;
  final String? error;
  final List<AssetPathEntity> assetPathList;
  final List<AssetEntity> albumsFolders;
  const HomeState({
    this.isLoading = false,
    this.error,
    this.assetPathList = const [],
    this.albumsFolders = const [],
  });

  HomeState copyWith({
    bool? isLoading,
    String? error,
    List<AssetPathEntity>? assetPathList,
    List<AssetEntity>? albumsFolders,
  }) {
    return HomeState(
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
      assetPathList: assetPathList ?? this.assetPathList,
      albumsFolders: albumsFolders ?? this.albumsFolders,
    );
  }

  @override
  List<Object?> get props => [
        isLoading,
        error,
        assetPathList,
        albumsFolders,
      ];

  Map<String, dynamic> toJson() {
    return {
      'isLoading': isLoading,
      'error': error,
      'assetPathList': assetPathList,
      'albumsFolders': albumsFolders,
    };
  }

  static HomeState fromJson(Map<String, dynamic> json) {
    return HomeState(
      isLoading: json['isLoading'] ?? false,
      error: json['error'],
      assetPathList: json['assetPathList'],
      albumsFolders: json['albumsFolders'],
    );
  }
}
