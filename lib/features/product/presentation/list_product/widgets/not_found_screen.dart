part of '../list_products_screen.dart';

class _NotFoundScreen extends StatelessWidget {
  final String? message;
  const _NotFoundScreen({this.message});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Align(
            alignment: Alignment.center,
            child: Container(
              width: 180.w,
              height: 140.h,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/images/not-found-icon.png"),
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.center,
            child: Text(
              message ?? "Data Not Found",
              style: TextStyle(
                fontSize: 18.sp,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
