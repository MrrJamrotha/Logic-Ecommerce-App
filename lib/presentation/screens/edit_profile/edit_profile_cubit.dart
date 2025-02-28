import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:foxShop/core/di/injection.dart';
import 'package:foxShop/core/helper/helper.dart';
import 'package:foxShop/data/repositories/user/user_repository_impl.dart';
import 'package:foxShop/presentation/screens/edit_profile/edit_profile_state.dart';

class EditProfileCubit extends Cubit<EditProfileState> {
  EditProfileCubit() : super(EditProfileState(isLoading: true));
  final repos = di.get<UserRepositoryImpl>();
  final ImagePicker _imagePicker = ImagePicker();
  Future<void> loadInitialData() async {
    final stableState = state;
    try {
      emit(state.copyWith(isLoading: true));
      await repos.getUserProfile().then((response) {
        response.fold((failure) {
          emit(state.copyWith(error: failure.toString()));
        }, (success) {
          emit(state.copyWith(userModel: success));
        });
      });
      emit(state.copyWith(isLoading: false));
    } catch (error) {
      emit(state.copyWith(error: error.toString()));
      emit(stableState.copyWith(isLoading: false));
    }
  }

  void selectImage({ImageSource imageSource = ImageSource.camera}) async {
    try {
      final imageFile = await _imagePicker.pickImage(source: imageSource);
      if (imageFile != null) {
        emit(state.copyWith(xFile: imageFile));
      }
    } catch (e) {
      addError(e);
    }
  }

  Future<bool> updateUserProfile({Map<String, dynamic>? parameters}) async {
    try {
      await repos.updateUserProfile(parameters: parameters).then((response) {
        response.fold((failure) {
          showMessage(message: failure.message);
          emit(state.copyWith(error: failure.message));
          return false;
        }, (success) {
          showMessage(message: response.message ?? "");
          emit(state.copyWith(userModel: success));
          return true;
        });
      });
      return true;
    } catch (e) {
      addError(e);
      return false;
    }
  }

  @override
  void addError(Object error, [StackTrace? stackTrace]) {
    logger.e(error, stackTrace: stackTrace);
    super.addError(error, stackTrace);
  }
}
