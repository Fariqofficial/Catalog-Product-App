part of '../list_product_cart_screen.dart';

class _EmptyCart extends StatelessWidget {
  const _EmptyCart({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Align(
          alignment: Alignment.center,
          child: Container(
            width: 180.w,
            height: 140.h,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/images/empty-cart.png"),
              ),
            ),
          ),
        ),
        Align(
          alignment: Alignment.center,
          child: Text(
            "Your cart is empty",
            style: TextStyle(
              fontSize: 18.sp,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
        ),
        4.verticalSpace,
        Align(
          alignment: Alignment.center,
          child: Text(
            "Explore and find the best collection to your style!",
            style: TextStyle(
              fontSize: 14.sp,
              fontWeight: FontWeight.normal,
              color: Colors.black,
            ),
            textAlign: TextAlign.justify,
          ),
        ),
      ],
    );
  }
}
