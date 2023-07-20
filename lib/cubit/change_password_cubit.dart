import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:mobile_app/app/app_injector.dart';
import 'package:mobile_app/common/constants.dart';
import 'package:mobile_app/models/request/change_password_body.dart';
import 'package:mobile_app/models/response/default_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'change_password_state.dart';

class ChangePasswordCubit extends Cubit<ChangePasswordState> {
  ChangePasswordCubit() : super(ChangePasswordInitial());

  Future<void> fetchData(ChangePasswordBody body) async {
    emit(ChangePasswordLoading());
    try {
      final uri = Uri.parse(
          '${Constants.apiBaseUrl}/password-baru');
      final token = sl<SharedPreferences>().getString(Constants.keyToken);

      final response = await http.post(
        uri,
        body: body.toJson(),
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );
      log(response.body);
      if (response.statusCode == 200) {
        final result = DefaultResponseModel.fromJson(
          jsonDecode(response.body),
        );
        emit(ChangePasswordSuccess(result));
      } else if (response.statusCode == 400) {
        final result = DefaultResponseModel.fromJson(
          jsonDecode(response.body),
        );
        emit(ChangePasswordFailed(result.message));
      } else {
        emit(const ChangePasswordFailed('Server sedang bermasalah'));
      }
    } on SocketException {
      emit(
        const ChangePasswordFailed(
            'Tidak dapat terhubung. Mohon periksa ulang koneksi kamu'),
      );
    } catch (e) {
      emit(
        ChangePasswordFailed(e.toString()),
      );
    }
  }
}
