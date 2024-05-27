import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:spendsmart/password_verification.dart';
import 'package:spendsmart/testlogin.dart';

class CreerCompte extends StatefulWidget {
  @override
  _CreerCompteState createState() => _CreerCompteState();
}

class _CreerCompteState extends State<CreerCompte> {
  final TextEditingController _numCompteController = TextEditingController();

  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
  FlutterLocalNotificationsPlugin();

  @override
  void initState() {
    super.initState();
    _initializeNotifications();
  }

  Future<void> _initializeNotifications() async {
    AndroidInitializationSettings initializationSettingsAndroid =
    AndroidInitializationSettings('@mipmap/ic_launcher');
    InitializationSettings initializationSettings =
    InitializationSettings(android: initializationSettingsAndroid);
    await flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }

  Future<void> _signIn() async {
    try {
      // Récupérer les informations saisies
      int numCompte = int.parse(_numCompteController.text.trim());

      // Vérifier les informations dans Firestore
      var querySnapshot = await FirebaseFirestore.instance
          .collection('Clients')
          .where('numCompteCih', isEqualTo: numCompte)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        // Récupérer le mot de passe à partir du document Firestore
        int password = querySnapshot.docs[0]['password']; // Assurez-vous que 'password' correspond au nom du champ dans votre Firestore

        // Afficher la notification locale
        _showNotification(password.toString());

        // Connexion réussie, rediriger vers la page suivante
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => SaisirMotDePasse(password: password.toString()),
          ),
        );
      } else {
        // Afficher le dialogue d'erreur si le numéro de compte CIH est incorrect
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Erreur de connexion'),
              content: Text(
                  'Le numéro de compte CIH que vous avez saisi semble incorrect. Veuillez vérifier et réessayer !'),
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
      // Gérer les erreurs
      print('Error: $e');
    }
  }

  Future<void> _showNotification(String password) async {
    AndroidNotificationDetails androidPlatformChannelSpecifics =
    AndroidNotificationDetails(
        'your channel id', 'your channel name',
        importance: Importance.max, priority: Priority.high);
    NotificationDetails platformChannelSpecifics =
    NotificationDetails(android: androidPlatformChannelSpecifics);
    await flutterLocalNotificationsPlugin.show(
        0, 'Mot de passe', 'Votre mot de passe est $password', platformChannelSpecifics,
        payload: 'item x');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Supprimer l'appBar
      appBar: null,
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
            SizedBox(height: MediaQuery.of(context).size.height * 0.1),
            Text(
              'Veuillez saisir votre numéro de compte CIH !',
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                  fontStyle: FontStyle.italic// taille de police souhaitée
              ),
            ),
            SizedBox(height: 50), // Ajouter un espace de 20 pixels
            // Centrer les champs de texte
            Container(
              constraints: BoxConstraints(maxWidth: 350), // Largeur maximale des champs de texte
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
                  // Ajouter un espace de 10 pixels
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
                      ' Demander mot de passe',
                      style: TextStyle(color: Colors.white), // Couleur du texte
                    ),
                    icon: Icon(
                      Icons.attach_email,
                      color: Colors.white, // Couleur de l'icône
                    ),
                    style: ElevatedButton.styleFrom(
                      primary: Colors.deepOrange, // Couleur de fond du bouton
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
