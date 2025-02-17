import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:logic_app/core/constants/app_colors.dart';
import 'package:logic_app/core/constants/app_space.dart';
import 'package:logic_app/core/helper/helper.dart';
import 'package:logic_app/data/models/product_model.dart';
import 'package:logic_app/presentation/screens/home/home_cubit.dart';
import 'package:logic_app/presentation/screens/home/home_state.dart';
import 'package:logic_app/presentation/widgets/app_bar_widget.dart';
import 'package:logic_app/presentation/widgets/card_brand_widget.dart';
import 'package:logic_app/presentation/widgets/carousel_slider_widget.dart';
import 'package:logic_app/presentation/widgets/product_card_widget.dart';
import 'package:logic_app/presentation/widgets/text_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  static const routeName = 'home';
  static const routePath = '/home';

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
    loadInitialDatas();
    super.initState();
  }

  Future<void> loadInitialDatas() async {
    Future.wait([
      screenCubit.getSlideShow(parameters: {'display_type': 'NewProduct'}),
      screenCubit.getBrowseCategories(),
      screenCubit.getBrands(),
      screenCubit.getRecommendedForYou(),
      screenCubit.getProductNewArrivals(),
      screenCubit.getProductBastReview(),
      screenCubit.getSpacialProduct(),
    ]);
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
        final brandModels = state.brandModels ?? [];
        final recommendProducts = state.recommendProducts ?? [];
        final newArrivals = state.newArrivals ?? [];
        final bastReviewProducts = state.bastReviewProducts ?? [];
        final specialProducts = state.specialProducts ?? [];
        return SingleChildScrollView(
          padding: EdgeInsets.all(appPedding.scale),
          child: Column(
            spacing: 16.scale,
            children: [
              if (slideShowModels.isNotEmpty)
                CarouselSliderWidget(
                  records: slideShowModels,
                  isLoading: state.isLoadingSlideShow,
                ),
              if (categoryModels.isNotEmpty)
                _buildTitleRow(
                  title: 'browse_categories'.tr,
                  onTap: () {
                    context.pushNamed('home_fetching_item', extra: {
                      'title': 'browse_categories'.tr,
                    });
                  },
                  child: _listDatas(categoryModels),
                ),
              if (brandModels.isNotEmpty)
                _buildTitleRow(
                  title: 'popular_brands'.tr,
                  onTap: () {
                    //TODO: next time
                  },
                  child: _listDatas(brandModels),
                ),
              // _buildTitleRow(
              //   title: 'today_deals'.tr,
              //   onTap: () {
              //     //TODO: next time
              //   },
              // ),
              // _buildTitleRow(
              //   title: 'today_deals'.tr,
              //   onTap: () {
              //     //TODO: next time
              //   },
              // ),
              if (slideShowModels.isNotEmpty)
                CarouselSliderWidget(
                  records: slideShowModels,
                  isLoading: state.isLoadingSlideShow,
                ),
              if (recommendProducts.isNotEmpty)
                _buildTitleRow(
                  title: 'recommend_for_you'.tr,
                  onTap: () {
                    //TODO: next time
                  },
                  child: _buildListProducts(
                    recommendProducts,
                    state.isLoadingRecommend,
                  ),
                ),
              if (bastReviewProducts.isNotEmpty)
                _buildTitleRow(
                  title: 'bast_seller'.tr,
                  onTap: () {
                    //TODO: next time
                  },
                  child: _buildListProducts(
                    bastReviewProducts,
                    state.isLoadingBastReview,
                  ),
                ),
              if (newArrivals.isNotEmpty)
                _buildTitleRow(
                  title: 'new_arrival'.tr,
                  onTap: () {
                    //TODO: next time
                  },
                  child: _buildListProducts(
                    newArrivals,
                    state.isLoadingNewArrival,
                  ),
                ),
              if (specialProducts.isNotEmpty)
                _buildTitleRow(
                  title: 'spacial_offers'.tr,
                  onTap: () {
                    //TODO: next time
                  },
                  child: _buildListProducts(
                    specialProducts,
                    state.isLoadingSpecialProducts,
                  ),
                ),
            ],
          ),
        );
      },
    );
  }

  SizedBox _listDatas(List<dynamic> records) {
    return SizedBox(
      height: 125.scale,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: records.length,
        itemBuilder: (context, index) {
          final record = records[index];
          return Padding(
            padding: EdgeInsets.only(
              right: appSpace.scale,
              bottom: appSpace.scale,
              top: appSpace.scale,
            ),
            child: CardBrandWidget(
              picture: record.picture,
              pictureHash: record.pictureHash,
              title: record.name,
            ),
          );
        },
      ),
    );
  }

  SizedBox _buildListProducts(
    List<ProductModel> records,
    bool isLoading,
  ) {
    return SizedBox(
      height: 210.scale,
      child: ListView.builder(
        padding: EdgeInsets.symmetric(vertical: appSpace.scale),
        scrollDirection: Axis.horizontal,
        itemCount: records.length,
        itemBuilder: (context, index) {
          final record = records[index];
          return Padding(
            padding: EdgeInsets.only(right: appSpace.scale),
            child: ProductCardWidget(
              record: record,
              isLoading: isLoading,
            ),
          );
        },
      ),
    );
  }

  Widget _buildTitleRow({
    required String title,
    Function()? onTap,
    required Widget child,
  }) {
    return Column(
      children: [
        Row(
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
        ),
        child
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
