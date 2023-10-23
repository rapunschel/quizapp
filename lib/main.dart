import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/play_quiz_provider.dart';
import 'providers/quiz_creation_provider.dart';
import 'providers/quiz_handler.dart';
import 'package:google_fonts/google_fonts.dart';
import 'screens/homepage.dart';
import 'package:quizme/auth.dart';
import 'package:quizme/firebase_options.dart';
import 'package:quizme/screens/login_screen.dart';
import 'package:quizme/screens/signup_screen.dart';
import 'package:flutter/foundation.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  if (kIsWeb) {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  }
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const Quiz());
}

class Quiz extends StatelessWidget {
  const Quiz({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<QuizCreationProvider>(
          create: (context) => QuizCreationProvider(),
        ),
        ChangeNotifierProvider<QuizHandler>(
          create: (context) => QuizHandler(),
        ),
        ChangeNotifierProvider<PlayQuizProvider>(
          create: (context) => PlayQuizProvider(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: appStyling(context),
        routes: {
          '/': (context) => const Auth(),
          'homeScreen': (context) => const HomePage(),
          'loginScreen': (context) => const LoginScreen(),
          'signupScreen': (context) => const SignupScreen(),
        },
      ),
    );
  }

  ThemeData appStyling(BuildContext context) {
    Color textColor = Colors.black;
    Color primaryColor = const Color.fromARGB(255, 201, 237, 244);
    Color buttonColor =
        primaryColor; //const Color.fromARGB(255, 153, 225, 239);
    return ThemeData(
      primaryColor: primaryColor,
      colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      fontFamily: GoogleFonts.openSans().fontFamily,
      useMaterial3: true,
      appBarTheme: AppBarTheme(
        titleTextStyle: Theme.of(context)
            .textTheme
            .titleLarge!
            .copyWith(fontWeight: FontWeight.normal),
      ),
      textButtonTheme: TextButtonThemeData(
        style: ButtonStyle(
          elevation: MaterialStateProperty.all<double>(0),
          backgroundColor: MaterialStateProperty.all<Color>(buttonColor),
        ),
      ),
      textTheme: const TextTheme(

              // Global styling, use Theme... to use a specific style
              //and copyWith to overwrite specific values
              titleLarge: TextStyle(fontWeight: FontWeight.bold),
              // Edit
              titleMedium: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              titleSmall: TextStyle(),
              bodyLarge: TextStyle(),
              bodyMedium: TextStyle(),
              // Buttons uses labelLarge
              labelLarge: TextStyle(fontSize: 15, fontWeight: FontWeight.bold))
          .apply(bodyColor: textColor, displayColor: textColor),
    );
  }
}
