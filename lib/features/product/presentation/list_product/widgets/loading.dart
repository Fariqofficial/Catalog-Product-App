part of '../list_products_screen.dart';

class _Loading extends StatelessWidget {
  const _Loading();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: List.generate(5, (index) {
        return Container(
          width: double.infinity,
          color: Colors.white,
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                  child: SizedBox(width: 100.w, height: 80.w),
                ),
              ),
              20.horizontalSpace,
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
      }),
    );
  }
}
