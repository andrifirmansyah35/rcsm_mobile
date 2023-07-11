import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:mobile_app/app/app_injector.dart';
import 'package:mobile_app/common/constants.dart';
import 'package:mobile_app/models/response/service_category_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'service_category_state.dart';

class ServiceCategoryCubit extends Cubit<ServiceCategoryState> {
  ServiceCategoryCubit() : super(ServiceCategoryInitial());

  Future<void> fetchData() async {
    emit(ServiceCategoryLoading());
    try {
      final uri = Uri.parse('${Constants.apiBaseUrl}/kategori-layanan-all');
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
        final result = ServiceCategoryResponseModel.fromJson(
          jsonDecode(response.body),
        );
        emit(ServiceCategorySuccess(result.kategoriLayanan));
      }
    } on SocketException {
      emit(
        const ServiceCategoryFailed(
            'Tidak dapat terhubung. Mohon periksa ulang koneksi kamu'),
      );
    } catch (e) {
      emit(
        ServiceCategoryFailed(e.toString()),
      );
    }
  }
}
