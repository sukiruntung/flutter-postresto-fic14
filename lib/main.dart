import 'package:flutter/material.dart';
import 'package:resto_fic14/core/core.dart';
import 'package:resto_fic14/data/datasources/auth_local_datasource.dart';
import 'package:resto_fic14/data/datasources/auth_remote_datasource.dart';
import 'package:resto_fic14/data/datasources/product_local_datasource.dart';
import 'package:resto_fic14/data/datasources/product_remote_datasource.dart';
import 'package:resto_fic14/presentation/auth/bloc/login/login_bloc.dart';
import 'package:resto_fic14/presentation/auth/bloc/logout/logout_bloc.dart';
import 'package:resto_fic14/presentation/auth/login_pages.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:resto_fic14/presentation/home/bloc/checkout/checkout_bloc.dart';
import 'package:resto_fic14/presentation/home/bloc/local_product/local_product_bloc.dart';
import 'package:resto_fic14/presentation/home/pages/dasboard_page.dart';
import 'package:resto_fic14/presentation/settings/bloc/sync_product/sync_product_bloc.dart';

void main() async {
  WidgetsFlutterBinding
      .ensureInitialized(); // Pastikan Flutter sudah terinisialisasi

  // Inisialisasi sqflite
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => LoginBloc(AuthRemoteDataSource()),
        ),
        BlocProvider(
          create: (context) => LogoutBloc(AuthRemoteDataSource()),
        ),
        BlocProvider(
          create: (context) => SyncProductBloc(ProductRemoteDataSource()),
        ),
        BlocProvider(
          create: (context) =>
              LocalProductBloc(ProductLocalDataSource.instance),
        ),
        BlocProvider(
          create: (context) => CheckoutBloc(),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: AppColors.primary),
          useMaterial3: true,
          textTheme: GoogleFonts.quicksandTextTheme(
            Theme.of(context).textTheme,
          ),
          appBarTheme: AppBarTheme(
            color: AppColors.white,
            elevation: 0,
            titleTextStyle: GoogleFonts.quicksand(
              color: AppColors.primary,
              fontSize: 16.0,
              fontWeight: FontWeight.w500,
            ),
            iconTheme: const IconThemeData(
              color: AppColors.primary,
            ),
          ),
        ),
        home: FutureBuilder<bool>(
          future: AuthLocalDataSource().isAuthDataExists(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Scaffold(
                body: Center(
                  child: CircularProgressIndicator(),
                ),
              );
            }
            if (snapshot.hasData) {
              print(snapshot.data);
              if (snapshot.data!) {
                return const DasboardPage();
              } else {
                return const LoginPage();
              }
            }
            return const Scaffold(
              body: Text('Error'),
            );
          },
        ),
      ),
    );
  }
}
