import 'package:image_picker/image_picker.dart';
import 'package:logic_app/data/models/user_model.dart';

class EditProfileState {
  final bool isLoading;
  final String? error;
  final UserModel? userModel;
  final XFile? xFile;
  const EditProfileState({
    this.isLoading = false,
    this.error,
    this.userModel,
    this.xFile,
  });

  EditProfileState copyWith({
    bool? isLoading,
    String? error,
    UserModel? userModel,
    XFile? xFile,
  }) {
    return EditProfileState(
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
      userModel: userModel ?? this.userModel,
      xFile: xFile ?? this.xFile,
    );
  }
}
