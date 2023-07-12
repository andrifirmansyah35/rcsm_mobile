import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:mobile_app/app/app_injector.dart';
import 'package:mobile_app/common/constants.dart';
import 'package:mobile_app/models/response/list_service_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'list_service_state.dart';

class ListServiceCubit extends Cubit<ListServiceState> {
  ListServiceCubit() : super(ListServiceInitial());

  Future<void> fetchData(String slug) async {
    emit(ListServiceLoading());
    try {
      final uri = Uri.parse(
        '${Constants.apiBaseUrl}/kategori-layanan-layanan-all?slug_kategori=$slug',
      );
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
        final result = ListServiceModel.fromJson(
          jsonDecode(response.body),
        );
        emit(ListServiceSuccess(result.layananAll));
      }
    } on SocketException {
      emit(
        const ListServiceFailed(
            'Tidak dapat terhubung. Mohon periksa ulang koneksi kamu'),
      );
    } catch (e) {
      emit(
        ListServiceFailed(e.toString()),
      );
    }
  }
}
