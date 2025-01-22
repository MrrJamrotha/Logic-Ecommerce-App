import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logic_app/presentation/screens/chat_room/chat_room_cubit.dart';
import 'package:logic_app/presentation/screens/chat_room/chat_room_state.dart';

class ChatRoomScreen extends StatefulWidget {
	const ChatRoomScreen({Key? key}) : super(key: key);
	
	@override
	_ChatRoomScreenState createState() => _ChatRoomScreenState();
}
	
class _ChatRoomScreenState extends State<ChatRoomScreen> {
	final screenCubit = ChatRoomCubit();
	
	@override
	void initState() {
		screenCubit.loadInitialData();
		super.initState();
	}
	
	@override
	Widget build(BuildContext context) {
		return Scaffold(
			body: BlocConsumer<ChatRoomCubit, ChatRoomState>(
				bloc: screenCubit,
				listener: (BuildContext context, ChatRoomState state) {
					if (state.error != null) {
						// TODO your code here
					}
				},
				builder: (BuildContext context, ChatRoomState state) {
					if (state.isLoading) {
						return Center(child: CircularProgressIndicator());
					}
	
					return buildBody(state);
				},
			),
		);
	}
	
	Widget buildBody(ChatRoomState state) {
		return ListView(
			children: [
				// TODO your code here
			],
		);
	}
}
