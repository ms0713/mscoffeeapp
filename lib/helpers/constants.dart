// ignore_for_file: constant_identifier_names

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages
import 'package:font_awesome_flutter/font_awesome_flutter.dart' show FontAwesomeIcons;

import '../models/coffee.dart';

const AUTH0_DOMAIN = 'dev-ms0713.us.auth0.com';//String.fromEnvironment('AUTH0_DOMAIN');
const AUTH0_CLIENT_ID = 'UuDoPT83kniuRqmwHEsbCuRx6AZ3tipv';//String.fromEnvironment('AUTH0_CLIENT_ID');
const AUHT0_ISSUER = 'https://$AUTH0_DOMAIN';
const BUNDLE_IDENTIFIER = 'com.example.mscoffeeapp';
const AUTH0_REDIRECT_URI = '$BUNDLE_IDENTIFIER://login-callback';
const REFRESH_TOKEN_KEY = 'refresh_token';

const STREAM_API_KEY = 'emb7fs94cysm';
const STREAM_APP_ID = '1197447';
const STREAM_API_SECRET = 'f8nhhjs7tfvem86cyqwhn7r3uypceyrwetp8w9y6mvw7qjckp6kt544f2gsmtuvs';

const Color darkBrown = Color(0xFFA26E47);
const Color lightBrown = Color(0xFFF9E8D4);
const Color brown = Color(0xFF9C5700);
const Color facebookColor = Color(0xFF4867AA);

final List<Coffee> coffees = [
  const Coffee(
    id: 1001,
    coffeeIcon: FontAwesomeIcons.mugSaucer,
    name: "Espresso ",
    price: 8,
  ),
  const Coffee(
    id: 1002,
    coffeeIcon: FontAwesomeIcons.mugHot,
    name: "Cappuccino",
    price: 10,
  ),
  const Coffee(
    id: 1003,
    coffeeIcon: FontAwesomeIcons.martiniGlassCitrus,
    name: "Mocha",
    price: 12,
  ),
  const Coffee(
    id: 1004,
    coffeeIcon: FontAwesomeIcons.beerMugEmpty,
    name: "Americano",
    price: 7,
  ),
  const Coffee(
    id: 1005,
    coffeeIcon: FontAwesomeIcons.martiniGlassCitrus,
    name: "Italian Macchiato",
    price: 5,
  ),
  const Coffee(
    id: 1006,
    coffeeIcon: FontAwesomeIcons.mugSaucer,
    name: "Flat White",
    price: 3,
  ),
  const Coffee(
    id: 1007,
    coffeeIcon: FontAwesomeIcons.mugHot,
    name: "American Affogato",
    price: 11,
  ),
  const Coffee(
    id: 1008,
    coffeeIcon: FontAwesomeIcons.mugSaucer,
    name: "Long Black",
    price: 4,
  ),
  const Coffee(
    id: 1015,
    coffeeIcon: FontAwesomeIcons.mugHot,
    name: "Latte",
    price: 12,
  ),
  const Coffee(
    id: 1009,
    coffeeIcon: FontAwesomeIcons.martiniGlassCitrus,
    name: "American Espresso",
    price: 9,
  ),
  const Coffee(
      id: 10010,
      coffeeIcon: FontAwesomeIcons.beerMugEmpty,
      name: "CAFÈ AU LAIT.",
      price: 10),
  const Coffee(
      id: 10011,
      coffeeIcon: FontAwesomeIcons.mugSaucer,
      name: "AFFÈ MOCHA.",
      price: 12),
  const Coffee(
    id: 10012,
    coffeeIcon: FontAwesomeIcons.beerMugEmpty,
    name: "Americano",
    price: 7,
  ),
  const Coffee(
    id: 10013,
    coffeeIcon: FontAwesomeIcons.martiniGlassCitrus,
    name: "Double Exspersso",
    price: 5,
  ),
];
