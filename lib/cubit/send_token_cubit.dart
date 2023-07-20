import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:mobile_app/app/app_injector.dart';
import 'package:mobile_app/common/constants.dart';
import 'package:mobile_app/models/response/default_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'send_token_state.dart';

class SendTokenCubit extends Cubit<SendTokenState> {
  SendTokenCubit() : super(SendTokenInitial());

  Future<void> fetchData(String email) async {
    emit(SendTokenLoading());
    try {
      final uri = Uri.parse('${Constants.apiBaseUrl}/send-token-lupa-password');
      final token = sl<SharedPreferences>().getString(Constants.keyToken);

      final body = {'email': email};

      final response = await http.post(
        uri,
        body: body,
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
        emit(SendTokenSuccess(result));
      } else if (response.statusCode == 400) {
        final result = DefaultResponseModel.fromJson(
          jsonDecode(response.body),
        );
        emit(SendTokenFailed(result.message));
      } else {
        emit(const SendTokenFailed('Server sedang bermasalah'));
      }
    } on SocketException {
      emit(
        const SendTokenFailed(
            'Tidak dapat terhubung. Mohon periksa ulang koneksi kamu'),
      );
    } catch (e) {
      emit(
        SendTokenFailed(e.toString()),
      );
    }
  }
}
