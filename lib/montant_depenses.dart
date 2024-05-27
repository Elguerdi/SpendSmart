import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class MontantDepensePage extends StatefulWidget {
  final List<String> selectedCategories;
  final List<String> selectedCategoryImages;

  MontantDepensePage({required this.selectedCategories, required this.selectedCategoryImages});

  @override
  _MontantDepensePageState createState() => _MontantDepensePageState();
}

class _MontantDepensePageState extends State<MontantDepensePage> {
  final Map<String, TextEditingController> _totalControllers = {};
  final Map<String, TextEditingController> _monthlyControllers = {};

  @override
  void initState() {
    super.initState();
    for (var category in widget.selectedCategories) {
      _totalControllers[category] = TextEditingController();
      _monthlyControllers[category] = TextEditingController();
    }
  }

  @override
  void dispose() {
    for (var controller in _totalControllers.values) {
      controller.dispose();
    }
    for (var controller in _monthlyControllers.values) {
      controller.dispose();
    }
    super.dispose();
  }

  void _removeCategory(int index) {
    setState(() {
      String category = widget.selectedCategories[index];
      widget.selectedCategories.removeAt(index);
      widget.selectedCategoryImages.removeAt(index);
      _totalControllers.remove(category);
      _monthlyControllers.remove(category);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            SizedBox(height: 20),
            Image.asset(
              'assets/images/loggoo.png',
              height: 50,
            ),
            SizedBox(height: 20),
            Text(
              'Veuillez saisir le montant correspondant à chaque dépense !',
              style: TextStyle(fontSize: 18),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: widget.selectedCategories.length,
                itemBuilder: (context, index) {
                  String category = widget.selectedCategories[index];
                  String categoryImage = widget.selectedCategoryImages[index];
                  return Card(
                    margin: EdgeInsets.symmetric(vertical: 10.0),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CircleAvatar(
                            radius: 20,
                            backgroundColor: Colors.transparent,
                            child: Image.asset('assets/images/$categoryImage'),
                          ),
                          SizedBox(width: 10),
                          Expanded(
                            child: Text(
                              category,
                              style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
                            ),
                          ),
                          SizedBox(
                            width: 150, // Largeur de l'espace réservé pour les montants
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                SizedBox(
                                  width: 60, // Augmentez la largeur de l'espace réservé pour le montant total
                                  child: TextField(
                                    controller: _totalControllers[category],
                                    keyboardType: TextInputType.number,
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                                Text(
                                  '/',
                                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                                ),
                                SizedBox(
                                  width: 60, // Augmentez la largeur de l'espace réservé pour le montant mensuel
                                  child: TextField(
                                    controller: _monthlyControllers[category],
                                    keyboardType: TextInputType.number,
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          IconButton(
                            icon: Icon(Icons.clear),
                            onPressed: () {
                              _removeCategory(index);
                            },
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: FloatingActionButton(
                onPressed: () {
                  // Collect and handle the entered amounts
                  Map<String, Map<String, String>> enteredAmounts = {};
                  _totalControllers.forEach((key, controller) {
                    enteredAmounts[key] = {
                      'total': controller.text,
                      'monthly': _monthlyControllers[key]!.text,
                    };
                  });
                  print(enteredAmounts); // Handle the entered amounts as needed

                  // Navigate back or to another page
                },
                child: Icon(Icons.arrow_forward),
                backgroundColor: Colors.deepOrange,
              ),
            ),
          ],
        ),
      ),
    );
  }
}