import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tatsamAssignment/services/connectivity_service.dart';
import 'package:tatsamAssignment/viewmodels/country_view_model.dart';
import 'package:tatsamAssignment/views/favourite_page.dart';
import 'package:tatsamAssignment/widgets/country_tile.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  ScrollController _scrollController;
  CountryProvider countryvm;
  @override
  void initState() {
    countryvm = Provider.of<CountryProvider>(context, listen: false);
    countryvm.getcountries();
    _activatePaginationScrolling();

    super.initState();
  }

  _activatePaginationScrolling() {
    _scrollController = ScrollController();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        countryvm.getMoreCountries();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Countries"),
        actions: [
          FlatButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => FavoritePage()));
              },
              child: Text("Favourites"))
        ],
      ),
      body: Consumer<ConnectivityStatus>(builder: (context, connection, child) {
        if (connection == ConnectivityStatus.Offline) {
          return Center(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Icon(Icons.network_check),
                  Text("Please Check Your Internet"),
                ],
              ),
            ),
          );
        } else {
          return Container(
            child: Consumer<CountryProvider>(
              builder: (_, countries, child) => ListView.builder(
                controller: _scrollController,
                itemCount: countries.contries.length,
                itemBuilder: (_, index) => index ==
                            countries.contries.length - 1 &&
                        !countries.isEndOfList
                    ? Center(child: CircularProgressIndicator())
                    : Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: CountryTile(
                          country: countries.contries[index],
                          isFavorite:
                              countries.isFavorite(countries.contries[index]),
                          onFavIconTap: () {
                            countries.isFavorite(countries.contries[index])
                                ? countries
                                    .deleteFavorite(countries.contries[index])
                                : countries
                                    .addToFavorites(countries.contries[index]);
                          },
                        )),
              ),
            ),
          );
        }
      }),
    );
  }
}
