import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gradish/providers/api_provider.dart';
import 'package:gradish/providers/firestore_provider.dart';
import 'package:gradish/repositories/api_repository.dart';
import 'package:gradish/repositories/auth_repository.dart';
import 'package:gradish/repositories/firestore_repository.dart';
import 'package:gradish/screens/auth_screens/login_screen.dart';
import 'package:gradish/screens/home_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:gradish/services/api_service/api_service.dart';
import 'package:gradish/services/auth_service/firebase_auth_service.dart';
import 'package:gradish/services/firestore_service/firestore_service.dart';
import 'package:provider/provider.dart';
import 'core/enums.dart';
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

  final FirebaseAuthService _authService = FirebaseAuthService();
  late final AuthRepository _authRepository;
  final FirestoreService _firestoreService = FirestoreService();
  late final FirestoreRepository _firestoreRepository;
  final APIService _apiService = APIService();
  late final ApiRepository _apiRepository;

  @override
  void initState() {
    super.initState();
    _authRepository = AuthRepository(_authService);
    _firestoreRepository = FirestoreRepository(_firestoreService);
    _apiRepository = ApiRepository(_apiService);
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<AuthProvider>(
            create: (context) =>
                AuthProvider(_authRepository)..authStateChanged()),
        ChangeNotifierProvider<FirestoreProvider>(
            create: (context) => FirestoreProvider(_firestoreRepository)),
        ChangeNotifierProvider<ApiProvider>(
            create: (context) => ApiProvider(_apiRepository)),
      ],
      child: Consumer<AuthProvider>(
        builder: (context, authData, child) {
          print("Auth state is ");
          print(authData.authState);
          print(authData.currentUser);
          return MaterialApp(
            title: 'Gradish',
            theme: ThemeData(
                useMaterial3: true,
                colorScheme:
                    ColorScheme.fromSeed(seedColor: const Color(0xffffc604)),
                primaryColor: Color(0xffffc604),
                textTheme: GoogleFonts.josefinSansTextTheme(
                    Theme.of(context).textTheme)),
            home: authData.authState == AuthState.authenticated ||
                    authData.authState == AuthState.initial
                ? const HomeScreen()
                : LoginScreen(),
            //home: RegisterScreen(),
          );
        },
      ),
    );
  }
}
