import 'package:flutter/material.dart';
import 'package:spendsmart/categorie_depenses.dart';
import 'package:spendsmart/connecter.dart';

class SaisirMotDePasse extends StatelessWidget {
  final String password;

  SaisirMotDePasse({required this.password});

  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: null, // Supprimer l'appBar
      resizeToAvoidBottomInset: false, // Pour éviter le déplacement de l'image de fond
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/connecter.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 40),
            Image.asset(
              'assets/images/loggoo.png',
              width: 50,
              height: 50,
            ),
            SizedBox(height: 150),
            Text(
              'Saisir le mot de passe que vous avez reçu dans la notification!',
              style: TextStyle(
                color: Colors.white,
                fontSize: 20, // Taille de police souhaitée
                fontWeight: FontWeight.w400,
              ),
            ),
            SizedBox(height: 50),
            Container(
              constraints: BoxConstraints(maxWidth: 350), // Largeur maximale des champs de texte
              child: Column(
                children: [
                  TextField(
                    controller: _passwordController,
                    decoration: InputDecoration(
                      labelText: 'Mot de passe',
                      filled: true,
                      fillColor: Colors.white,
                    ),
                    keyboardType: TextInputType.number,
                    obscureText: true,
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            Expanded(
              child: Align(
                alignment: Alignment.bottomRight,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: ElevatedButton(
                    onPressed: () {
                      // Vérifier si le mot de passe est correct
                      if (_passwordController.text.trim() == password) {
                        // Afficher la page d'accueil si le mot de passe est correct
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (context) => ExpensesCategoryPage()),
                        );
                      } else {
                        // Afficher une alerte si le mot de passe est incorrect
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: Row(
                                children: [
                                  Icon(Icons.error, color: Colors.red),
                                  SizedBox(width: 10),
                                  Text('Erreur'),
                                ],
                              ),
                              content: Text('Mot de passe incorrect'),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: Text('OK'),
                                ),
                              ],
                            );
                          },
                        );

                      }
                    },


                    child: Text(

                      'Connexion',
                      style: TextStyle(color: Colors.white,fontSize: 19,),
                      // Changer la couleur du texte en blanc
                    ),
                    style: ElevatedButton.styleFrom(

                      primary: Colors.deepOrange, // Couleur de fond du bouton
                      shape: RoundedRectangleBorder(

                        borderRadius: BorderRadius.circular(10.0), // Ajouter un rayon de bordure
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class AccueilPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Accueil'),
      ),
      body: Center(
        child: Text('Bienvenue sur la page d\'accueil!'),
      ),
    );
  }
}
