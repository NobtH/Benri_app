import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../view_models/ingredient_provider.dart';
import '../widgets/ingredient_fridge_view.dart';

class DetailFridgeScreen extends StatelessWidget {
  const DetailFridgeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<IngredientProvider>(
        builder: (context, provider, child) {
          // Get ingredients with drawer names
          final ingredientsWithDrawers = provider.getAllIngredientsWithDrawer();

          // Sort ingredients by expiration date
          ingredientsWithDrawers.sort((a, b) {
            final DateTime expirationA = a['ingredient'].expirationDate;
            final DateTime expirationB = b['ingredient'].expirationDate;
            return expirationA.compareTo(
                expirationB); // Ascending order (soonest to latest expiration)
          });

          return ingredientsWithDrawers.isEmpty
              ? const Center(child: Text('No ingredients in the fridge yet.'))
              : ListView.builder(
                  itemCount: ingredientsWithDrawers.length,
                  itemBuilder: (context, index) {
                    final ingredientData = ingredientsWithDrawers[index];
                    final drawerName =
                        ingredientData['drawerName']; // Get the drawer name
                    final ingredient = ingredientData['ingredient'];

                    return IngredientFridgeView(
                      ingredient: ingredient,
                      drawerName:
                          drawerName, // Pass the drawer name to the widget
                      deleteIngredient: (context) {
                        // Handle deletion if needed
                      },
                    );
                  },
                );
        },
      ),
    );
  }
}