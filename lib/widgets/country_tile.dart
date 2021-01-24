import 'package:flutter/material.dart';
import 'package:tatsamAssignment/models/country.dart';

class CountryTile extends StatefulWidget {
  final Country country;
  final bool isFavorite;
  final Function onFavIconTap;
  CountryTile({this.country, this.isFavorite, this.onFavIconTap});
  @override
  _CountryTileState createState() => _CountryTileState();
}

class _CountryTileState extends State<CountryTile> {
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 10,
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(
                widget.country.code,
                style: TextStyle(fontSize: 15, color: Colors.grey[400]),
              ),
              Text(
                widget.country.countryName,
                overflow: TextOverflow.fade,
                style: TextStyle(
                  color: Theme.of(context).accentColor,
                  fontSize: 13,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Text(widget.country.region),
            ]),
            GestureDetector(
                onTap: widget.onFavIconTap,
                child: Icon(Icons.favorite,
                    color: widget.isFavorite ? Colors.red : Colors.grey))
          ],
        ),
      ),
    );
  }
}
