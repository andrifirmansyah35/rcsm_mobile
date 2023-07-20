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

part 'delete_schedule_cart_state.dart';

class DeleteScheduleCartCubit extends Cubit<DeleteScheduleCartState> {
  DeleteScheduleCartCubit() : super(DeleteScheduleCartInitial());

  Future<void> fetchData(int id) async {
    emit(DeleteScheduleCartLoading());
    try {
      final body = {
        'id_keranjang_operasi': id.toString(),
      };

      final uri = Uri.parse('${Constants.apiBaseUrl}/keranjang-operasi-hapus');
      final token = sl<SharedPreferences>().getString(Constants.keyToken);

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
        emit(DeleteScheduleCartSuccess(result));
      } else if (response.statusCode == 400) {
        final result = DefaultResponseModel.fromJson(
          jsonDecode(response.body),
        );
        emit(DeleteScheduleCartFailed(result.message));
      } else {
        emit(const DeleteScheduleCartFailed('Server sedang bermasalah'));
      }
    } on SocketException {
      emit(
        const DeleteScheduleCartFailed(
            'Tidak dapat terhubung. Mohon periksa ulang koneksi kamu'),
      );
    } catch (e) {
      emit(
        DeleteScheduleCartFailed(e.toString()),
      );
    }
  }
}
