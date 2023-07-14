import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:mobile_app/app/app_injector.dart';
import 'package:mobile_app/common/constants.dart';
import 'package:mobile_app/models/request/schedule_cart_body.dart';
import 'package:mobile_app/models/response/add_schedule_cart_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'add_schedule_cart_state.dart';

class AddScheduleCartCubit extends Cubit<AddScheduleCartState> {
  AddScheduleCartCubit() : super(AddScheduleCartInitial());

  Future<void> fetchData(String idOperasi) async {
    emit(AddScheduleCartLoading());
    try {
      final uri = Uri.parse('${Constants.apiBaseUrl}/keranjang-operasi-tambah');
      final token = sl<SharedPreferences>().getString(Constants.keyToken);

      final response = await http.post(
        uri,
        body: ScheduleCartBody(idOperasi: idOperasi).toJson(),
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );
      log(response.body);
      if (response.statusCode == 200) {
        final result = AddScheduleCartModel.fromJson(
          jsonDecode(response.body),
        );
        if (result.status == 'success') {
          emit(AddScheduleCartSuccess(result));
        } else {
          emit(AddScheduleCartFailed(result.message));
        }
      } else {
        emit(const AddScheduleCartFailed('Server sedang bermasalah'));
      }
    } on SocketException {
      emit(
        const AddScheduleCartFailed(
            'Tidak dapat terhubung. Mohon periksa ulang koneksi kamu'),
      );
    } catch (e) {
      emit(
        AddScheduleCartFailed(e.toString()),
      );
    }
  }
}
