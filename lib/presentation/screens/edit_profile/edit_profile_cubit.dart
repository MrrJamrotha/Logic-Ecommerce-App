import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:logic_app/core/di/injection.dart';
import 'package:logic_app/data/repositories/user/user_repository_impl.dart';
import 'package:logic_app/presentation/screens/edit_profile/edit_profile_state.dart';

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
}
