import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:foxShop/core/helper/helper.dart';
import 'package:foxShop/presentation/screens/write_review/write_review_state.dart';

class WriteReviewCubit extends Cubit<WriteReviewState> {
  WriteReviewCubit() : super(WriteReviewState(isLoading: true));
  final ImagePicker _imagePicker = ImagePicker();
  Future<void> loadInitialData() async {
    final stableState = state;
    try {
      emit(state.copyWith(isLoading: true));

      // TODO your code here

      emit(state.copyWith(isLoading: false));
    } catch (error) {
      emit(state.copyWith(error: error.toString()));
      emit(stableState.copyWith(isLoading: false));
    }
  }

  void selectCamera() async {
    try {
      final imageFile = await _imagePicker.pickImage(
        source: ImageSource.camera,
      );
      if (imageFile != null) {
        final updatedList = List<XFile>.from(state.xFiles ?? []);
        updatedList.add(imageFile);
        emit(state.copyWith(xFiles: updatedList));
      }
    } catch (e) {
      addError(e);
    }
  }

  void selectImages() async {
    try {
      final images = await _imagePicker.pickMultiImage(limit: 5);
      if (images.isNotEmpty) {
        emit(state.copyWith(xFiles: images));
      }
    } catch (e) {
      addError(e);
    }
  }

  @override
  void addError(Object error, [StackTrace? stackTrace]) {
    logger.e(error, stackTrace: stackTrace);
    super.addError(error, stackTrace);
  }

  void removeImage(int index) {
    try {
      final updatedList = List<XFile>.from(state.xFiles!);
      updatedList.removeAt(index);
      emit(state.copyWith(xFiles: updatedList));
    } catch (e) {
      addError(e);
    }
  }
}
