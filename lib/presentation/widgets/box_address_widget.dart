import 'package:flutter/material.dart';
import 'package:foxShop/core/constants/app_colors.dart';
import 'package:foxShop/core/constants/app_space.dart';
import 'package:foxShop/core/helper/helper.dart';
import 'package:foxShop/data/models/address_model.dart';
import 'package:foxShop/presentation/widgets/box_widget.dart';
import 'package:foxShop/presentation/widgets/text_widget.dart';

class BoxAddressWidget extends StatelessWidget {
  const BoxAddressWidget({super.key, required this.record, this.onTap});
  final AddressModel record;
  final Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        BoxWidget(
          onTap: onTap,
          width: double.infinity,
          borderRadius: BorderRadius.circular(appRadius.scale),
          padding: EdgeInsets.all(appSpace.scale),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 5.scale,
            children: [
              TextWidget(
                text: record.type,
                fontWeight: FontWeight.w600,
              ),
              TextWidget(
                text: record.phoneNumber,
                fontSize: 12.scale,
              ),
              TextWidget(
                text: record.address,
                fontSize: 12.scale,
              ),
            ],
          ),
        ),
        if (record.isDefault)
          Positioned(
            top: 5.scale,
            right: 5.scale,
            child: Icon(
              Icons.check_circle,
              color: primary,
              size: 24.scale,
            ),
          )
      ],
    );
  }
}
