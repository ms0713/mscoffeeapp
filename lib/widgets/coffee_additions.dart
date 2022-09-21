// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

enum CoffeeAdditionals { cake, icecream, cheese }

class CoffeeAdditions extends StatefulWidget {
  const CoffeeAdditions({Key? key}) : super(key: key);

  @override
  _CoffeeAdditionsState createState() => _CoffeeAdditionsState();
}

class _CoffeeAdditionsState extends State<CoffeeAdditions> {
  List<CoffeeAdditionals> additions = [CoffeeAdditionals.cake];

  get hasCake {
    return additions.contains(CoffeeAdditionals.cake);
  }

  get hasIceCream {
    return additions.contains(CoffeeAdditionals.icecream);
  }

  get hasCheese {
    return additions.contains(CoffeeAdditionals.cheese);
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: <Widget>[
        Text(
          "Additions",
          style: TextStyle(
            color: Colors.grey.shade700,
          ),
        ),
        const SizedBox(width: 14),
        IconButton(
          icon: Icon(
            Icons.cake,
            color: getColor(hasCake),
          ),
          onPressed: () {
            toggle(hasCake, CoffeeAdditionals.cake);
          },
        ),
        IconButton(
          icon: Icon(
            FontAwesomeIcons.iceCream,
            color: getColor(additions.contains(CoffeeAdditionals.icecream)),
          ),
          onPressed: () {
            toggle(hasIceCream, CoffeeAdditionals.icecream);
          },
        ),
        IconButton(
          icon: Icon(
            FontAwesomeIcons.cheese,
            color: getColor(additions.contains(CoffeeAdditionals.cheese)),
          ),
          onPressed: () {
            toggle(hasCheese, CoffeeAdditionals.cheese);
          },
        ),
      ],
    );
  }

  getColor(bool isSelected) {
    return isSelected ? Colors.brown.shade800 : Colors.grey.shade400;
  }

  toggle(bool selected, CoffeeAdditionals addition) {
    if (selected) {
      setState(() {
        additions.remove(addition);
      });
    } else {
      setState(() {
        additions.add(addition);
      });
    }
  }
}
