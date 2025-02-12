import 'package:logic_app/core/common/result.dart';
import 'package:logic_app/data/models/slide_show_model.dart';

abstract class HomeRepository {
  Future<Result<List<SlideShowModel>, dynamic>> getSlideShow({
    Map<String, dynamic>? parameters,
  });
}
