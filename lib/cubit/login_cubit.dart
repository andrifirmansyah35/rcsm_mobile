import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:mobile_app/app/app_injector.dart';
import 'package:mobile_app/common/constants.dart';
import 'package:mobile_app/models/request/login_body.dart';
import 'package:mobile_app/models/response/default_model.dart';
import 'package:mobile_app/models/response/login_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitial());

  Future<void> login(LoginBody body) async {
    emit(LoginLoading());
    log(body.toJson().toString());
    try {
      final uri = Uri.parse('${Constants.apiBaseUrl}/login');
      log(uri.toString());
      final response = await http.post(
        uri,
        body: body.toJson(),
        headers: {
          'Accept': 'application/json',
        },
      );
      if (response.statusCode == 200) {
        final result = LoginModel.fromJson(jsonDecode(response.body));
        final prefs = sl<SharedPreferences>();

        prefs.setString(Constants.keyToken, result.token);
        prefs.setString(Constants.keyMemberName, result.user.name);
        prefs.setString(Constants.keyMemberEmail, result.user.email);

        emit(LoginSuccess(
          LoginModel.fromJson(jsonDecode(response.body)),
        ));
      } else if (response.statusCode == 401) {
        final result = DefaultModel.fromJson(jsonDecode(response.body));
        emit(LoginFailed(result.message));
      } else {
        emit(LoginFailed('Gagal terhubung ke Server'));
      }
    } on SocketException {
      emit(
        LoginFailed('Tidak dapat terhubung. Mohon periksa ulang koneksi kamu'),
      );
    } catch (e) {
      log(e.toString());
      log(body.toJson().toString());
      emit(
        LoginFailed(e.toString()),
      );
    }
  }
}
