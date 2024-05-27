import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:spendsmart/categorie_depenses.dart';

class OptionSolde extends StatelessWidget {
  final String numCompte;
  final double solde;

  OptionSolde({required this.numCompte, required this.solde});

  void _checkMontant(BuildContext context) async {
    TextEditingController montantController = TextEditingController();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Personnaliser un montant'),
          content: TextField(
            controller: montantController,
            decoration: InputDecoration(
              labelText: 'Entrez le montant',
            ),
            keyboardType: TextInputType.number,
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                double? montant = double.tryParse(montantController.text);
                if (montant == null || montant > solde) {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text('Erreur'),
                        content: Text('Le montant saisi est supérieur à votre solde.'),
                        actions: <Widget>[
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
                } else {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ExpensesCategoryPage()
                    ),
                  );
                  // Effectuez l'action souhaitée avec le montant validé
                }
              },
              child: Text('Valider'),
            ),
          ],
        );
      },
    );
  }

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
                  image: AssetImage('assets/images/solde.jpg'),
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
                  'Choisissez votre option de gestion de Solde!',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontFamily: 'RobotoMono', // Utilisez une police personnalisée
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 100),
                // Bouton pour voir le solde actuel
                SizedBox(
                  width: 330, // Largeur fixe du bouton
                  height: 60, // Hauteur fixe du bouton
                  child: ElevatedButton(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text('Solde Actuel'),
                            content: Text('Votre solde actuel est de ${solde.toStringAsFixed(2)} DH'),
                            actions: <Widget>[
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
                    },
                    style: ElevatedButton.styleFrom(
                      primary: Colors.deepOrange,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: Text(
                      'Voir le solde actuel',
                      style: TextStyle(fontSize: 18, color: Colors.white),
                    ),
                  ),
                ),
                SizedBox(height: 40),
                // Bouton pour personnaliser un montant à gérer
                SizedBox(
                  width: 330, // Largeur fixe du bouton
                  height: 60, // Hauteur fixe du bouton
                  child: ElevatedButton(
                    onPressed: () => _checkMontant(context),
                    style: ElevatedButton.styleFrom(
                      primary: Colors.deepOrange,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: Text(
                      'Personnaliser un montant à gérer',
                      style: TextStyle(fontSize: 18, color: Colors.white),
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
