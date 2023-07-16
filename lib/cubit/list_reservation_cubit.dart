import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:mobile_app/app/app_injector.dart';
import 'package:mobile_app/common/constants.dart';
import 'package:mobile_app/models/response/list_reservation_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'list_reservation_state.dart';

class ListReservationCubit extends Cubit<ListReservationState> {
  ListReservationCubit() : super(ListReservationInitial());

  Future<void> fetchData() async {
    emit(ListReservationLoading());
    try {
      final uri = Uri.parse('${Constants.apiBaseUrl}/reservasi-user-daftar');
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
        final result = ListReservationModel.fromJson(
          jsonDecode(response.body),
        );
        emit(ListReservationSuccess(result));
      } else {
        emit(const ListReservationFailed(
          'Gagal mendapatkan data Reservasi. Coba lagi.',
        ));
      }
    } on SocketException {
      emit(
        const ListReservationFailed(
            'Tidak dapat terhubung. Mohon periksa ulang koneksi kamu'),
      );
    } catch (e) {
      emit(ListReservationFailed(e.toString()));
    }
  }
}
