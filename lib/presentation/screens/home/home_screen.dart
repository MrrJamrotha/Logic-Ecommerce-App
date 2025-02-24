import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logic_app/core/constants/app_enum.dart';
import 'package:logic_app/core/constants/app_space.dart';
import 'package:logic_app/core/helper/helper.dart';
import 'package:logic_app/presentation/screens/brand/brand_screen.dart';
import 'package:logic_app/presentation/screens/fetching_items/fetching_items_screen.dart';
import 'package:logic_app/presentation/screens/home/home_cubit.dart';
import 'package:logic_app/presentation/screens/home/home_state.dart';
import 'package:logic_app/presentation/screens/setting/setting_cubit.dart';
import 'package:logic_app/presentation/widgets/app_bar_widget.dart';
import 'package:logic_app/presentation/widgets/carousel_slider_widget.dart';
import 'package:logic_app/presentation/widgets/list_category_and_brand_widget.dart';
import 'package:logic_app/presentation/widgets/list_product_horizontal_widget.dart';
import 'package:logic_app/presentation/widgets/row_view_more_widget.dart';
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
        final List<dynamic> slideShowModels = state.slideShowModels
                ?.map((e) => {
                      'picture': e.picture,
                      'pictureHash': e.pictureHash,
                    })
                .toList() ??
            [];

        final categoryModels = state.categoryModels ?? [];
        final brandModels = state.brandModels ?? [];
        final recommendProducts = state.recommendProducts ?? [];
        final newArrivals = state.newArrivals ?? [];
        final bastReviewProducts = state.bastReviewProducts ?? [];
        final specialProducts = state.specialProducts ?? [];
        return SingleChildScrollView(
          padding: EdgeInsets.all(appPedding.scale),
          child: Column(
            spacing: appPedding.scale,
            children: [
              if (slideShowModels.isNotEmpty)
                CarouselSliderWidget(
                  borderRadius: BorderRadius.circular(appRadius.scale),
                  records: slideShowModels,
                  isLoading: state.isLoadingSlideShow,
                ),
              if (categoryModels.isNotEmpty)
                RowViewMoreWidget(
                  title: 'browse_categories'.tr,
                  onTap: () {
                    context.read<SettingCubit>().onPageChanged(1);
                  },
                  child: ListCategoryAndBrandWidget(
                    records: categoryModels,
                    listProductType: ListProductType.category,
                  ),
                ),
              if (brandModels.isNotEmpty)
                RowViewMoreWidget(
                  title: 'popular_brands'.tr,
                  onTap: () {
                    Navigator.pushNamed(context, BrandScreen.routeName);
                  },
                  child: ListCategoryAndBrandWidget(
                    records: brandModels,
                    listProductType: ListProductType.brand,
                  ),
                ),
              if (slideShowModels.isNotEmpty)
                CarouselSliderWidget(
                  borderRadius: BorderRadius.circular(appRadius.scale),
                  records: slideShowModels,
                  isLoading: state.isLoadingSlideShow,
                ),
              if (recommendProducts.isNotEmpty)
                RowViewMoreWidget(
                  title: 'recommend_for_you'.tr,
                  onTap: () {
                    Navigator.pushNamed(context, FetchingItemsScreen.routeName,
                        arguments: {
                          'title': 'recommend_for_you'.tr,
                          'type': FetchingType.recommented,
                        });
                  },
                  child: ListProductHorizontalWidget(
                    records: recommendProducts,
                    isLoading: state.isLoadingRecommend,
                  ),
                ),
              if (bastReviewProducts.isNotEmpty)
                RowViewMoreWidget(
                  title: 'bast_seller'.tr,
                  onTap: () {
                    Navigator.pushNamed(context, FetchingItemsScreen.routeName,
                        arguments: {
                          'title': 'bast_seller'.tr,
                          'type': FetchingType.baseSeller,
                        });
                  },
                  child: ListProductHorizontalWidget(
                    records: bastReviewProducts,
                    isLoading: state.isLoadingBastReview,
                  ),
                ),
              if (newArrivals.isNotEmpty)
                RowViewMoreWidget(
                  title: 'new_arrival'.tr,
                  onTap: () {
                    Navigator.pushNamed(context, FetchingItemsScreen.routeName,
                        arguments: {
                          'title': 'new_arrival'.tr,
                          'type': FetchingType.newArrival,
                        });
                  },
                  child: ListProductHorizontalWidget(
                    records: newArrivals,
                    isLoading: state.isLoadingNewArrival,
                  ),
                ),
              if (specialProducts.isNotEmpty)
                RowViewMoreWidget(
                  title: 'spacial_offers'.tr,
                  onTap: () {
                    Navigator.pushNamed(context, FetchingItemsScreen.routeName,
                        arguments: {
                          'title': 'spacial_offers'.tr,
                          'type': FetchingType.spacialOffers,
                        });
                  },
                  child: ListProductHorizontalWidget(
                    records: specialProducts,
                    isLoading: state.isLoadingSpecialProducts,
                  ),
                ),
            ],
          ),
        );
      },
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
