import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gradish/repositories/auth_repository.dart';
import 'package:gradish/screens/auth_screens/login_screen.dart';
import 'package:gradish/screens/auth_screens/register_screen.dart';
import 'package:gradish/screens/home_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:gradish/services/auth_service/firebase_auth_service.dart';
import 'package:provider/provider.dart';
import 'firebase_options.dart';
import 'providers/auth_provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const GradishApp());
}

class GradishApp extends StatefulWidget {
  const GradishApp({super.key});

  @override
  State<GradishApp> createState() => _GradishAppState();
}

class _GradishAppState extends State<GradishApp> {
  // This widget is the root of your application.

 late final FirebaseAuthService _authService;
 late final AuthRepository _authRepository;

  @override
  void initState() {
    super.initState();
    _authService = FirebaseAuthService();
    _authRepository = AuthRepository(_authService);
  }




  @override
  Widget build(BuildContext context) {
    return MultiProvider(
    providers: [
      ChangeNotifierProvider<AuthProvider>(create: (context)=> AuthProvider(_authRepository)..authStateChanged())
    ],
      child: Consumer<AuthProvider>(
        builder: (context, authData, child){
          print("Auth state is ");
          print(authData.authState);
          return MaterialApp(
            title: 'Gradish',
            theme: ThemeData(
                useMaterial3: true,
                colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xffffc604)),
                textTheme: GoogleFonts.josefinSansTextTheme(
                    Theme.of(context).textTheme
                )
            ),
            // home:  authData.authState == AuthState.authenticated || authData.authState == AuthState.initial ? const HomeScreen(): RegisterScreen(),
            home: RegisterScreen(),
          );
        },

      ),
    );
  }
}

