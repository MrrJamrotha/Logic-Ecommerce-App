import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logic_app/presentation/screens/home/home_cubit.dart';
import 'package:logic_app/presentation/screens/home/home_state.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  HomeScreenState createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  final screenCubit = HomeCubit();

  @override
  void initState() {
    screenCubit.loadInitialData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: Text('Logic'),
        actions: [
          IconButton(
            onPressed: () {
              //TODO:
            },
            icon: Icon(Icons.chat),
          ),
          IconButton(
            onPressed: () {
              //TODO:
            },
            icon: Icon(Icons.notifications),
          ),
          // IconButton(
          //   onPressed: () {
          //     //TODO:
          //   },
          //   icon: Icon(Icons),
          // ),
        ],
      ),
      body: BlocConsumer<HomeCubit, HomeState>(
        bloc: screenCubit,
        listener: (BuildContext context, HomeState state) {
          if (state.error != null) {
            // TODO your code here
          }
        },
        builder: (BuildContext context, HomeState state) {
          if (state.isLoading) {
            return Center(child: CircularProgressIndicator());
          }

          return buildBody(state);
        },
      ),
    );
  }

  Widget buildBody(HomeState state) {
    return ListView(
      children: [
        // TODO your code here
      ],
    );
  }
}
