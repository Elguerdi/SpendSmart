import 'package:flutter/material.dart';
import 'package:spendsmart/authentification.dart';

import 'package:firebase_core/firebase_core.dart';

Future<void> main() async {

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LogoAnimationPage(),
    );
  }
}

class LogoAnimationPage extends StatefulWidget {
  @override
  _LogoAnimationPageState createState() => _LogoAnimationPageState();
}

class _LogoAnimationPageState extends State<LogoAnimationPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 3),
    );

    _animation = Tween<double>(begin: 1.0, end: 2.0).animate(_controller)
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          // Navigation vers une nouvelle page avec une transition personnalisée
          Navigator.push(
            context,
            PageRouteBuilder(
              pageBuilder: (context, animation, secondaryAnimation) =>
                  AuthentificationPage(),
              transitionsBuilder: (context, animation, secondaryAnimation, child) {
                return FadeTransition(
                  opacity: animation, // Utilisez l'animation pour le fondu
                  child: child,
                );
              },
              // Définissez la durée de la transition
              transitionDuration: Duration(milliseconds: 1000),
            ),
          );
        }
      });

    // Démarrer l'animation lorsque la page est chargée
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: AnimatedBuilder(
          animation: _animation,
          builder: (context, child) {
            return Transform.scale(
              scale: _animation.value,
              child: Image.asset(
                'assets/images/logo.png', // Chemin vers votre image dans le répertoire assets
                width: 150, // Largeur du logo
                height: 150, // Hauteur du logo
              ),
            );
          },
        ),
      ),
    );
  }
}
