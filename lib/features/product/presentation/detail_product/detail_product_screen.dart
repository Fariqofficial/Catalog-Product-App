import 'package:cached_network_image/cached_network_image.dart';
import 'package:catalog_product_app/features/product/presentation/detail_product/cubit/detail_product_screen_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer_animation/shimmer_animation.dart';

part 'widgets/loading.dart';
part 'widgets/content.dart';

class DetailProductScreen extends StatefulWidget {
  final int id;
  const DetailProductScreen({super.key, required this.id});

  @override
  State<DetailProductScreen> createState() => _DetailProductScreenState();
}

class _DetailProductScreenState extends State<DetailProductScreen> {
  @override
  void initState() {
    super.initState();
    context.read<DetailProductScreenCubit>().getDetail(widget.id);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            "Detail Product",
            style: TextStyle(
              fontSize: 16.sp,
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
          elevation: 1,
        ),
        body: BlocBuilder<DetailProductScreenCubit, DetailProductScreenState>(
          builder: (context, state) => switch (state) {
            DetailProductScreenInitial() => const _Loading(),
            DetailProductScreenSuccess() => _Content(
              images: state.data.images,
              title: state.data.title,
              category: state.data.category,
              price: state.data.price,
              rate: state.data.rating.rate,
              count: state.data.rating.count,
              description: state.data.description,
            ),
            DetailProductScreenError() => Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Error: ${state.errorMsg}"),
                  ElevatedButton(
                    onPressed: () => context
                        .read<DetailProductScreenCubit>()
                        .getDetail(widget.id),
                    child: const Text("Retry"),
                  ),
                ],
              ),
            ),
          },
        ),
      ),
    );
  }
}
