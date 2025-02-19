import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logic_app/core/constants/app_colors.dart';
import 'package:logic_app/core/constants/app_enum.dart';
import 'package:logic_app/core/constants/app_space.dart';
import 'package:logic_app/core/helper/helper.dart';
import 'package:logic_app/presentation/screens/merchant_profile/merchant_profile_cubit.dart';
import 'package:logic_app/presentation/screens/merchant_profile/merchant_profile_state.dart';
import 'package:logic_app/presentation/screens/merchant_profile/tabs/bast_match_tab.dart';
import 'package:logic_app/presentation/screens/merchant_profile/tabs/new_product_tab.dart';
import 'package:logic_app/presentation/screens/merchant_profile/tabs/promotion_product_tab.dart';
import 'package:logic_app/presentation/screens/merchant_profile/tabs/top_sale_tab.dart';
import 'package:logic_app/presentation/widgets/app_bar_widget.dart';
import 'package:logic_app/presentation/widgets/catch_image_network_widget.dart';
import 'package:logic_app/presentation/widgets/error_type_widget.dart';
import 'package:logic_app/presentation/widgets/header_delegate_widget.dart';
import 'package:logic_app/presentation/widgets/text_widget.dart';

class MerchantProfileScreen extends StatefulWidget {
  const MerchantProfileScreen({super.key, required this.parameters});
  final Map<String, dynamic> parameters;
  @override
  MerchantProfileScreenState createState() => MerchantProfileScreenState();
}

class MerchantProfileScreenState extends State<MerchantProfileScreen>
    with TickerProviderStateMixin {
  final screenCubit = MerchantProfileCubit();
  late TabController _tabContoller;
  @override
  void initState() {
    _tabContoller = TabController(length: 4, vsync: this);
    screenCubit.loadInitialData(parameters: {
      'merchant_id': 1,
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppbarWidget(title: 'merchant_profile'.tr),
      body: BlocBuilder<MerchantProfileCubit, MerchantProfileState>(
        bloc: screenCubit,
        builder: (BuildContext context, MerchantProfileState state) {
          if (state.isLoading) {
            return Center(child: CircularProgressIndicator());
          }

          return buildBody(state);
        },
      ),
    );
  }

  Widget buildBody(MerchantProfileState state) {
    var record = state.record;
    if (record == null) return ErrorTypeWidget(type: ErrorType.notFound);
    return DefaultTabController(
      length: 4,
      child: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) {
          return [
            SliverPadding(
              padding: EdgeInsets.all(appPedding.scale),
              sliver: SliverToBoxAdapter(
                child: Column(
                  spacing: appPedding.scale,
                  children: [
                    SizedBox(
                      height: 260.scale,
                      child: Stack(
                        children: [
                          CatchImageNetworkWidget(
                            height: 200.scale,
                            width: double.infinity,
                            blurHash: record.coverHash,
                            borderRadius:
                                BorderRadius.circular(appRadius.scale),
                            boxFit: BoxFit.cover,
                            imageUrl: record.cover,
                          ),
                          Positioned(
                            left: appPedding.scale,
                            bottom: 0,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              spacing: 5.scale,
                              children: [
                                CatchImageNetworkWidget(
                                  width: 80.scale,
                                  height: 80.scale,
                                  blurHash: record.avatarHash,
                                  borderRadius:
                                      BorderRadius.circular(100.scale),
                                  boxFit: BoxFit.cover,
                                  imageUrl: record.avatar,
                                ),
                                TextWidget(
                                  text: record.storeName,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 18,
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SliverPersistentHeader(
              pinned: true,
              floating: true,
              delegate: HeaderDelegateWidget(
                  minHeight: 45.scale,
                  maxHeight: 45.scale,
                  child: Container(
                    color: appWhite,
                    child: TabBar(
                      controller: _tabContoller,
                      indicatorColor: primary,
                      unselectedLabelColor: appBlack,
                      labelColor: primary,
                      tabs: [
                        Tab(text: 'new'.tr),
                        Tab(text: 'top_sale'.tr),
                        Tab(text: 'promotions'.tr),
                        Tab(text: 'bast_match'.tr),
                      ],
                    ),
                  )),
            ),
          ];
        },
        body: TabBarView(
          physics: NeverScrollableScrollPhysics(),
          controller: _tabContoller,
          children: [
            NewProductTab(),
            TopSaleTab(),
            PromotionProductTab(),
            BastMatchTab(),
          ],
        ),
      ),
    );
  }
}
