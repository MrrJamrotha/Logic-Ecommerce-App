import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logic_app/core/constants/app_colors.dart';
import 'package:logic_app/core/constants/app_space.dart';
import 'package:logic_app/core/helper/helper.dart';
import 'package:logic_app/presentation/screens/home/home_cubit.dart';
import 'package:logic_app/presentation/screens/home/home_state.dart';
import 'package:logic_app/presentation/widgets/app_bar_widget.dart';
import 'package:logic_app/presentation/widgets/card_category_widget.dart';
import 'package:logic_app/presentation/widgets/carousel_slider_widget.dart';
import 'package:logic_app/presentation/widgets/text_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  HomeScreenState createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  final screenCubit = HomeCubit();
  late AnimationController _animationController;
  late OverlayEntry overlayEntry;
  @override
  void initState() {
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 300),
    );
    screenCubit.getSlideShow(parameters: {'display_type': 'NewProduct'});
    screenCubit.getBrowseCategories();
    screenCubit.getBrands();
    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppbarWidget(
        title: 'home'.tr,
      ),
      body: buildBody(),
    );
  }

  Widget buildBody() {
    return BlocBuilder<HomeCubit, HomeState>(
      bloc: screenCubit,
      builder: (context, state) {
        final slideShowModels = state.slideShowModels ?? [];
        final categoryModels = state.categoryModels ?? [];
        return SingleChildScrollView(
          padding: EdgeInsets.all(appPedding.scale),
          child: Column(
            spacing: 16.scale,
            children: [
              CarouselSliderWidget(
                records: slideShowModels,
                isLoading: state.isLoadingSlideShow,
              ),
              _buildTitleRow(
                title: 'browse_categories'.tr,
                onTap: () {
                  //TODO: next time
                },
              ),
              SizedBox(
                height: 100.scale,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: categoryModels.length,
                  itemBuilder: (context, index) {
                    final record = categoryModels[index];
                    return CardCategoryWidget(
                      picture: record.picture,
                      pictureHash: record.pictureHash,
                      title: record.name,
                    );
                  },
                ),
              ),
              _buildTitleRow(
                title: 'today_deals'.tr,
                onTap: () {
                  //TODO: next time
                },
              ),
              _buildTitleRow(
                title: 'today_deals'.tr,
                onTap: () {
                  //TODO: next time
                },
              ),
              CarouselSliderWidget(
                records: slideShowModels,
                isLoading: state.isLoadingSlideShow,
              ),
              _buildTitleRow(
                title: 'recommend_for_you'.tr,
                onTap: () {
                  //TODO: next time
                },
              ),
              _buildTitleRow(
                title: 'bast_seller'.tr,
                onTap: () {
                  //TODO: next time
                },
              ),
              _buildTitleRow(
                title: 'new_arrival'.tr,
                onTap: () {
                  //TODO: next time
                },
              ),
              _buildTitleRow(
                title: 'spacial_offers'.tr,
                onTap: () {
                  //TODO: next time
                },
              ),
            ],
          ),
        );
      },
    );
  }

  Row _buildTitleRow({required String title, Function()? onTap}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        TextWidget(text: title),
        TextButton(
          onPressed: onTap,
          child: TextWidget(
            text: 'view_more'.tr,
            color: primary,
          ),
        ),
      ],
    );
  }

  showDialogUpdate() {
    final overlay = Overlay.of(context);
    overlayEntry = OverlayEntry(
      builder: (context) {
        return Positioned(
          top: 0,
          left: 16.scale,
          right: 16.scale,
          child: SafeArea(
            child: FadeTransition(
              opacity: _animationController,
              child: ScaleTransition(
                scale: CurvedAnimation(
                  parent: _animationController,
                  curve: Curves.easeOutBack,
                ),
                child: AlertDialog(
                  elevation: 1,
                  shape: ContinuousRectangleBorder(
                    borderRadius: BorderRadius.circular(16.scale),
                  ),
                  title: TextWidget(text: 'LOGIC mobile'),
                  content: TextWidget(
                      text:
                          "New Version released.\nVersion 7.9 is available on the AppStore."),
                  insetPadding: EdgeInsets.symmetric(
                    horizontal: 0,
                  ),
                  actionsPadding: EdgeInsets.all(8.scale),
                  contentPadding: EdgeInsets.all(15.scale),
                  actions: [
                    TextButton(
                      onPressed: () {
                        hideDialog();
                      },
                      child: TextWidget(text: 'NOT NOW'),
                    ),
                    TextButton(
                      onPressed: () {
                        hideDialog();
                      },
                      child: TextWidget(text: 'Update'),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );

    overlay.insert(overlayEntry);
    _animationController.forward();
    Future.delayed(Duration(seconds: 5), () {
      hideDialog();
    });
  }

  void hideDialog() {
    _animationController.reverse().then((_) {
      overlayEntry.remove();
    });
  }
}
