import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:mobile_app/common/constants.dart';
import 'package:mobile_app/models/request/request_new_password_body.dart';
import 'package:mobile_app/models/response/default_model.dart';

part 'request_new_password_state.dart';

class RequestNewPasswordCubit extends Cubit<RequestNewPasswordState> {
  RequestNewPasswordCubit() : super(RequestNewPasswordInitial());

  Future<void> fetchData(RequestNewPasswordBody body) async {
    emit(RequestNewPasswordLoading());
    try {
      final uri = Uri.parse(
        '${Constants.apiBaseUrl}/password-baru-dengan-token-konfirmasi',
      );

      final response = await http.post(
        uri,
        body: body.toJson(),
        headers: {
          'Accept': 'application/json',
        },
      );
      log(response.body);
      if (response.statusCode == 200) {
        final result = DefaultResponseModel.fromJson(
          jsonDecode(response.body),
        );
        emit(RequestNewPasswordSuccess(result));
      } else if (response.statusCode == 400) {
        final result = DefaultResponseModel.fromJson(
          jsonDecode(response.body),
        );
        emit(RequestNewPasswordFailed(result.message));
      } else {
        emit(const RequestNewPasswordFailed('Server sedang bermasalah'));
      }
    } on SocketException {
      emit(
        const RequestNewPasswordFailed(
            'Tidak dapat terhubung. Mohon periksa ulang koneksi kamu'),
      );
    } catch (e) {
      emit(
        RequestNewPasswordFailed(e.toString()),
      );
    }
  }
}
