part of '../list_products_screen.dart';

class _ProductItems extends StatelessWidget {
  final Product product;
  final Function()? onTap;
  final Function()? onAddToCart;
  final Function()? onIncrement;
  final Function()? onDecrement;
  final int quantity;
  const _ProductItems({
    required this.product,
    this.onTap,
    this.onAddToCart,
    this.onIncrement,
    this.onDecrement,
    required this.quantity,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap ?? () {},
      child: Container(
        width: double.infinity,
        color: Colors.white,
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8.r),
              child: CachedNetworkImage(
                imageUrl: product.images,
                width: 100.w,
                height: 80.w,
                fadeInDuration: const Duration(milliseconds: 300),
                placeholder: (context, url) => Shimmer(
                  duration: const Duration(seconds: 2),
                  interval: const Duration(milliseconds: 300),
                  color: Colors.grey.shade300,
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
                  color: Colors.grey.shade100,
                  alignment: Alignment.center,
                  child: const Icon(Icons.broken_image, color: Colors.grey),
                ),
              ),
            ),
            12.horizontalSpace,
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.title,
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  4.verticalSpace,
                  Row(
                    children: [
                      Text(
                        product.category,
                        style: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.normal,
                          color: Colors.black,
                        ),
                      ),
                      4.horizontalSpace,
                      Text(
                        "|",
                        style: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w500,
                          color: Colors.black,
                        ),
                      ),
                      4.horizontalSpace,
                      Text(
                        "\$${product.price}",
                        style: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                  4.verticalSpace,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.star, color: Colors.yellow[400], size: 20),
                          4.horizontalSpace,
                          Text(
                            "${product.rating.rate} (${product.rating.count})",
                            style: TextStyle(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.normal,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                      if (quantity == 0)
                        _ButtonAddToCart(onAddToCart: onAddToCart)
                      else
                        _ButtonAction(
                          onRemove: onDecrement,
                          onAdd: onIncrement,
                          total: quantity.toString(),
                        ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
