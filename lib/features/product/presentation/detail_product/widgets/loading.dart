part of '../detail_product_screen.dart';

class _Loading extends StatelessWidget {
  const _Loading();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Shimmer(
          color: Colors.grey[350]!,
          duration: const Duration(seconds: 2),
          enabled: true,
          direction: const ShimmerDirection.fromLTRB(),
          interval: const Duration(milliseconds: 300),
          child: SizedBox(width: double.infinity, height: 170.h),
        ),
        Padding(
          padding: EdgeInsetsGeometry.only(top: 6.h, left: 8.w, right: 8.w),
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
                  child: SizedBox(width: 450.w, height: 16.h),
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
                  child: SizedBox(width: 300.w, height: 16.h),
                ),
              ),
              6.verticalSpace,
              ClipRRect(
                borderRadius: BorderRadiusGeometry.circular(8.r),
                child: Shimmer(
                  color: Colors.grey[350]!,
                  duration: const Duration(seconds: 2),
                  enabled: true,
                  direction: const ShimmerDirection.fromLTRB(),
                  interval: const Duration(milliseconds: 300),
                  child: SizedBox(width: 270.w, height: 16.h),
                ),
              ),
              Padding(
                padding: EdgeInsetsGeometry.only(top: 8.h),
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
                        child: SizedBox(width: 140.w, height: 16.h),
                      ),
                    ),
                    10.verticalSpace,
                    ClipRRect(
                      borderRadius: BorderRadiusGeometry.circular(8.r),
                      child: Shimmer(
                        color: Colors.grey[350]!,
                        duration: const Duration(seconds: 2),
                        enabled: true,
                        direction: const ShimmerDirection.fromLTRB(),
                        interval: const Duration(milliseconds: 300),
                        child: SizedBox(width: double.infinity, height: 16.h),
                      ),
                    ),
                    6.verticalSpace,
                    ClipRRect(
                      borderRadius: BorderRadiusGeometry.circular(8.r),
                      child: Shimmer(
                        color: Colors.grey[350]!,
                        duration: const Duration(seconds: 2),
                        enabled: true,
                        direction: const ShimmerDirection.fromLTRB(),
                        interval: const Duration(milliseconds: 300),
                        child: SizedBox(width: double.infinity, height: 16.h),
                      ),
                    ),
                    6.verticalSpace,
                    ClipRRect(
                      borderRadius: BorderRadiusGeometry.circular(8.r),
                      child: Shimmer(
                        color: Colors.grey[350]!,
                        duration: const Duration(seconds: 2),
                        enabled: true,
                        direction: const ShimmerDirection.fromLTRB(),
                        interval: const Duration(milliseconds: 300),
                        child: SizedBox(width: double.infinity, height: 16.h),
                      ),
                    ),
                    6.verticalSpace,
                    ClipRRect(
                      borderRadius: BorderRadiusGeometry.circular(8.r),
                      child: Shimmer(
                        color: Colors.grey[350]!,
                        duration: const Duration(seconds: 2),
                        enabled: true,
                        direction: const ShimmerDirection.fromLTRB(),
                        interval: const Duration(milliseconds: 300),
                        child: SizedBox(width: double.infinity, height: 16.h),
                      ),
                    ),
                    6.verticalSpace,
                    ClipRRect(
                      borderRadius: BorderRadiusGeometry.circular(8.r),
                      child: Shimmer(
                        color: Colors.grey[350]!,
                        duration: const Duration(seconds: 2),
                        enabled: true,
                        direction: const ShimmerDirection.fromLTRB(),
                        interval: const Duration(milliseconds: 300),
                        child: SizedBox(width: double.infinity, height: 16.h),
                      ),
                    ),
                    6.verticalSpace,
                    ClipRRect(
                      borderRadius: BorderRadiusGeometry.circular(8.r),
                      child: Shimmer(
                        color: Colors.grey[350]!,
                        duration: const Duration(seconds: 2),
                        enabled: true,
                        direction: const ShimmerDirection.fromLTRB(),
                        interval: const Duration(milliseconds: 300),
                        child: SizedBox(width: double.infinity, height: 16.h),
                      ),
                    ),
                    6.verticalSpace,
                    ClipRRect(
                      borderRadius: BorderRadiusGeometry.circular(8.r),
                      child: Shimmer(
                        color: Colors.grey[350]!,
                        duration: const Duration(seconds: 2),
                        enabled: true,
                        direction: const ShimmerDirection.fromLTRB(),
                        interval: const Duration(milliseconds: 300),
                        child: SizedBox(width: double.infinity, height: 16.h),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
