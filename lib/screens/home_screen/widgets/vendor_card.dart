import 'package:flutter/material.dart';
import 'package:bsf/core/utils/ui_helper.dart';
import 'package:bsf/core/widgets/custom_widgets.dart';
import 'package:bsf/screens/favourites.dart';

class VendorCard extends StatefulWidget {
  const VendorCard({
    Key? key,
    required this.imagePath,
    required this.name,
    required this.rating,
  }) : super(key: key);

  final String imagePath;
  final String name;
  final String rating;

  @override
  _VendorCardState createState() => _VendorCardState();
}

class _VendorCardState extends State<VendorCard> {
  bool _isFavorite = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: space2x),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.asset(
              widget.imagePath,
              width: 100,
              height: 100,
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(width: rw(20)),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                widget.name,
                style: Theme.of(context)
                    .textTheme
                    .headline5!
                    .copyWith(fontSize: rf(16)),
              ),
              SizedBox(height: rh(5)),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  CIcons.fromMaterial(
                    icon: Icons.star,
                    semanticLabel: 'rating',
                    size: rf(18),
                    color: const Color(0xffffb740),
                  ),
                  SizedBox(width: rw(5)),
                  Text(
                    widget.rating,
                    style: Theme.of(context)
                        .textTheme
                        .headline6!
                        .copyWith(fontSize: rf(14)),
                  ),
                  Text(
                    '  * Fast food * \$2.5',
                    style: Theme.of(context).textTheme.headline6!.copyWith(
                      color: Colors.grey.shade400,
                      fontSize: rf(12),
                    ),
                  ),
                ],
              ),
              SizedBox(height: rh(10)),
              Row(
                children: <Widget>[
                  Container(
                    padding: const EdgeInsets.all(space1x),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: const Color(0xfff7f2f7),
                    ),
                    child: Row(
                      children: [
                        CIcons.fromMaterial(
                          icon: Icons.timer,
                          semanticLabel: 'Time',
                          size: rf(12),
                          color: const Color(0xff977f98),
                        ),
                        Text(' 15-20 min',
                            style:
                            Theme.of(context).textTheme.bodyText1!.copyWith(
                              fontSize: rf(12),
                              fontWeight: FontWeight.bold,
                              color: const Color(0xff977f98),
                            )),
                      ],
                    ),
                  ),
                  const SizedBox(
                    width: space1x,
                  ),
                  Text(
                    '2.4 km',
                    style: Theme.of(context).textTheme.bodyText1!.copyWith(
                      color: Colors.grey.shade400,
                      fontSize: rf(12),
                    ),
                  ),
                ],
              ),
            ],
          ),
          const Spacer(),
          GestureDetector(
            onTap: () {
              setState(() {
                _isFavorite = !_isFavorite;
              });
              if (_isFavorite) {
                // Navigate to the favorites page and pass vendor data
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(
                //     builder: (context) => FavouritesPage(
                //       name: widget.name,
                //       rating: widget.rating,
                //       imagePath: widget.imagePath,
                //     ),
                //   ),
                // );
              }
            },
            child: _isFavorite
                ? Icon(
              Icons.favorite,
              color: const Color(0xFFF65C71), // Change filled color here
            )
                : Icon(
              Icons.favorite_border,
              color: Theme.of(context).primaryColorDark,
            ),
          ),
        ],
      ),
    );
  }
}
