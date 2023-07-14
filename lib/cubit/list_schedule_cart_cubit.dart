import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:mobile_app/app/app_injector.dart';
import 'package:mobile_app/common/constants.dart';
import 'package:mobile_app/models/response/schedule_cart_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'list_schedule_cart_state.dart';

class ListScheduleCartCubit extends Cubit<ListScheduleCartState> {
  ListScheduleCartCubit() : super(ListScheduleCartInitial());

  Future<void> fetchData() async {
    emit(ListScheduleCartLoading());
    try {
      final uri = Uri.parse('${Constants.apiBaseUrl}/keranjang-operasi-user');
      final token = sl<SharedPreferences>().getString(Constants.keyToken);

      final response = await http.get(
        uri,
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );
      log(response.body);
      if (response.statusCode == 200) {
        final result = ListScheduleCartModel.fromJson(
          jsonDecode(response.body),
        );
        emit(ListScheduleCartSuccess(result));
      }
    } on SocketException {
      emit(
        const ListScheduleCartFailed(
            'Tidak dapat terhubung. Mohon periksa ulang koneksi kamu'),
      );
    } catch (e) {
      emit(ListScheduleCartFailed(e.toString()));
    }
  }
}
