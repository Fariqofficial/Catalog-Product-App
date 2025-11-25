part of '../detail_product_screen.dart';

class _Content extends StatelessWidget {
  final String images;
  final String title;
  final String category;
  final double price;
  final double rate;
  final int count;
  final String description;
  const _Content({
    required this.images,
    required this.title,
    required this.category,
    required this.price,
    required this.rate,
    required this.count,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //Image
          CachedNetworkImage(
            imageUrl: images,
            width: double.infinity,
            height: 170.h,
            fadeInDuration: const Duration(milliseconds: 300),
            placeholder: (context, url) => Shimmer(
              duration: const Duration(seconds: 2),
              interval: const Duration(milliseconds: 300),
              color: Colors.grey[350]!,
              colorOpacity: 0.3,
              enabled: true,
              direction: const ShimmerDirection.fromLTRB(),
              child: Container(
                width: 100.w,
                height: 80.w,
                decoration: BoxDecoration(
                  color: Colors.grey.shade200,
                  borderRadius: BorderRadius.circular(8.r),
                ),
              ),
            ),
            errorWidget: (context, url, error) => Container(
              width: 100.w,
              height: 80.w,
              color: Colors.grey[700],
              alignment: Alignment.center,
              child: const Icon(Icons.broken_image, color: Colors.white),
            ),
          ),
          Padding(
            padding: EdgeInsetsGeometry.only(top: 6.h, left: 8.w, right: 8.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 18.sp,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                4.verticalSpace,
                Text(
                  category,
                  style: TextStyle(
                    fontSize: 14.sp,
                    color: Colors.black,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                6.verticalSpace,
                Row(
                  children: [
                    Icon(
                      Icons.attach_money,
                      color: Colors.green[900],
                      size: 18,
                    ),
                    Text(
                      price.toString(),
                      style: TextStyle(
                        fontSize: 14.sp,
                        color: Colors.green[900],
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    6.horizontalSpace,
                    Row(
                      children: [
                        Icon(Icons.star, color: Colors.yellow[300], size: 18),
                        Text(
                          rate.toString(),
                          style: TextStyle(
                            fontSize: 14.sp,
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        6.horizontalSpace,
                        Text(
                          "($count)",
                          style: TextStyle(
                            fontSize: 14.sp,
                            color: Colors.black,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        4.horizontalSpace,
                        Text(
                          "review..",
                          style: TextStyle(
                            fontSize: 14.sp,
                            color: Colors.black,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                Padding(
                  padding: EdgeInsetsGeometry.only(top: 8.h),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Description",
                        style: TextStyle(
                          fontSize: 14.sp,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      4.verticalSpace,
                      Text(
                        description,
                        style: TextStyle(
                          fontSize: 12.sp,
                          color: Colors.black,
                          fontWeight: FontWeight.normal,
                        ),
                        textAlign: TextAlign.justify,
                      ),
                    ],
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
