import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:videotrade_app/models/cart.dart';
import 'package:videotrade_app/providers/cart_provider.dart';
import 'package:videotrade_app/providers/library_provider.dart';
import 'package:videotrade_app/providers/ofertas_provider.dart';
import 'package:videotrade_app/providers/user_provider.dart'; 
import 'package:videotrade_app/ui/main_page.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_ui_auth/firebase_ui_auth.dart'; 
import 'firebase_options.dart';
import 'auth_gate.dart'; 


void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,

  );

  runApp(
  MultiProvider( 
    providers: [
      ChangeNotifierProvider(create: (context) => CartProvider()),
      ChangeNotifierProvider(create: (context) => OfertasProvider()), 
      ChangeNotifierProvider(create: (context) => LibraryProvider()),
      ChangeNotifierProvider(create: (context) => UserProvider()),

    ],
    child: MainApp(),
  )
);
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(

        brightness: Brightness.dark,

        scaffoldBackgroundColor: Colors.blueGrey.shade900,

        appBarTheme: AppBarTheme(

          backgroundColor: Colors.blueGrey.shade900,

          foregroundColor: Colors.white, 

        ),   
        colorScheme: ColorScheme.dark(

          primary: Colors.blueGrey.shade800, 

          onPrimary: Colors.white,

          secondary: Colors.lightBlueAccent, 

          onSecondary: Colors.black, 

          surface: Colors.blueGrey.shade800,

          onSurface: Colors.white, 

          error: Colors.red,
          onError: Colors.redAccent,

        ),

        elevatedButtonTheme: ElevatedButtonThemeData(

          style: ElevatedButton.styleFrom(

            backgroundColor: Colors.blueGrey.shade800,

            foregroundColor: Colors.lightBlueAccent, 

            shape: RoundedRectangleBorder(

              borderRadius: BorderRadius.circular(12),

            ),

          ),

        ),


        textTheme: TextTheme(

          bodyLarge: TextStyle(color: Colors.white70),

          bodyMedium: TextStyle(color: Colors.white70),



          labelSmall: TextStyle(color: Colors.white54),

        ),

        inputDecorationTheme: InputDecorationTheme(

          labelStyle: TextStyle(color: Colors.white70), 

          hintStyle: TextStyle(color: Colors.white54), 

          enabledBorder: OutlineInputBorder(

            borderSide: BorderSide(color: Colors.blueGrey.shade600),

          ),

          focusedBorder: OutlineInputBorder(

            borderSide: BorderSide(color: Colors.lightBlueAccent),

          ),

          errorBorder: OutlineInputBorder(

            borderSide: BorderSide(color: Colors.red),

          ),

          focusedErrorBorder: OutlineInputBorder(

            borderSide: BorderSide(color: Colors.redAccent),

          ),

        ),

      ),

      debugShowCheckedModeBanner: false,
      home: const AuthGate(),
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        //FirebaseUILocalizations.delegate,

      ],
      supportedLocales: const [

        Locale('en'), 

        Locale('es'), 

      ],

    );
  }
}