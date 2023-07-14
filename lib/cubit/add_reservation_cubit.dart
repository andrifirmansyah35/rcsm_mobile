import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:mobile_app/app/app_injector.dart';
import 'package:mobile_app/common/constants.dart';
import 'package:mobile_app/models/request/reservation_body.dart';
import 'package:mobile_app/models/response/default_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'add_reservation_state.dart';

class AddReservationCubit extends Cubit<AddReservationState> {
  AddReservationCubit() : super(AddReservationInitial());

  Future<void> fetchData(ReservationBody body) async {
    emit(AddReservationLoading());
    try {
      final uri = Uri.parse('${Constants.apiBaseUrl}/reservasi-tambah');
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
        if (result.status == 'success') {
          emit(AddReservationSuccess(result));
        } else {
          emit(AddReservationFailed(result.message));
        }
      } else {
        emit(const AddReservationFailed('Server sedang bermasalah'));
      }
    } on SocketException {
      emit(
        const AddReservationFailed(
            'Tidak dapat terhubung. Mohon periksa ulang koneksi kamu'),
      );
    } catch (e) {
      emit(
        AddReservationFailed(e.toString()),
      );
    }
  }
}
