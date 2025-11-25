part of '../list_products_screen.dart';

class _CartItems extends StatelessWidget {
  final CartSummary data;
  final Function()? onTap;
  const _CartItems({required this.data, this.onTap});

  @override
  Widget build(BuildContext context) {
    if (data.totalItems == 0) return SizedBox.shrink();
    return GestureDetector(
      onTap: onTap ?? () {},
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: 16.w,
          vertical: 12.h,
        ).copyWith(bottom: 24.h),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(12.r),
            topRight: Radius.circular(12.r),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              spreadRadius: 1,
              blurRadius: 1,
              offset: const Offset(0, -1),
            ),
          ],
        ),
        child: Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 8.h),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8.r),
            color: Colors.orange[400],
          ),
          child: Center(
            child: Text(
              "Cart 󠁯•󠁏 Total Items: ${data.totalItems} | Price: \$${data.totalPrice.toStringAsFixed(2)}",
              style: TextStyle(fontSize: 16.sp, color: Colors.white),
            ),
          ),
        ),
      ),
    );
  }
}
