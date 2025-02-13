import 'package:equatable/equatable.dart';
import 'package:logic_app/data/models/category_model.dart';

class CategoryState extends Equatable {
  final bool isLoading;
  final String? error;
  final List<CategoryModel>? records;

  const CategoryState({
    this.isLoading = false,
    this.error,
    this.records,
  });

  CategoryState copyWith({
    bool? isLoading,
    String? error,
    List<CategoryModel>? records,
  }) {
    return CategoryState(
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
      records: records ?? this.records,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'isLoading': isLoading,
      'error': error,
      'records': records?.map((model) => model.toJson()).toList(),
    };
  }

  static CategoryState fromJson(Map<String, dynamic> json) {
    return CategoryState(
      isLoading: json['isLoading'],
      error: json['error'],
      records: json['records']
          ?.map((model) => CategoryModel.fromJson(model))
          ?.toList(),
    );
  }

  @override
  List<Object?> get props => [isLoading, error, records];
}
