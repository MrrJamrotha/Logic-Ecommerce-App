import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logic_app/core/constants/app_colors.dart';
import 'package:logic_app/core/constants/app_space.dart';
import 'package:logic_app/core/helper/helper.dart';
import 'package:logic_app/presentation/screens/merchant_profile/merchant_profile_cubit.dart';
import 'package:logic_app/presentation/screens/merchant_profile/merchant_profile_state.dart';
import 'package:logic_app/presentation/widgets/app_bar_widget.dart';
import 'package:logic_app/presentation/widgets/catch_image_network_widget.dart';
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
    screenCubit.loadInitialData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppbarWidget(title: 'merchant_profile'.tr),
      body: BlocConsumer<MerchantProfileCubit, MerchantProfileState>(
        bloc: screenCubit,
        listener: (BuildContext context, MerchantProfileState state) {
          if (state.error != null) {
            // TODO your code here
          }
        },
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
    return DefaultTabController(
      length: 4,
      child: CustomScrollView(
        slivers: [
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
                          blurHash: 'LGF5?xYk^6#M@-5c,1J5@[or[Q6.',
                          borderRadius: BorderRadius.circular(appRadius.scale),
                          boxFit: BoxFit.cover,
                          imageUrl:
                              'https://nmgprod.s3.amazonaws.com/media/files/07/43/0743bf736dcdc851e878d77c6635bdc5/cover_image.jpg',
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
                                blurHash: 'LGF5?xYk^6#M@-5c,1J5@[or[Q6.',
                                borderRadius: BorderRadius.circular(100.scale),
                                boxFit: BoxFit.cover,
                                imageUrl:
                                    'https://t4.ftcdn.net/jpg/02/79/66/93/360_F_279669366_Lk12QalYQKMczLEa4ySjhaLtx1M2u7e6.jpg',
                              ),
                              TextWidget(
                                text: 'Merchant name',
                                fontWeight: FontWeight.w600,
                                fontSize: 18,
                                // fontSize: 10.scale,
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
                minHeight: 80.scale,
                maxHeight: 80.scale,
                child: TabBar(
                  indicatorColor: primary,
                  unselectedLabelColor: appBlack,
                  labelColor: primary,
                  tabs: [
                    Tab(text: 'new'.tr),
                    Tab(text: 'top_sale'.tr),
                    Tab(text: 'promotions'.tr),
                    Tab(text: 'bast_match'.tr),
                  ],
                )),
          ),
          SliverFillRemaining(
            child: TabBarView(
              controller: _tabContoller,
              children: [],
            ),
          ),
        ],
      ),
    );
  }
}
