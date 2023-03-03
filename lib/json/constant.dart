import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:stockx/pages/categories/NTFs.dart';
import 'package:stockx/pages/categories/accessories.dart';
import 'package:stockx/pages/categories/apperal.dart';
import 'package:stockx/pages/categories/collectibles.dart';
import 'package:stockx/pages/categories/electronic.dart';
import 'package:stockx/pages/categories/sneaker.dart';
import 'package:stockx/pages/categories/tradingCart.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

const String homeImg =
    'https://images.contentstack.io/v3/assets/blt818b0c67cf450811/bltb1381160474c9592/626989c222962450e3bb7701/Primary_Mobile_(1)_(1).png?quality=90&auto=webp&format=pjpg&height=280';

const String logoGoogle =
    "https://i.pinimg.com/originals/74/65/f3/7465f30319191e2729668875e7a557f2.png";
const String logoTwitter =
    "https://www.batdongsanhungphat.vn/wp-content/uploads/2021/10/twitter-logo-icon-vector-29228035.jpg";
const String logoApple =
    "https://banner2.cleanpng.com/20190504/cos/kisspng-apple-logo-design-new-york-vector-graphics-tecnologie-utilizzate-alcuni-software-utilizzati-5ccdbaa498fc56.1275154215569865326266.jpg";
const String logoFacebook =
    "https://upload.wikimedia.org/wikipedia/commons/0/05/Facebook_Logo_%282019%29.png";
const String profileUrl =
    "https://images.unsplash.com/photo-1616597082843-de7ce757d548?ixid=MXwxMjA3fDB8MHxlZGl0b3JpYWwtZmVlZHw0N3x8fGVufDB8fHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=800&q=60";
const String advertisement =
    'https://images.contentstack.io/v3/assets/blt818b0c67cf450811/blt29c5473cfaf0fe89/62714fc00cffdf1eb1368a9c/2022-04-28-POW-banners-SecondaryB.png?format=jpg&auto=webp&height=425';
const String advertisement2 =
    'https://images.contentstack.io/v3/assets/blt818b0c67cf450811/blt093318f77ccce5a2/62714fc00d4d8e1d7f10e17f/2022-04-28-TheRip-SecondaryB-EN.png?format=jpg&auto=webp&height=425';
const String logoStockX =
    'https://d2p887mzam0wn6.cloudfront.net/production/uploads/2021/03/X_Green_Digital_RGB-700x800.png';

const List UserManager = ['Sign Up', 'Log In'];
const List P2P = ['Sell', 'Buy'];

const List CategoryTab = [
  SneakerPage(),
  AppreralPage(),
  ElectronicPage(),
  TradingPage(),
  CollectiblesPage(),
  AccessoriesPage(),
  NFTsPage(),
];

List<ChartSampleData> chartData = [
  ChartSampleData(
      x: DateTime(2016, 01, 11),
      open: 98.97,
      high: 101.19,
      low: 95.36,
      close: 97.13),
  ChartSampleData(
      x: DateTime(2016, 01, 18),
      open: 98.41,
      high: 101.46,
      low: 93.42,
      close: 101.42),
  ChartSampleData(
      x: DateTime(2016, 01, 25),
      open: 101.52,
      high: 101.53,
      low: 92.39,
      close: 97.34),
  ChartSampleData(
      x: DateTime(2016, 02, 01),
      open: 96.47,
      high: 97.33,
      low: 93.69,
      close: 94.02),
  ChartSampleData(
      x: DateTime(2016, 02, 08),
      open: 93.13,
      high: 96.35,
      low: 92.59,
      close: 93.99),
  ChartSampleData(
      x: DateTime(2016, 02, 15),
      open: 95.02,
      high: 98.89,
      low: 94.61,
      close: 96.04),
  ChartSampleData(
      x: DateTime(2016, 02, 22),
      open: 96.31,
      high: 98.0237,
      low: 93.32,
      close: 96.91),
  ChartSampleData(
      x: DateTime(2016, 02, 29),
      open: 96.86,
      high: 103.75,
      low: 96.65,
      close: 103.01),
  ChartSampleData(
      x: DateTime(2016, 03, 07),
      open: 102.39,
      high: 102.83,
      low: 100.15,
      close: 102.26),
  ChartSampleData(
      x: DateTime(2016, 03, 12),
      open: 106.5,
      high: 106.5,
      low: 110.5,
      close: 109.5),
];

class ChartSampleData {
  ChartSampleData({this.x, this.open, this.high, this.low, this.close});

  final DateTime? x;
  final double? open;
  final double? high;
  final double? low;
  final double? close;
}

List itemsTab = [
  {"icon": FontAwesomeIcons.home, "size": 25.0},
  {"icon": FontAwesomeIcons.search, "size": 22.0},
  {"icon": FontAwesomeIcons.bell, "size": 21.0},
  {"icon": FontAwesomeIcons.sellcast, "size": 21.0},
  {"icon": FontAwesomeIcons.user, "size": 22.0},
];
