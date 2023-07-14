import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:mobile_app/app/app_injector.dart';
import 'package:mobile_app/common/constants.dart';
import 'package:mobile_app/models/request/schedule_check_body.dart';
import 'package:mobile_app/models/response/schedule_check_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'schedule_check_state.dart';

class ScheduleCheckCubit extends Cubit<ScheduleCheckState> {
  ScheduleCheckCubit() : super(ScheduleCheckInitial());

  Future<void> fetchData(ScheduleCheckBody body) async {
    emit(ScheduleCheckLoading());
    try {
      final uri = Uri.parse(
        '${Constants.apiBaseUrl}/cari-jadwal-operasi',
      );
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
        final result = ScheduleCheckModel.fromJson(
          jsonDecode(response.body),
        );
        if (result.message == 'success') {
          emit(ScheduleCheckSuccess(result.operasional));
        } else {
          emit(ScheduleCheckFailed(result.message));
        }
      }
    } on SocketException {
      emit(
        const ScheduleCheckFailed(
            'Tidak dapat terhubung. Mohon periksa ulang koneksi kamu'),
      );
    } catch (e) {
      emit(
        ScheduleCheckFailed(e.toString()),
      );
    }
  }
}
