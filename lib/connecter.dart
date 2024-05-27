import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:spendsmart/connecter.dart';
import 'package:spendsmart/otionsolde.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _numCompteController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  Future<void> _signIn() async {
    try {
      String numCompte = _numCompteController.text.trim();
      String password = _passwordController.text.trim();

      var querySnapshot = await FirebaseFirestore.instance
          .collection('Clients')
          .where('numCompteCih', isEqualTo: int.parse(numCompte))
          .where('password', isEqualTo: int.parse(password))
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        var clientData = querySnapshot.docs.first.data();
        double solde = (clientData['solde'] as num).toDouble(); // Convert to double

        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => OptionSolde(
              numCompte: numCompte,
              solde: solde,
            ),
          ),
        );
      } else {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Erreur de connexion'),
              content: Text('Identifiants incorrects. Veuillez réessayer.'),
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
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: null,
      resizeToAvoidBottomInset: false,
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
            SizedBox(height: 100),
            SizedBox(height: MediaQuery.of(context).size.height * 0.1),
            Text(
              'Veuillez saisir votre numéro de compte CIH !',
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
              ),
            ),
            SizedBox(height: 50),
            Container(
              constraints: BoxConstraints(maxWidth: 350),
              child: Column(
                children: [
                  TextField(
                    controller: _numCompteController,
                    decoration: InputDecoration(
                      labelText: 'Numéro de compte CIH',
                      filled: true,
                      fillColor: Colors.white,
                    ),
                    keyboardType: TextInputType.number,
                  ),
                  SizedBox(height: 20),
                  TextField(
                    controller: _passwordController,
                    decoration: InputDecoration(
                      labelText: 'Mot de passe',
                      filled: true,
                      fillColor: Colors.white,
                    ),
                    obscureText: true,
                    keyboardType: TextInputType.number,
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
                  child: ElevatedButton.icon(
                    onPressed: _signIn,
                    label: Text(
                      'Connecter',
                      style: TextStyle(color: Colors.white),
                    ),
                    icon: Icon(
                      Icons.arrow_forward_outlined,
                      color: Colors.white,
                    ),
                    style: ElevatedButton.styleFrom(
                      primary: Colors.deepOrange,
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


