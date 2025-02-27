import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:logic_app/core/constants/app_colors.dart';
import 'package:logic_app/core/constants/app_enum.dart';
import 'package:logic_app/core/constants/app_icons.dart';
import 'package:logic_app/core/constants/app_space.dart';
import 'package:logic_app/core/helper/helper.dart';
import 'package:logic_app/core/helper/loading_overlay.dart';
import 'package:logic_app/data/models/user_model.dart';
import 'package:logic_app/presentation/screens/edit_profile/edit_profile_cubit.dart';
import 'package:logic_app/presentation/screens/edit_profile/edit_profile_state.dart';
import 'package:logic_app/presentation/widgets/app_bar_widget.dart';
import 'package:logic_app/presentation/widgets/button_widget.dart';
import 'package:logic_app/presentation/widgets/catch_image_network_widget.dart';
import 'package:logic_app/presentation/widgets/error_type_widget.dart';
import 'package:logic_app/presentation/widgets/icon_widget.dart';
import 'package:logic_app/presentation/widgets/text_form_field_widget.dart';
import 'package:logic_app/presentation/widgets/text_widget.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});
  static const routeName = 'edit_profile';

  @override
  EditProfileScreenState createState() => EditProfileScreenState();
}

class EditProfileScreenState extends State<EditProfileScreen> {
  final screenCubit = EditProfileCubit();
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();

  @override
  void initState() {
    _initData();
    super.initState();
  }

  _initData() async {
    await screenCubit.loadInitialData();
    final user = screenCubit.state.userModel;
    _nameController.text = user?.username ?? "";
    _emailController.text = user?.email ?? "";
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  Future<void> _updateUserProfile() async {
    try {
      if (_formKey.currentState!.validate()) {
        LoadingOverlay.show(context);
        final result = await screenCubit.updateUserProfile(parameters: {
          'username': _nameController.text.trim(),
          'file': screenCubit.state.xFile,
        });
        LoadingOverlay.hide();
        if (result) {
          if (!mounted) return;
          Navigator.pop(context, {'result': result});
        }
      }
    } catch (e) {
      LoadingOverlay.hide();
      Exception(e);
    }
  }

  _showModelChoiceCameraAndAlbums() {
    showModalBottomSheet(
      showDragHandle: true,
      backgroundColor: appWhite,
      context: context,
      builder: (context) {
        return Padding(
          padding: EdgeInsets.all(appPedding.scale),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                contentPadding: EdgeInsets.all(appSpace.scale),
                onTap: () {
                  Navigator.pop(context);
                  screenCubit.selectImage();
                },
                leading: IconWidget(
                  assetName: cameraSvg,
                  width: 24.scale,
                  height: 24.scale,
                ),
                title: TextWidget(text: 'camera'.tr),
              ),
              ListTile(
                contentPadding: EdgeInsets.all(appSpace.scale),
                onTap: () {
                  Navigator.pop(context);
                  screenCubit.selectImage(imageSource: ImageSource.gallery);
                },
                leading: IconWidget(
                  assetName: albumsSvg,
                  width: 24.scale,
                  height: 24.scale,
                ),
                title: TextWidget(text: 'albums'.tr),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppbarWidget(title: 'edit_profile'.tr),
      body: BlocBuilder<EditProfileCubit, EditProfileState>(
        bloc: screenCubit,
        builder: (BuildContext context, EditProfileState state) {
          if (state.isLoading) {
            return centerLoading();
          }

          return buildBody(state);
        },
      ),
      bottomNavigationBar:
          BlocSelector<EditProfileCubit, EditProfileState, UserModel?>(
        bloc: screenCubit,
        selector: (state) {
          return state.userModel;
        },
        builder: (context, state) {
          if (state == null) return SizedBox.shrink();
          return Padding(
            padding: EdgeInsets.all(appPedding.scale),
            child: ButtonWidget(
              title: 'save'.tr,
              onPressed: () => _updateUserProfile(),
            ),
          );
        },
      ),
    );
  }

  Widget buildBody(EditProfileState state) {
    final user = state.userModel;
    if (user == null) {
      return ErrorTypeWidget(type: ErrorType.notFound);
    }
    final path = state.xFile?.path ?? "";
    return SingleChildScrollView(
      padding: EdgeInsets.all(appPedding.scale),
      child: Form(
        key: _formKey,
        child: Column(
          spacing: appPedding.scale,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Stack(
                children: [
                  if (path.isNotEmpty)
                    Container(
                      width: 120.scale,
                      height: 120.scale,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                          image: FileImage(
                            File(path),
                          ),
                          filterQuality: FilterQuality.high,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  if (path.isEmpty)
                    CatchImageNetworkWidget(
                      width: 120.scale,
                      height: 120.scale,
                      boxFit: BoxFit.cover,
                      borderRadius: BorderRadius.circular(100.scale),
                      imageUrl: user.avatar,
                      blurHash: user.avatarHash,
                    ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: IconButton.filledTonal(
                      style: IconButton.styleFrom(
                        backgroundColor: unratedColor,
                      ),
                      onPressed: () => _showModelChoiceCameraAndAlbums(),
                      icon: IconWidget(
                        assetName: cameraSvg,
                        width: 24.scale,
                        height: 24.scale,
                      ),
                    ),
                  )
                ],
              ),
            ),
            TextFormFieldWidget(
              controller: _nameController,
              hintText: 'username'.tr,
              validator: (value) {
                if (value!.isEmpty) {
                  return 'enter_username'.tr;
                }
                return null;
              },
            ),
            TextFormFieldWidget(
              controller: _emailController,
              readOnly: true,
              hintText: 'email'.tr,
            ),
          ],
        ),
      ),
    );
  }
}
