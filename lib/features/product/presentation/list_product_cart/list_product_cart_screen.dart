import 'package:cached_network_image/cached_network_image.dart';
import 'package:catalog_product_app/common/route/app_route.dart';
import 'package:catalog_product_app/features/product/domain/entities/cart/cart_item.dart';
import 'package:catalog_product_app/features/product/domain/entities/product/product.dart';
import 'package:catalog_product_app/features/product/presentation/list_product_cart/cubit/list_product_cart_screen_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer_animation/shimmer_animation.dart';

part 'widgets/empty_cart.dart';
part 'widgets/product_cart_items.dart';
part 'widgets/button.dart';
part 'widgets/loading.dart';
part 'widgets/content.dart';

class ListProductCartScreen extends StatelessWidget {
  const ListProductCartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) {
        if (!didPop) {
          Navigator.pop(context, true);
        }
      },
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            "My Cart",
            style: TextStyle(
              fontSize: 16.sp,
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
          elevation: 1,
          actions: [
            BlocBuilder<ListProductCartScreenCubit, ListProductCartScreenState>(
              builder: (context, state) => switch (state) {
                ListProductCartScreenInitial() => _buildShimmer(),
                ListProductCartScreenLoaded(
                  :final isManageMode,
                  :final cartItems,
                ) =>
                  (cartItems.length <= 1 && !isManageMode)
                      ? const SizedBox.shrink()
                      : TextButton(
                          onPressed: () => context
                              .read<ListProductCartScreenCubit>()
                              .toogleMode(),
                          child: Text(
                            isManageMode ? "Cancel" : "Manage",
                            style: TextStyle(
                              fontSize: 14.sp,
                              color: isManageMode
                                  ? Colors.red
                                  : Colors.lightBlue[900],
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                ListProductCartScreenError() => SizedBox.shrink(),
              },
            ),
          ],
        ),
        body:
            BlocBuilder<ListProductCartScreenCubit, ListProductCartScreenState>(
              builder: (context, state) => switch (state) {
                ListProductCartScreenInitial() => _Loading(),
                ListProductCartScreenLoaded() => _Content(
                  items: state.cartItems,
                  isManage: state.isManageMode,
                  selectedItems: state.selectedItems,
                  selectedCount: state.selectedItems.length,
                  isAllSelected: state.isAllSelected,
                  onToggleItem: (item) => context
                      .read<ListProductCartScreenCubit>()
                      .toogleItemSelection(item),
                  onDeleteItem: (product) => context
                      .read<ListProductCartScreenCubit>()
                      .removeSingleItem(product),
                  onSelectAll: () {
                    if (state.isAllSelected) {
                      context.read<ListProductCartScreenCubit>().unselectAll();
                    } else {
                      context.read<ListProductCartScreenCubit>().selectAll();
                    }
                  },
                  onRemoveSelected: () => context
                      .read<ListProductCartScreenCubit>()
                      .removeSelectedItems(),
                ),
                ListProductCartScreenError() => Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.error_outline,
                        size: 64,
                        color: Colors.red[400],
                      ),
                      16.verticalSpace,
                      Text(
                        "Failed to load cart",
                        style: TextStyle(
                          fontSize: 18.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      8.verticalSpace,
                      Text(
                        state.errorMsg,
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.grey[600]),
                      ),
                      24.verticalSpace,
                      ElevatedButton(
                        onPressed: () => context
                            .read<ListProductCartScreenCubit>()
                            .loadCart(),
                        child: const Text("Try Again"),
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

Widget _buildShimmer() {
  return Padding(
    padding: EdgeInsets.only(right: 8.w),
    child: Padding(
      padding: EdgeInsets.only(right: 4.r),
      child: ClipRRect(
        borderRadius: BorderRadiusGeometry.circular(8.r),
        child: Shimmer(
          color: Colors.grey[600]!,
          duration: const Duration(seconds: 2),
          enabled: true,
          direction: const ShimmerDirection.fromLTRB(),
          interval: const Duration(milliseconds: 300),
          child: SizedBox(width: 75.w, height: 10.h),
        ),
      ),
    ),
  );
}
