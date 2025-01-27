import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:logic_app/presentation/screens/home/home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeState(isLoading: true));
}
