import 'package:flutter/widgets.dart';
import 'package:lottie/lottie.dart';

class LottieWidget extends StatelessWidget {
  const LottieWidget(
      {super.key, required this.assets, this.width, this.height});
  final String assets;
  final double? width;
  final double? height;

  @override
  Widget build(BuildContext context) {
    return Lottie.asset(
      assets,
      width: width,
      height: height,
      repeat: false,
      // animate: false,
    );
  }
}
