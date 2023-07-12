import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:mobile_app/app/app_injector.dart';
import 'package:mobile_app/common/constants.dart';
import 'package:mobile_app/cubit/list_service_cubit.dart';
import 'package:mobile_app/models/response/service_category_model.dart';
import 'package:mobile_app/pages/service_cart_page.dart';
import 'package:mobile_app/widgets/error_indicator.dart';
import 'package:mobile_app/widgets/service_card.dart';

class DetailServiceCategoryPage extends StatefulWidget {
  const DetailServiceCategoryPage({
    required this.data,
    Key? key,
  }) : super(key: key);

  final ServiceCategoryModel data;

  @override
  State<DetailServiceCategoryPage> createState() =>
      _DetailServiceCategoryState();
}

class _DetailServiceCategoryState extends State<DetailServiceCategoryPage> {
  final listServiceCubit = sl<ListServiceCubit>();

  void refresh() {
    listServiceCubit.fetchData(widget.data.slug);
  }

  @override
  void initState() {
    super.initState();
    refresh();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Kategori Layanan'),
      ),
      body: RefreshIndicator(
        onRefresh: () async => refresh(),
        child: BlocBuilder<ListServiceCubit, ListServiceState>(
          bloc: listServiceCubit,
          builder: (context, state) {
            return ListView(
              children: [
                serviceCategoryHeader(context),
                const Divider(thickness: 5, height: 5),
                const SizedBox(height: 5),
                if (state is ListServiceSuccess)
                  Column(
                    children: List.generate(
                      state.response.length,
                      (index) => ServiceCard(
                        data: state.response[index],
                        margin: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 5),
                        onConfirm: () {
                          // TODO: Tambah keranjang
                          Get.back();
                          Get.to(() => const ServiceCartPage());
                        },
                      ),
                    ),
                  )
                else
                  SizedBox(
                    height: Get.height * 0.75,
                    child: Center(
                        child: Center(
                      child: state is ListServiceFailed
                          ? ErrorIndicator(
                              message: state.message,
                              onRefresh: refresh,
                            )
                          : state is ListServiceLoading
                              ? const CircularProgressIndicator()
                              : const SizedBox(),
                    )),
                  ),
                const SizedBox(height: 10),
              ],
            );
          },
        ),
      ),
    );
  }

  Padding serviceCategoryHeader(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(50),
            child: FadeInImage(
              image:
                  NetworkImage('${Constants.storageUrl}/${widget.data.gambar}'),
              placeholder: const AssetImage(
                Constants.dummyImagePath,
              ),
              imageErrorBuilder: (context, error, stackTrace) => Image.asset(
                Constants.dummyImagePath,
                width: 60,
                height: 60,
                fit: BoxFit.cover,
              ),
              width: 60,
              height: 60,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(width: 15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 5),
                Text(
                  widget.data.nama,
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        color: Theme.of(context).colorScheme.primary,
                      ),
                ),
                Text(
                  'Kategori',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
