part of '../list_product_cart_screen.dart';

class _ProductCartItem extends StatelessWidget {
  final CartItem item;
  final bool isManage;
  final bool isSelected;
  final VoidCallback? onTap;
  final VoidCallback? onToggle;
  final VoidCallback? onDelete;
  const _ProductCartItem({
    required this.item,
    required this.isManage,
    required this.isSelected,
    this.onTap,
    this.onToggle,
    this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap ?? () {},
      child: Container(
        width: double.infinity,
        color: Colors.white,
        padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 10.h),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            if (isManage)
              Checkbox(
                value: isSelected,
                onChanged: (_) => onToggle?.call(),
                activeColor: Colors.orange[400],
                checkColor: Colors.white,
              ),
            ClipRRect(
              borderRadius: BorderRadius.circular(8.r),
              child: CachedNetworkImage(
                imageUrl: item.product.images,
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
                    item.product.title,
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
                        item.product.category,
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
                          fontWeight: FontWeight.normal,
                          color: Colors.black,
                        ),
                      ),
                      4.horizontalSpace,
                      Text(
                        "\$${item.product.price}",
                        style: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                  4.verticalSpace,
                  _ButtonAction(
                    onRemove: onDelete ?? () {},
                    total: "${item.quantity} Items",
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
