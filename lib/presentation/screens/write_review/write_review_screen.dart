import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:foxShop/core/constants/app_colors.dart';
import 'package:foxShop/core/constants/app_icons.dart';
import 'package:foxShop/core/constants/app_space.dart';
import 'package:foxShop/core/helper/helper.dart';
import 'package:foxShop/presentation/screens/write_review/write_review_cubit.dart';
import 'package:foxShop/presentation/screens/write_review/write_review_state.dart';
import 'package:foxShop/presentation/widgets/app_bar_widget.dart';
import 'package:foxShop/presentation/widgets/button_widget.dart';
import 'package:foxShop/presentation/widgets/icon_widget.dart';
import 'package:foxShop/presentation/widgets/text_widget.dart';

class WriteReviewScreen extends StatefulWidget {
  const WriteReviewScreen({super.key});
  static const routeName = 'write_review';
  static const routePath = '/write_review';

  @override
  WriteReviewScreenState createState() => WriteReviewScreenState();
}

class WriteReviewScreenState extends State<WriteReviewScreen> {
  final screenCubit = WriteReviewCubit();
  final _rating = ValueNotifier<double>(1.0);
  final _commentCtr = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    screenCubit.loadInitialData();
    super.initState();
  }

  Future<void> uploadReview() async {
    if (_formKey.currentState!.validate()) {
      //TODO: check
    }
  }

  showModalCameraOrAlbums() {
    showModalBottomSheet(
      context: context,
      showDragHandle: true,
      builder: (context) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: appSpace.scale,
          children: [
            ListTile(
              onTap: () {
                screenCubit.selectCamera();
                Navigator.pop(context);
              },
              leading: IconWidget(
                assetName: cameraSvg,
                width: 24.scale,
                height: 24.scale,
              ),
              title: TextWidget(text: 'camera'.tr),
            ),
            ListTile(
              onTap: () {
                screenCubit.selectImages();
                Navigator.pop(context);
              },
              leading: IconWidget(
                assetName: albumsSvg,
                width: 24.scale,
                height: 24.scale,
              ),
              title: TextWidget(text: 'albums'.tr),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppbarWidget(title: 'write_review'.tr),
      body: BlocConsumer<WriteReviewCubit, WriteReviewState>(
        bloc: screenCubit,
        listener: (BuildContext context, WriteReviewState state) {
          if (state.error != null) {
            // TODO your code here
          }
        },
        builder: (BuildContext context, WriteReviewState state) {
          if (state.isLoading) {
            return centerLoading();
          }

          return buildBody(state);
        },
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.all(appPedding.scale),
        child: ButtonWidget(
          title: 'upload'.tr,
          onPressed: () => uploadReview(),
        ),
      ),
    );
  }

  Widget buildBody(WriteReviewState state) {
    final images = state.xFiles ?? [];
    return SingleChildScrollView(
      padding: EdgeInsets.all(appPedding.scale),
      child: Form(
        key: _formKey,
        child: Column(
          spacing: appPedding.scale,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: RatingBar.builder(
                    glow: false,
                    initialRating: 1,
                    minRating: 1,
                    direction: Axis.horizontal,
                    allowHalfRating: true,
                    itemCount: 5,
                    itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                    itemBuilder: (context, _) =>
                        Icon(Icons.star, color: appYellow),
                    onRatingUpdate: (rating) => _rating.value = rating,
                  ),
                ),
                ValueListenableBuilder(
                  valueListenable: _rating,
                  builder: (context, value, child) {
                    return Text.rich(
                      TextSpan(
                        style: TextStyle(fontSize: 25.scale),
                        children: [
                          TextSpan(text: value.toString()),
                          TextSpan(
                            text: '/5',
                            style: TextStyle(
                              color: textColor,
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                )
              ],
            ),
            TextFormField(
              cursorColor: primary,
              controller: _commentCtr,
              maxLines: 5,
              onTapOutside: (PointerDownEvent event) {
                FocusManager.instance.primaryFocus?.unfocus();
              },
              validator: (value) {
                if (value!.isEmpty) {
                  return 'comment_is_required'.tr;
                }
                return null;
              },
              decoration: InputDecoration(
                hintText: 'comment'.tr,
                border: OutlineInputBorder(),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: primary, width: 2),
                ),
              ),
            ),
            ButtonWidget(
              isIcon: true,
              assetName: cameraSvg,
              title: 'add_photos'.tr,
              onPressed: () {
                showModalCameraOrAlbums();
              },
            ),
            SizedBox(
              height: 150.scale,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: images.length,
                itemBuilder: (context, index) {
                  final file = images[index];
                  return Padding(
                    padding: EdgeInsets.only(right: appSpace.scale),
                    child: Stack(
                      children: [
                        Container(
                          width: 100.scale,
                          height: 100.scale,
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: textColor,
                              width: 0.1.scale,
                            ),
                            borderRadius:
                                BorderRadius.circular(appRadius.scale),
                            image: DecorationImage(
                              fit: BoxFit.cover,
                              image: FileImage(
                                File(file.path),
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          top: 0,
                          right: 0,
                          child: InkWell(
                            onTap: () => screenCubit.removeImage(index),
                            child: IconWidget(
                              assetName: cancelSvg,
                              width: 24.scale,
                              height: 24.scale,
                            ),
                          ),
                        )
                      ],
                    ),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
