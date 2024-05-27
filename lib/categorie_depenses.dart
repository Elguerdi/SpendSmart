import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:spendsmart/montant_depenses.dart';

class ExpensesCategoryPage extends StatefulWidget {
  @override
  _ExpensesCategoryPageState createState() => _ExpensesCategoryPageState();
}

class _ExpensesCategoryPageState extends State<ExpensesCategoryPage> {
  Set<int> selectedIndices = Set<int>(); // Ensemble pour stocker les indices des éléments sélectionnés

  final List<String> categories = [
    'Alimentation',
    'Logement',
    'Transport',
    'Divertissement',
    'Santé',
    'Éducation',
    'Vêtements',
    'Frais bancaires',
    'Factures'
  ];

  final List<String> categoryImages = [
    'alimentation.png',
    'logement.png',
    'transport.png',
    'divertissement.png',
    'sante.png',
    'education.png',
    'vetement.png',
    'bancaire.png',
    'facture.png'
  ];

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
              'Sélectionnez la catégorie correspondante à vos Dépenses :',
              style: TextStyle(fontSize: 18),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 50),
            Expanded(
              child: GridView.count(
                crossAxisCount: 3,
                mainAxisSpacing: 30,
                children: List.generate(categories.length, (index) {
                  return _buildCategoryItem(categoryImages[index], categories[index], index);
                }),
              ),
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: FloatingActionButton(
                onPressed: () {
                  // Navigate to MontantDepensePage with the selected categories
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => MontantDepensePage(
                        selectedCategories: selectedIndices.map((index) => categories[index]).toList(),
                        selectedCategoryImages: selectedIndices.map((index) => categoryImages[index]).toList(),
                      ),
                    ),
                  );
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

  Widget _buildCategoryItem(String imageName, String label, int index) {
    bool isSelected = selectedIndices.contains(index); // Vérifie si cet élément est sélectionné
    return GestureDetector(
      onTap: () {
        setState(() {
          // Met à jour l'ensemble des indices sélectionnés
          if (isSelected) {
            selectedIndices.remove(index);
          } else {
            selectedIndices.add(index);
          }
        });
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          CircleAvatar(
            radius: 45,
            backgroundColor: isSelected ? Colors.deepOrange.withOpacity(0.3) : Colors.transparent, // Change la couleur de fond si l'élément est sélectionné
            child: ColorFiltered(
              colorFilter: isSelected
                  ? ColorFilter.mode(Colors.black.withOpacity(0.5), BlendMode.srcATop)
                  : ColorFilter.mode(Colors.transparent, BlendMode.dst),
              child: Image.asset('assets/images/$imageName'),
            ),
          ),
          SizedBox(height: 8),
          Text(
            label,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: isSelected ? Colors.deepOrange : null, // Change la couleur du texte si l'élément est sélectionné
            ),
          ),
        ],
      ),
    );
  }
}
