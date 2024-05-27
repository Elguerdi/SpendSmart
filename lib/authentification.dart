import 'package:flutter/material.dart';
import 'package:spendsmart/connecter.dart';
import 'package:spendsmart/creer_compte.dart';

class AuthentificationPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Arrière-plan avec shader sombre
          ShaderMask(
            shaderCallback: (rect) => LinearGradient(
              begin: Alignment.bottomCenter,
              end: Alignment.center,
              colors: [
                Colors.black38,
                Colors.transparent,
              ],
            ).createShader(rect),
            blendMode: BlendMode.darken,
            child: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/authentification.jpg'),
                  fit: BoxFit.cover,
                  colorFilter: ColorFilter.mode(Colors.white10, BlendMode.darken),
                ),
              ),
            ),
          ),
          // Logo en haut de l'écran
          Positioned(
            top: 40, // Position du haut de l'écran
            left: 0,
            right: 0,
            child: Center(
              child: Image.asset(
                'assets/images/loggoo.png', // Chemin vers votre logo
                width: 50,
                height: 50,
              ),
            ),
          ),
          // Contenu au centre
          Positioned(
            bottom: MediaQuery.of(context).size.height * 0.2, // Position du bas de l'écran (20% de la hauteur)
            left: 0,
            right: 0,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Texte d'introduction
                Text(
                  'Connectez-vous à votre Compte existant\nou créez un nouveau Compte!',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontFamily: 'RobotoMono', // Utilisez une police personnalisée
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 100),
                // Bouton pour se connecter
                SizedBox(
                  width: 230, // Largeur fixe du bouton
                  height: 60, // Hauteur fixe du bouton
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => LoginPage()),
                      );
                      // Action à effectuer lors du clic sur le bouton de connexion
                      // Exemple : navigation vers la page de connexion
                    },
                    style: ElevatedButton.styleFrom(
                      primary: Colors.deepOrange,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: Text(
                      'Se connecter',
                      style: TextStyle(fontSize: 18,color: Colors.white),
                    ),
                  ),
                ),
                SizedBox(height:40),
                // Bouton pour créer un compte
                SizedBox(
                  width: 230, // Largeur fixe du bouton
                  height: 60, // Hauteur fixe du bouton
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => CreerCompte()),
                      );
                      // Action à effectuer lors du clic sur le bouton de connexion
                      // Exemple : navigation vers la page de connexion
                    },
                    style: ElevatedButton.styleFrom(
                      primary: Colors.deepOrange,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: Text(
                      'Créer un Compte',
                      style: TextStyle(fontSize: 18,color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
