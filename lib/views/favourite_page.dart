import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tatsamAssignment/viewmodels/country_view_model.dart';
import 'package:tatsamAssignment/widgets/country_tile.dart';

class FavoritePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Favourites"),
      ),
      body: Consumer<CountryProvider>(
        builder: (context, countryvm, child) => Column(
          children: countryvm.favorites.isEmpty
              ? [Expanded(child: Center(child: Text("No Favorites Added")))]
              : List.generate(
                  countryvm.favorites.length,
                  (index) => CountryTile(
                        country: countryvm.favorites[index],
                        isFavorite:
                            countryvm.isFavorite(countryvm.favorites[index]),
                      )),
        ),
      ),
    );
  }
}
