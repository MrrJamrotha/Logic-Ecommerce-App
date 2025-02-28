import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:foxShop/data/models/category_model.dart';

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
    var json = jsonEncode(records?.map((e) => e.toJson()).toList());
    return {
      'isLoading': isLoading,
      'error': error,
      'records': json,
    };
  }

  factory CategoryState.fromJson(Map<String, dynamic> json) {
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
