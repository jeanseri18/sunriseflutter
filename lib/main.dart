import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sunrise_hosting/features/auth/login/cubit/login_cubit_cubit.dart';
import 'package:sunrise_hosting/features/auth/register/cubit/registercubit_cubit.dart';
import 'package:sunrise_hosting/features/herbergement/herbergement_list/cubit/hebergement_cubit.dart';
import 'package:sunrise_hosting/features/home/home_loader.dart';
import 'package:sunrise_hosting/features/notification/cubit/message_cubit.dart';
import 'package:sunrise_hosting/features/onboard/onboard_page.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:sunrise_hosting/features/reservation/cubit/reservation_cubit.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    MaterialColor mycolor = const MaterialColor(
      0xFFF5831F,
      <int, Color>{
        50: Color(0xFFF5831F),
        100: Color(0xFFF5831F),
        200: Color(0xFFF5831F),
        300: Color(0xFFF5831F),
        400: Color(0xFFF5831F),
        500: Color(0xFFF5831F),
        600: Color(0xFFF5831F),
        700: Color(0xFFF5831F),
        800: Color(0xFFF5831F),
        900: Color(0xFFF5831F),
      },
    );
    return MultiBlocProvider(
        providers: [
          BlocProvider<LoginCubit>(
            lazy: false,
            create: (BuildContext context) => LoginCubit(),
          ),
          BlocProvider<Registercubit>(
            lazy: false,
            create: (BuildContext context) => Registercubit(),
          ),
          BlocProvider<HebergementCubit>(
            lazy: false,
            create: (BuildContext context) => HebergementCubit(),
          ),
          BlocProvider<MessageCubit>(
            lazy: false,
            create: (BuildContext context) => MessageCubit(),
          ),
          BlocProvider<MessageReplyCubit>(
            lazy: false,
            create: (BuildContext context) => MessageReplyCubit(),
          ),
          BlocProvider<ReservationCubit>(
            lazy: false,
            create: (BuildContext context) => ReservationCubit(),
          )
        ],
        child: MaterialApp(
          title: 'Flutter Demo',
          theme: ThemeData(
            // This is the theme of your application.
            //
            // Try running your application with "flutter run". You'll see the
            // application has a blue toolbar. Then, without quitting the app, try
            // changing the primarySwatch below to Colors.green and then invoke
            // "hot reload" (press "r" in the console where you ran "flutter run",
            // or simply save your changes to "hot reload" in a Flutter IDE).
            // Notice that the counter didn't reset back to zero; the application
            // is not restarted.
            primarySwatch: Colors.amber,
          ),
          home: HomeLoaderPage(),
          localizationsDelegates: [
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: [
            Locale('en'), // English
            Locale('es'), // Spanish
          ],
        ));
  }
}
