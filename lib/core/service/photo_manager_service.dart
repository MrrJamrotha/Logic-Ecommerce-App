import 'package:photo_manager/photo_manager.dart';

class PhotoManagerService {
  static final PhotoManagerService instance = PhotoManagerService._internal();
  PhotoManagerService._internal();

  Future<bool> checkPermissions() async {
    // the method can use optional param `permission`.
    final PermissionState ps = await PhotoManager.requestPermissionExtend();
    if (ps.isAuth) {
      // Granted
      // You can to get assets here.
      return true;
    } else if (ps.hasAccess) {
      // Access will continue, but the amount visible depends on the user's selection.
      return true;
    } else {
      // Limited(iOS) or Rejected, use `==` for more precise judgements.
      // You can call `PhotoManager.openSetting()` to open settings for further steps.
      PhotoManager.openSetting();
      return false;
    }
  }

  /// Fetch albums (folders) and their assets
  Future<List<AssetPathEntity>> getAssetPathList() async {
    // Fetching albums (folders) from the gallery
    final List<AssetPathEntity> albums = await PhotoManager.getAssetPathList(
      // type: RequestType.image, // You can specify image, video, or audio
      filterOption: FilterOptionGroup(
        containsPathModified: true,
        orders: [OrderOption(type: OrderOptionType.createDate, asc: false)],
      ),
    );
    return albums;
  }

  /// Fetch assets (photos/videos) from a specific album
  Future<List<AssetEntity>> getAlbumsFolders({String? relativePath}) async {
    final int count = await PhotoManager.getAssetCount();
    final entities = await PhotoManager.getAssetListPaged(
      page: 0,
      pageCount: count,
      // type: RequestType.image,
    );
    if (relativePath != null &&
        relativePath.isNotEmpty &&
        relativePath != "Recent") {
      return entities
          .where((asset) => asset.relativePath?.contains(relativePath) ?? false)
          .toList();
    }
    if (relativePath == "Recent") {
      return entities;
    }

    return entities;
  }
}
