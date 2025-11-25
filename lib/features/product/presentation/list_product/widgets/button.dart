part of '../list_products_screen.dart';

class _ButtonAddToCart extends StatelessWidget {
  final Function()? onAddToCart;
  const _ButtonAddToCart({required this.onAddToCart});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onAddToCart ?? () {},
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 4.h),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.r),
          color: Colors.orange[400],
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.3),
              spreadRadius: 1,
              blurRadius: 1,
              offset: Offset(0, 1),
            ),
          ],
        ),
        child: Text(
          "Add To Cart",
          style: TextStyle(
            fontSize: 12.sp,
            color: Colors.white,
            fontWeight: FontWeight.normal,
          ),
        ),
      ),
    );
  }
}

class _ButtonAction extends StatelessWidget {
  final Function()? onRemove;
  final Function()? onAdd;
  final String? total;
  const _ButtonAction({this.onRemove, this.onAdd, this.total});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        _ButtonRounded(
          borderColor: Colors.orange[400],
          icon: Icons.remove,
          iconsize: 12,
          color: Colors.white,
          iconColor: Colors.orange[400],
          onTap: onRemove ?? () {},
        ),
        10.horizontalSpace,
        Text(
          total ?? "0",
          style: TextStyle(
            fontSize: 12.sp,
            color: Colors.black,
            fontWeight: FontWeight.w500,
          ),
        ),
        10.horizontalSpace,
        _ButtonRounded(
          color: Colors.orange[400],
          icon: Icons.add,
          iconsize: 12,
          iconColor: Colors.white,
          onTap: onAdd ?? () {},
        ),
      ],
    );
  }
}

class _ButtonRounded extends StatelessWidget {
  final Color? color;
  final Color? borderColor;
  final BorderRadiusGeometry? borderRadius;
  final EdgeInsetsGeometry? padding;
  final IconData? icon;
  final double? iconsize;
  final Color? iconColor;
  final Function()? onTap;
  const _ButtonRounded({
    this.color,
    this.borderColor,
    this.borderRadius,
    this.icon,
    this.padding,
    this.iconsize,
    this.iconColor,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap ?? () {},
      child: Container(
        padding:
            padding ?? EdgeInsets.symmetric(horizontal: 6.w, vertical: 4.h),
        decoration: BoxDecoration(
          borderRadius: borderRadius ?? BorderRadius.circular(8.r),
          color: color,
          border: Border.all(
            width: 1.w,
            color: borderColor ?? Colors.transparent,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.3),
              spreadRadius: 1,
              blurRadius: 1,
              offset: Offset(0, 1),
            ),
          ],
        ),
        child: Align(
          alignment: Alignment.center,
          child: Icon(icon, size: iconsize, color: iconColor),
        ),
      ),
    );
  }
}
