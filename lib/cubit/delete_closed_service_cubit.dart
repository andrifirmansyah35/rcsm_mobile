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

part 'delete_closed_service_state.dart';

class DeleteClosedServiceCubit extends Cubit<DeleteClosedServiceState> {
  DeleteClosedServiceCubit() : super(DeleteClosedServiceInitial());

  Future<void> fetchData() async {
    emit(DeleteClosedServiceLoading());
    try {
      final uri = Uri.parse(
          '${Constants.apiBaseUrl}/keranjang-layanan-hapus-non-aktif');
      final token = sl<SharedPreferences>().getString(Constants.keyToken);

      final response = await http.post(
        uri,
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
        emit(DeleteClosedServiceSuccess(result));
      } else if (response.statusCode == 400) {
        final result = DefaultResponseModel.fromJson(
          jsonDecode(response.body),
        );
        emit(DeleteClosedServiceFailed(result.message));
      } else {
        emit(const DeleteClosedServiceFailed('Server sedang bermasalah'));
      }
    } on SocketException {
      emit(
        const DeleteClosedServiceFailed(
            'Tidak dapat terhubung. Mohon periksa ulang koneksi kamu'),
      );
    } catch (e) {
      emit(
        DeleteClosedServiceFailed(e.toString()),
      );
    }
  }
}
