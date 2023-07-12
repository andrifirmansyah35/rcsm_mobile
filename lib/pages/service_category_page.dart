import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:mobile_app/app/app_injector.dart';
import 'package:mobile_app/cubit/service_category_cubit.dart';
import 'package:mobile_app/widgets/service_category_card.dart';

class ServiceCategoryPage extends StatefulWidget {
  const ServiceCategoryPage({Key? key}) : super(key: key);

  @override
  State<ServiceCategoryPage> createState() => _ServiceCategoryPageState();
}

class _ServiceCategoryPageState extends State<ServiceCategoryPage> {
  final serviceCategoryCubit = sl<ServiceCategoryCubit>();

  void onRefresh() {
    serviceCategoryCubit.fetchData();
  }

  @override
  void initState() {
    super.initState();
    onRefresh();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Kategori Layanan'),
      ),
      body: RefreshIndicator(
        onRefresh: () async => onRefresh,
        child: BlocBuilder<ServiceCategoryCubit, ServiceCategoryState>(
          bloc: serviceCategoryCubit,
          builder: (context, state) {
            return Stack(
              children: [
                if (state is ServiceCategorySuccess)
                  SingleChildScrollView(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Column(
                      children: List.generate(
                        state.response.length,
                        (index) => ServiceCategoryCard(
                          data: state.response[index],
                        ),
                      ),
                    ),
                  ),
                SizedBox(
                  height: Get.height,
                  child: Center(
                    child: state is ServiceCategoryFailed
                        ? Text(state.message)
                        : state is ServiceCategoryLoading
                            ? const CircularProgressIndicator()
                            : const SizedBox(),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
