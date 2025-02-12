import 'package:equatable/equatable.dart';
import 'package:logic_app/data/models/slide_show_model.dart';

class HomeState extends Equatable {
  final bool isLoading;
  final bool isLoadingSlideShow;
  final String? error;
  final List<SlideShowModel>? slideShowModels;

  const HomeState({
    this.isLoading = false,
    this.isLoadingSlideShow = false,
    this.error,
    this.slideShowModels,
  });

  HomeState copyWith({
    bool? isLoading,
    bool? isLoadingSlideShow,
    String? error,
    List<SlideShowModel>? slideShowModels,
  }) {
    return HomeState(
      isLoading: isLoading ?? this.isLoading,
      isLoadingSlideShow: isLoadingSlideShow ?? this.isLoadingSlideShow,
      error: error ?? this.error,
      slideShowModels: slideShowModels ?? this.slideShowModels,
    );
  }

  @override
  List<Object?> get props => [
        isLoading,
        isLoadingSlideShow,
        error,
        slideShowModels,
      ];

  Map<String, dynamic> toJson() {
    return {
      'isLoading': isLoading,
      'isLoadingSlideShow': isLoadingSlideShow,
      'error': error,
      'slide_show': slideShowModels,
    };
  }

  static HomeState fromJson(Map<String, dynamic> json) {
    return HomeState(
      isLoading: json['isLoading'] ?? false,
      isLoadingSlideShow: json['isLoadingSlideShow'] ?? false,
      error: json['error'],
      slideShowModels: json['slide_show']
          ?.map((model) => SlideShowModel.fromJson(model))
          ?.toList(),
    );
  }
}
