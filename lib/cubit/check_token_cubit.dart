import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:mobile_app/common/constants.dart';
import 'package:mobile_app/models/response/default_model.dart';

part 'check_token_state.dart';

class CheckTokenCubit extends Cubit<CheckTokenState> {
  CheckTokenCubit() : super(CheckTokenInitial());

  Future<void> fetchData(String token) async {
    emit(CheckTokenLoading());
    try {
      final uri = Uri.parse('${Constants.apiBaseUrl}/check-token');
      // final token = sl<SharedPreferences>().getString(Constants.keyToken);

      final body = {'token': token};

      final response = await http.post(
        uri,
        body: body,
        headers: {
          'Accept': 'application/json',
          // 'Authorization': 'Bearer $token',
        },
      );
      log(response.body);
      if (response.statusCode == 200) {
        final result = DefaultResponseModel.fromJson(
          jsonDecode(response.body),
        );
        emit(CheckTokenSuccess(result));
      } else if (response.statusCode == 400) {
        final result = DefaultResponseModel.fromJson(
          jsonDecode(response.body),
        );
        emit(CheckTokenFailed(result.message));
      } else {
        emit(const CheckTokenFailed('Server sedang bermasalah'));
      }
    } on SocketException {
      emit(
        const CheckTokenFailed(
            'Tidak dapat terhubung. Mohon periksa ulang koneksi kamu'),
      );
    } catch (e) {
      emit(
        CheckTokenFailed(e.toString()),
      );
    }
  }
}
