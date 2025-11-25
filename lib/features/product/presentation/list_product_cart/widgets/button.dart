part of '../list_product_cart_screen.dart';

class _ButtonRemoveAll extends StatelessWidget {
  final bool isAllSelected;
  final int selectedCount;
  final VoidCallback onSelectAll;
  final VoidCallback onRemove;
  const _ButtonRemoveAll({
    required this.isAllSelected,
    required this.selectedCount,
    required this.onSelectAll,
    required this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
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
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Checkbox(
                value: isAllSelected,
                onChanged: (_) => onSelectAll(),
                activeColor: Colors.orange[400],
                checkColor: Colors.white,
              ),
              2.horizontalSpace,
              Text(
                "Select all",
                style: TextStyle(
                  fontSize: 12.sp,
                  color: Colors.black,
                  fontWeight: FontWeight.normal,
                ),
              ),
            ],
          ),
          GestureDetector(
            onTap: onRemove,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8.r),
                color: Colors.red[400],
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    spreadRadius: 1,
                    blurRadius: 1,
                    offset: const Offset(0, -1),
                  ),
                ],
              ),
              child: Text(
                "Remove",
                style: TextStyle(fontSize: 14.sp, color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ButtonAction extends StatelessWidget {
  final Function()? onRemove;
  final String? total;
  const _ButtonAction({this.onRemove, this.total});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          total ?? "0 Items",
          style: TextStyle(
            fontSize: 12.sp,
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        _ButtonRounded(
          borderColor: Colors.grey[350],
          isShowIcon: false,
          color: Colors.red[400],
          onTap: onRemove ?? () {},
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
  final bool isShowIcon;
  const _ButtonRounded({
    this.color,
    this.borderColor,
    this.borderRadius,
    this.icon,
    this.padding,
    this.iconsize,
    this.iconColor,
    this.onTap,
    this.isShowIcon = false,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap ?? () {},
      child: Container(
        padding:
            padding ?? EdgeInsets.symmetric(horizontal: 6.w, vertical: 3.h),
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
        child: isShowIcon
            ? Align(
                alignment: Alignment.center,
                child: Icon(icon, size: iconsize, color: iconColor),
              )
            : Text(
                'Delete',
                style: TextStyle(fontSize: 12.sp, color: Colors.white),
              ),
      ),
    );
  }
}
