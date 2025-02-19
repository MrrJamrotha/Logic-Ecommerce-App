import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logic_app/core/constants/app_colors.dart';
import 'package:logic_app/core/constants/app_space.dart';
import 'package:logic_app/core/helper/helper.dart';
import 'package:logic_app/presentation/screens/review_product/review_product_cubit.dart';
import 'package:logic_app/presentation/screens/review_product/review_product_state.dart';
import 'package:logic_app/presentation/widgets/app_bar_widget.dart';
import 'package:logic_app/presentation/widgets/card_user_review.dart';
import 'package:logic_app/presentation/widgets/header_delegate_widget.dart';
import 'package:logic_app/presentation/widgets/text_widget.dart';

class ReviewProductScreen extends StatefulWidget {
  const ReviewProductScreen({super.key, required this.parameters});
  final Map<String, dynamic> parameters;
  @override
  ReviewProductScreenState createState() => ReviewProductScreenState();
}

class ReviewProductScreenState extends State<ReviewProductScreen> {
  final screenCubit = ReviewProductCubit();
  final List<dynamic> itemPictures = [
    {
      'picture':
          'https://retailminded.com/wp-content/uploads/2016/03/EN_GreenOlive-1.jpg',
      'pictureHash': 'LGF5?xYk^6#M@-5c,1J5@[or[Q6.',
    },
    {
      'picture':
          'https://plumgoodness.com/cdn/shop/files/MKD_01.jpg?v=1728452056&width=460',
      'pictureHash': 'LGF5?xYk^6#M@-5c,1J5@[or[Q6.',
    },
    {
      'picture':
          'https://down-ph.img.susercontent.com/file/ph-11134207-7qul3-lg1yu9p1oak855',
      'pictureHash': 'LGF5?xYk^6#M@-5c,1J5@[or[Q6.',
    },
    {
      'picture': 'https://pebblely.com/ideas/perfume/black-white.jpg',
      'pictureHash': 'LGF5?xYk^6#M@-5c,1J5@[or[Q6.',
    },
    {
      'picture':
          'https://d3pllp7nz3wmw5.cloudfront.net/product_images/26780234305-1_FULL.jpg',
      'pictureHash': 'LGF5?xYk^6#M@-5c,1J5@[or[Q6.',
    }
  ];
  final _listStarts = [5, 4.5, 4, 3.5, 3, 2.5, 2, 1.5, 1];
  @override
  void initState() {
    screenCubit.loadInitialData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppbarWidget(title: 'review_product'.tr),
      body: BlocConsumer<ReviewProductCubit, ReviewProductState>(
        bloc: screenCubit,
        listener: (BuildContext context, ReviewProductState state) {
          if (state.error != null) {
            // TODO your code here
          }
        },
        builder: (BuildContext context, ReviewProductState state) {
          if (state.isLoading) {
            return Center(child: CircularProgressIndicator());
          }

          return buildBody(state);
        },
      ),
    );
  }

  Widget buildBody(ReviewProductState state) {
    return CustomScrollView(
      slivers: [
        SliverFloatingHeader(
          child: Column(
            children: [],
          ),
        ),
        SliverPersistentHeader(
          floating: true,
          pinned: true,
          delegate: HeaderDelegateWidget(
            minHeight: 60.scale,
            maxHeight: 60.scale,
            child: Container(
              color: appWhite,
              child: ListView.builder(
                padding: EdgeInsets.all(appPedding.scale),
                scrollDirection: Axis.horizontal,
                itemCount: _listStarts.length + 1,
                itemBuilder: (context, index) {
                  if (index == 0) {
                    return Padding(
                      padding: EdgeInsets.only(right: appSpace.scale),
                      child: OutlinedButton(
                        style: OutlinedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(appRadius.scale),
                        )),
                        onPressed: () {
                          //TODO
                        },
                        child: TextWidget(
                          text: 'all'.tr,
                          fontSize: 12.scale,
                          color: appBlack,
                        ),
                      ),
                    );
                  }
                  return Padding(
                    padding: EdgeInsets.only(right: appSpace.scale),
                    child: OutlinedButton(
                      style: OutlinedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(appRadius.scale),
                      )),
                      onPressed: () {
                        //TODO
                      },
                      child: TextWidget(
                        text: '${_listStarts[index - 1]} ${'star'.tr}',
                        fontSize: 12.scale,
                        color: appBlack,
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ),
        SliverPadding(
          padding: EdgeInsets.all(appPedding.scale),
          sliver: SliverList.builder(
            itemCount: 10,
            itemBuilder: (context, index) {
              return Padding(
                padding: EdgeInsets.only(bottom: appSpace.scale),
                child: CardUserReview(pictures: []),
              );
            },
          ),
        )
      ],
    );
  }
}
