import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_list_app/app/cubit/app_cubit.dart';
import 'package:todo_list_app/domains/authentication_repository/authentication_repository.dart';
import 'package:todo_list_app/domains/authentication_repository/data_sources/firebase_auth_service.dart';
import 'package:todo_list_app/ui/category/create_or_edit_category.dart';
import 'package:todo_list_app/ui/login/login_page.dart';
import 'package:todo_list_app/ui/splash/main/main_page.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:todo_list_app/ui/splash/splash.dart';
import 'package:todo_list_app/utils/enum/authentication_status.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await EasyLocalization.ensureInitialized();

  runApp(EasyLocalization(supportedLocales: const [
    Locale('en'),
    Locale('vi'),
  ], path: "assets/translations", child: const App()));
}

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  late final AuthenticationRepository _authenticationRepository;
  late final FirebaseAuthService _firebaseAuthService;

  @override
  void initState() {
    super.initState();
    _authenticationRepository = AuthenticationRepositoryImp(
      firebaseAuthService: FirebaseAuthService(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(
          create: (context) => _authenticationRepository,
        )
      ],
      child: BlocProvider(
        create: (context) {
          return AppCubit(
            authenticationRepository: _authenticationRepository,
          );
        },
        child: const MyApp(),
      ),
    );
  }
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final _navigatorKey = GlobalKey<NavigatorState>();

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      navigatorKey: _navigatorKey,
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a purple toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.

        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
        fontFamily: 'Lato',
      ),
      localizationsDelegates: context.localizationDelegates,
      locale: context.locale,
      supportedLocales: context.supportedLocales,
      builder: (context, child) {
        return BlocListener<AppCubit, AppState>(
          listener: (context, state) {
            if (state.status == AuthenticationStatus.authenticated) {
              _navigatorKey.currentState?.pushAndRemoveUntil(
                MaterialPageRoute(builder: (context) => const MainPage()),
                (route) => false,
              );
            } else if (state.status == AuthenticationStatus.unauthenticated) {
              _navigatorKey.currentState?.pushAndRemoveUntil(
                MaterialPageRoute(builder: (context) => const LoginPage()),
                (route) => false,
              );
            }
          },
          child: child,
        );
      },
      onGenerateRoute: (_) {
        return MaterialPageRoute(builder: (context) => const SplashScreen());
      },
    );
  }
}
