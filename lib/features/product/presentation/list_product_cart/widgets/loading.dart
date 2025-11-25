part of '../list_product_cart_screen.dart';

class _Loading extends StatelessWidget {
  const _Loading({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: Colors.white,
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          ClipRRect(
            borderRadius: BorderRadiusGeometry.circular(8.r),
            child: Shimmer(
              color: Colors.grey[350]!,
              duration: const Duration(seconds: 2),
              enabled: true,
              direction: const ShimmerDirection.fromLTRB(),
              interval: const Duration(milliseconds: 300),
              child: SizedBox(width: 20.w, height: 15.h),
            ),
          ),
          4.horizontalSpace,
          ClipRRect(
            borderRadius: BorderRadiusGeometry.circular(8.r),
            child: Shimmer(
              color: Colors.grey[350]!,
              duration: const Duration(seconds: 2),
              enabled: true,
              direction: const ShimmerDirection.fromLTRB(),
              interval: const Duration(milliseconds: 300),
              child: SizedBox(width: 100.w, height: 80.w),
            ),
          ),
          12.horizontalSpace,
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadiusGeometry.circular(8.r),
                  child: Shimmer(
                    color: Colors.grey[350]!,
                    duration: const Duration(seconds: 2),
                    enabled: true,
                    direction: const ShimmerDirection.fromLTRB(),
                    interval: const Duration(milliseconds: 300),
                    child: SizedBox(width: 350.w, height: 14.h),
                  ),
                ),
                4.verticalSpace,
                ClipRRect(
                  borderRadius: BorderRadiusGeometry.circular(8.r),
                  child: Shimmer(
                    color: Colors.grey[350]!,
                    duration: const Duration(seconds: 2),
                    enabled: true,
                    direction: const ShimmerDirection.fromLTRB(),
                    interval: const Duration(milliseconds: 300),
                    child: SizedBox(width: 200.w, height: 14.h),
                  ),
                ),
                4.verticalSpace,
                ClipRRect(
                  borderRadius: BorderRadiusGeometry.circular(8.r),
                  child: Shimmer(
                    color: Colors.grey[350]!,
                    duration: const Duration(seconds: 2),
                    enabled: true,
                    direction: const ShimmerDirection.fromLTRB(),
                    interval: const Duration(milliseconds: 300),
                    child: SizedBox(width: 100.w, height: 14.h),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
