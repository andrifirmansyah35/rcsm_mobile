import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:mobile_app/app/app_injector.dart';
import 'package:mobile_app/common/constants.dart';
import 'package:mobile_app/models/request/slug_body.dart';
import 'package:mobile_app/models/response/add_service_cart_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'add_service_cart_state.dart';

class AddServiceCartCubit extends Cubit<AddServiceCartState> {
  AddServiceCartCubit() : super(AddServiceCartInitial());

  Future<void> fetchData(String slug) async {
    emit(AddServiceCartLoading());
    try {
      final uri = Uri.parse('${Constants.apiBaseUrl}/keranjang-layanan-tambah');
      final token = sl<SharedPreferences>().getString(Constants.keyToken);

      final response = await http.post(
        uri,
        body: SlugBody(slugLayanan: slug).toJson(),
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );
      log(response.body);
      if (response.statusCode == 200) {
        final result = AddServiceCartModel.fromJson(
          jsonDecode(response.body),
        );
        if (result.message == 'success') {
          emit(AddServiceCartSuccess(result));
        } else {
          emit(AddServiceCartFailed(result.alert));
        }
      } else {
        emit(const AddServiceCartFailed('Server sedang bermasalah'));
      }
    } on SocketException {
      emit(
        const AddServiceCartFailed(
            'Tidak dapat terhubung. Mohon periksa ulang koneksi kamu'),
      );
    } catch (e) {
      emit(
        AddServiceCartFailed(e.toString()),
      );
    }
  }
}
