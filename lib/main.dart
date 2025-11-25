import 'dart:developer';

import 'package:catalog_product_app/common/route/app_route.dart';
import 'package:catalog_product_app/features/product/presentation/list_product/cubit/list_product_screen_cubit.dart';
import 'package:catalog_product_app/injection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: '.env');
  log(dotenv.env['BASE_URL'] ?? "");
  await initLocator();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: Size(393, 582),
      builder: (context, _) => BlocProvider(
        create: (context) => di<ListProductScreenCubit>(),
        child: MaterialApp(
          theme: ThemeData(
            useMaterial3: true,
            textTheme: GoogleFonts.poppinsTextTheme(),
            scaffoldBackgroundColor: Colors.white,
          ),
          debugShowCheckedModeBanner: false,
          title: 'Catalog Product App',
          initialRoute: AppRoute.dashboard,
          onGenerateRoute: AppRoute.onGenerateRoute,
        ),
      ),
    );
  }
}
