import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logic_app/core/helper/helper.dart';
import 'package:logic_app/presentation/screens/chat/chat_cubit.dart';
import 'package:logic_app/presentation/screens/chat/chat_state.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final screenCubit = ChatCubit();

  @override
  void initState() {
    screenCubit.loadInitialData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<ChatCubit, ChatState>(
        bloc: screenCubit,
        listener: (BuildContext context, ChatState state) {
          if (state.error != null) {
            // TODO your code here
          }
        },
        builder: (BuildContext context, ChatState state) {
          if (state.isLoading) {
            return centerLoading();
          }

          return buildBody(state);
        },
      ),
    );
  }

  Widget buildBody(ChatState state) {
    return ListView(
      children: [
        // TODO your code here
      ],
    );
  }
}
