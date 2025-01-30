import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logic_app/core/helper/helper.dart';
import 'package:logic_app/presentation/screens/home/home_cubit.dart';
import 'package:logic_app/presentation/screens/home/home_state.dart';
import 'package:logic_app/presentation/widgets/app_bar_widget.dart';
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
      appBar: AppbarWidget(),
      body: BlocConsumer<HomeCubit, HomeState>(
        bloc: screenCubit,
        listener: (BuildContext context, HomeState state) {
          if (state.error != null) {
            // TODO your code here
          }
        },
        builder: (BuildContext context, HomeState state) {
          // if (state.isLoading) {
          //   return Center(child: CircularProgressIndicator());
          // }

          return buildBody(state);
        },
      ),
    );
  }

  Widget buildBody(HomeState state) {
    return Center(
      child: ElevatedButton(
        onPressed: () {
          showDialogUpdate();
        },
        child: Text('get photo'),
      ),
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
