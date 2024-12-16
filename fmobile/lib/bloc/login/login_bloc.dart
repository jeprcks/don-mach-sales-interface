import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fmobile/bloc/login/login_event.dart';
import 'package:fmobile/bloc/login/login_state.dart';
import 'package:fmobile/repositories/login_repository.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final LoginRepository repository;
  final _secureStorage = const FlutterSecureStorage();

  LoginBloc({required this.repository}) : super(LoginInitial()) {
    on<LoginSubmitted>((event, emit) async {
      emit(LoginLoading());
      try {
        final response = await repository.login(event.username, event.password);

        // Store the token and user data
        final token = response['token'];
        final userData = response['user'];

        if (token == null || userData == null || userData['id'] == null) {
          throw Exception('Missing required data');
        }

        await _secureStorage.write(key: 'token', value: token);
        await _secureStorage.write(
            key: 'userId', value: userData['id'].toString());

        emit(LoginSuccess());
      } catch (e) {
        emit(LoginFailure(error: e.toString()));
      }
    });
  }
}
