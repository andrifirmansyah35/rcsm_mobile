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

part 'delete_service_cart_state.dart';

class DeleteServiceCartCubit extends Cubit<DeleteServiceCartState> {
  DeleteServiceCartCubit() : super(DeleteServiceCartInitial());

  Future<void> fetchData(int id) async {
    emit(DeleteServiceCartLoading());
    try {
      final body = <String, dynamic>{
        'id_keranjang_layanan': id.toString(),
      };

      final uri = Uri.parse(
        '${Constants.apiBaseUrl}/keranjang-layanan-hapus-aktif',
      );
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
        emit(DeleteServiceCartSuccess(result));
      } else if (response.statusCode == 400) {
        final result = DefaultResponseModel.fromJson(
          jsonDecode(response.body),
        );
        emit(DeleteServiceCartFailed(result.message));
      } else {
        emit(const DeleteServiceCartFailed('Server sedang bermasalah'));
      }
    } on SocketException {
      emit(
        const DeleteServiceCartFailed(
            'Tidak dapat terhubung. Mohon periksa ulang koneksi kamu'),
      );
    } catch (e) {
      emit(
        DeleteServiceCartFailed(e.toString()),
      );
    }
  }
}
