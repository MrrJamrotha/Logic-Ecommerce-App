import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logic_app/core/helper/helper.dart';
import 'package:logic_app/presentation/screens/profile/profile_cubit.dart';
import 'package:logic_app/presentation/screens/profile/profile_state.dart';
import 'package:logic_app/presentation/widgets/app_bar_widget.dart';
import 'package:logic_app/presentation/widgets/catch_image_network_widget.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final screenCubit = ProfileCubit();

  @override
  void initState() {
    screenCubit.loadInitialData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppbarWidget(title: 'Account'.tr),
      body: BlocConsumer<ProfileCubit, ProfileState>(
        bloc: screenCubit,
        listener: (BuildContext context, ProfileState state) {
          if (state.error != null) {
            // TODO your code here
          }
        },
        builder: (BuildContext context, ProfileState state) {
          if (state.isLoading) {
            return Center(child: CircularProgressIndicator());
          }

          return buildBody(state);
        },
      ),
    );
  }

  Widget buildBody(ProfileState state) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Row(
            children: [
              CatchImageNetworkWidget(
                width: 120.scale,
                height: 120.scale,
                boxFit: BoxFit.cover,
                borderRadius: BorderRadius.circular(100.scale),
                imageUrl:
                    'https://sm.ign.com/t/ign_nordic/feature/t/the-avatar/the-avatar-the-last-airbender-trailer-gets-a-lot-right-but-w_tkwa.1200.jpg',
                blurHash: 'LEHV6nWB2yk8pyo0adR*.7kCMdnj',
              ),
            ],
          ),
        ],
      ),
    );
  }
}
