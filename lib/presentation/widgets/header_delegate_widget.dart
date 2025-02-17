import 'package:flutter/material.dart';

class HeaderDelegateWidget extends SliverPersistentHeaderDelegate {
  HeaderDelegateWidget({
    this.minHeight,
    this.maxHeight,
    required this.child,
  });
  final double? minHeight;
  final double? maxHeight;
  final Widget child;

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    return child;
  }

  @override
  double get maxExtent => 80;

  @override
  double get minExtent => 80;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) =>
      true;
}
