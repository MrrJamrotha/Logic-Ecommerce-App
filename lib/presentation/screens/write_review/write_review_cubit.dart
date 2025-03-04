import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foxShop/core/constants/app_enum.dart';
import 'package:foxShop/core/di/injection.dart';
import 'package:foxShop/data/repositories/write_review/write_review_repository_impl.dart';
import 'package:image_picker/image_picker.dart';
import 'package:foxShop/core/helper/helper.dart';
import 'package:foxShop/presentation/screens/write_review/write_review_state.dart';

class WriteReviewCubit extends Cubit<WriteReviewState> {
  WriteReviewCubit() : super(WriteReviewState(isLoading: false));
  final ImagePicker _imagePicker = ImagePicker();
  final repos = di.get<WriteReviewRepositoryImpl>();

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

  Future<bool> uploadReview({Map<String, dynamic>? parameters}) async {
    try {
      bool isSuccess = false;

      await repos.writeReview(parameters: {
        ...?parameters,
        'xFiles': state.xFiles,
      }).then((response) {
        response.fold((failure) {
          isSuccess = false;
          showMessage(message: failure.message, status: MessageStatus.warning);
          emit(state.copyWith(error: failure.message));
        }, (success) {
          isSuccess = true;
          showMessage(message: response.message ?? "");
        });
      });
      return isSuccess;
    } catch (error) {
      addError(error);
      return false;
    }
  }
}
