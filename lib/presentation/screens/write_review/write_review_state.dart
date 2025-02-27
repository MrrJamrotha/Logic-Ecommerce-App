import 'package:image_picker/image_picker.dart';

class WriteReviewState {
  final bool isLoading;
  final String? error;
  final List<XFile>? xFiles;

  const WriteReviewState({
    this.isLoading = false,
    this.error,
    this.xFiles,
  });

  WriteReviewState copyWith({
    bool? isLoading,
    String? error,
    List<XFile>? xFiles,
  }) {
    return WriteReviewState(
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
      xFiles: xFiles,
    );
  }
}
