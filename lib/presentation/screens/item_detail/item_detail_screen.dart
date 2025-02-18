import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:logic_app/core/constants/app_colors.dart';
import 'package:logic_app/core/constants/app_space.dart';
import 'package:logic_app/core/helper/helper.dart';
import 'package:logic_app/presentation/screens/item_detail/item_detail_cubit.dart';
import 'package:logic_app/presentation/screens/item_detail/item_detail_state.dart';
import 'package:logic_app/presentation/widgets/app_bar_widget.dart';
import 'package:logic_app/presentation/widgets/button_widget.dart';
import 'package:logic_app/presentation/widgets/carousel_slider_widget.dart';
import 'package:logic_app/presentation/widgets/catch_image_network_widget.dart';
import 'package:logic_app/presentation/widgets/text_widget.dart';

class ItemDetailScreen extends StatefulWidget {
  const ItemDetailScreen({super.key, required this.parameters});
  final Map<String, dynamic> parameters;
  @override
  ItemDetailScreenState createState() => ItemDetailScreenState();
}

class ItemDetailScreenState extends State<ItemDetailScreen> {
  final screenCubit = ItemDetailCubit();
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

  final List<dynamic> priceDetails = [
    {
      'title': 'Base Price',
      'description':
          "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley",
    },
    {
      'title': 'Discount Price',
      'description':
          "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley",
    },
    {
      'title': 'Tax/VAT',
      'description':
          "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley",
    },
  ];
  @override
  void initState() {
    screenCubit.loadInitialData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppbarWidget(
        title: 'item_details'.tr,
      ),
      body: BlocConsumer<ItemDetailCubit, ItemDetailState>(
        bloc: screenCubit,
        listener: (BuildContext context, ItemDetailState state) {
          if (state.error != null) {
            // TODO your code here
          }
        },
        builder: (BuildContext context, ItemDetailState state) {
          if (state.isLoading) {
            return Center(child: CircularProgressIndicator());
          }

          return buildBody(state);
        },
      ),
    );
  }

  Widget buildBody(ItemDetailState state) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CarouselSliderWidget(
            height: 400,
            records: itemPictures,
            isLoading: false,
          ),
          Padding(
            padding: EdgeInsets.all(appPedding.scale),
            child: Column(
              spacing: appSpace.scale,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    TextWidget(
                      text: 'Mockup',
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                    ),
                    Text.rich(
                      TextSpan(
                        children: [
                          TextSpan(
                            text: '19.00\$ ',
                            style: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 20.scale,
                              color: primary,
                            ),
                          ),
                          TextSpan(
                            text: '20.00\$',
                            style: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 20.scale,
                              color: textColor,
                              decoration: TextDecoration.lineThrough,
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
                Row(
                  children: [
                    RatingBarIndicator(
                      itemSize: 20.scale,
                      rating: 4.5,
                      itemBuilder: (context, index) => Icon(
                        Icons.star,
                        color: appYellow,
                      ),
                    ),
                    TextWidget(
                      text: '(56 Reviews)',
                      fontSize: 12.scale,
                      color: textColor,
                    ),
                    Spacer(),
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: appSpace.scale,
                        vertical: 5.scale,
                      ),
                      decoration: BoxDecoration(
                        color: primary.withOpacity(0.3),
                        borderRadius: BorderRadius.circular(appRadius.scale),
                      ),
                      child: TextWidget(
                        text: '-20%',
                        color: primary,
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
                ButtonWidget(
                  title: 'add_to_cart'.tr,
                  onPressed: () {
                    // TODO your code here
                  },
                ),
                ExpansionTile(
                  tilePadding: EdgeInsets.zero,
                  backgroundColor: appWhite,
                  title: TextWidget(
                    text: 'description'.tr,
                    fontSize: 18.scale,
                    fontWeight: FontWeight.w700,
                  ),
                  initiallyExpanded: true,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.zero,
                  ),
                  iconColor: primary,
                  children: [
                    TextWidget(
                        text:
                            "Lorem Ipsum គឺជាអត្ថបទមិនពិតនៃឧស្សាហកម្មបោះពុម្ព និងវាយអក្សរ។ Lorem Ipsum គឺជាអត្ថបទអត់ចេះសោះស្តង់ដាររបស់ឧស្សាហកម្មតាំងពីទសវត្សរ៍ឆ្នាំ 1500 នៅពេលដែលម៉ាស៊ីនបោះពុម្ពមិនស្គាល់មួយបានយកប្រភេទសៀវភៅមួយប្រភេទ ហើយច្របល់វាដើម្បីបង្កើតសៀវភៅគំរូ។ វាបានរស់រានមានជីវិតមិនត្រឹមតែប្រាំសតវត្សប៉ុណ្ណោះទេ ប៉ុន្តែវាក៏ជាការលោតផ្លោះចូលទៅក្នុងការវាយអក្សរអេឡិចត្រូនិចផងដែរ ដែលនៅតែមិនផ្លាស់ប្តូរ។ វាត្រូវបានពេញនិយមនៅក្នុងទសវត្សរ៍ឆ្នាំ 1960 ជាមួយនឹងការចេញផ្សាយសន្លឹក Letraset ដែលមាន Lorem Ipsum passages ហើយថ្មីៗនេះជាមួយនឹងកម្មវិធីបោះពុម្ពលើតុដូចជា Aldus PageMaker រួមទាំងកំណែរបស់ Lorem Ipsum ផងដែរ។"),
                    SizedBox(height: appSpace.scale),
                    TextWidget(
                      text:
                          "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.",
                    )
                  ],
                ),
                TextWidget(
                  text: 'merchant_informaiton'.tr,
                  fontSize: 18.scale,
                  fontWeight: FontWeight.w700,
                ),
                SizedBox(
                  height: 170.scale,
                  child: Stack(
                    children: [
                      CatchImageNetworkWidget(
                        height: 120.scale,
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
                              // fontSize: 10.scale,
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextWidget(
                      text: 'product_reviews'.tr,
                      fontSize: 18.scale,
                      fontWeight: FontWeight.w700,
                    ),
                    TextButton(
                      onPressed: () {
                        //TODO:
                      },
                      child: TextWidget(
                        text: 'view_more'.tr,
                        color: primary,
                        decoration: TextDecoration.underline,
                      ),
                    )
                  ],
                ),
                ExpansionTile(
                  tilePadding: EdgeInsets.zero,
                  backgroundColor: appWhite,
                  title: TextWidget(
                    text: 'product_details'.tr,
                    fontSize: 18.scale,
                    fontWeight: FontWeight.w700,
                  ),
                  initiallyExpanded: true,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.zero,
                  ),
                  iconColor: primary,
                  children: itemPictures.map((e) {
                    return CatchImageNetworkWidget(
                      width: double.infinity,
                      height: 400.scale,
                      boxFit: BoxFit.cover,
                      imageUrl: e['picture'],
                      blurHash: e['pictureHash'],
                    );
                  }).toList(),
                ),
                ExpansionTile(
                  tilePadding: EdgeInsets.zero,
                  backgroundColor: appWhite,
                  title: TextWidget(
                    text: 'price_details'.tr,
                    fontSize: 18.scale,
                    fontWeight: FontWeight.w700,
                  ),
                  initiallyExpanded: true,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.zero,
                  ),
                  iconColor: primary,
                  children: priceDetails.map((e) {
                    return Padding(
                      padding: EdgeInsets.only(bottom: appSpace.scale),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            spacing: appSpace.scale,
                            children: [
                              Icon(Icons.circle, size: 12.scale),
                              TextWidget(
                                text: e['title'],
                                fontSize: 14.scale,
                                fontWeight: FontWeight.w500,
                              ),
                            ],
                          ),
                          SizedBox(height: 5.scale),
                          TextWidget(
                            text: e['description'],
                            fontSize: 12.scale,
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
