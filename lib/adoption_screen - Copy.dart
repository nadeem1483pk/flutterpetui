import 'dart:convert';
import 'dart:html';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'custom_alert_dialog.dart';
import 'package:http/http.dart' as http;
import 'package:petpal_ui/model/api2model.dart';

class Animal {
  String name;
  String scientificName;
  double age;
  String distanceToUser;
  bool isFemale;
  String imageUrl;
  Color backgroundColor;

  Animal({
    required this.name,
    required this.scientificName,
    required this.age,
    required this.distanceToUser,
    required this.isFemale,
    required this.imageUrl,
    required this.backgroundColor,
  });
}

class AdoptionScreen extends StatefulWidget {
  @override
  _AdoptionScreenState createState() => _AdoptionScreenState();
}

class _AdoptionScreenState extends State<AdoptionScreen> {
  int selectedAnimalIconIndex = 0;
  List<Animalnew> animalTypes = [];

  List<Product> products = [];

  /*List<String> animalTypes = [
    'All',
    'cats',
    'dogs',
    'parrots',
    'fish',
    'fish',
  ];*/

  List<IconData> animalIcons = [
    FontAwesomeIcons.ban,
    FontAwesomeIcons.cat,
    FontAwesomeIcons.dog,
    FontAwesomeIcons.crow,
    FontAwesomeIcons.fish,
    FontAwesomeIcons.fish,
  ];
  @override
  void initState() {
    super.initState();
    fetchProducts(0);
    fetchAnimals();
  }

  Future<void> fetchAnimals() async {
    final response = await http
        .get(Uri.parse('https://mybizit.com/ci4_api_data/api/categories_list'));

    if (response.statusCode == 200) {
      var res = json.decode(response.body);
      List<dynamic> data = res['data'];
      setState(() {
        animalTypes = data.map((item) => Animalnew.fromJson(item)).toList();
      });
    } else {
      throw Exception('Failed to load animals');
    }
  }

  Future<void> fetchProducts(categoryid) async {
    // you can replace your api link with this link: https://lightningspeeddating.com/events/api/blogs
    Map<String, String> headers = {
      "Content-Type": "text/json",
    };
    final response = await http.get(Uri.parse(
        'https://mybizit.com/ci4_api_data/api/products_list?category_id=${categoryid}'));
    if (response.statusCode == 200) {
      // print(listdata['allblogs']);
      List<dynamic> jsonData = json.decode(response.body);

      setState(() {
        products = jsonData.map((data) => Product.fromJson(data)).toList();
      });
    } else {
      // Handle error if needed
    }
  }

  void onAnimalIconTap(int index) {
    // Define what happens when an item is tapped
    var dialog = CustomAlertDialog(
        title: "Logout",
        message: "Are you sure, do you want to logout?",
        onPostivePressed: () {},
        positiveBtnText: 'Yes',
        negativeBtnText: 'No');
  }

  Widget buildAnimalIcon(animal) {
    return Padding(
        padding: EdgeInsets.only(right: 30.0),
        child: Column(
          children: <Widget>[
            InkWell(
              onTap: () {
                print('Tapped on: ${animal.name}');
                fetchProducts(animal.id);
                var dialog = CustomAlertDialog(
                    title: '${animal.name} Animal Listing',
                    message: "Are you sure, do you want to see?",
                    onPostivePressed: () {},
                    positiveBtnText: 'Yes',
                    negativeBtnText: 'No');
                showDialog(
                    context: context,
                    builder: (BuildContext context) => dialog);
                setState(() {
                  selectedAnimalIconIndex = int.parse(animal.id);
                });
              },
              child: Material(
                color: selectedAnimalIconIndex == int.parse(animal.id)
                    ? Theme.of(context).primaryColor
                    : Colors.white,
                elevation: 8.0,
                borderRadius: BorderRadius.circular(20.0),
                child: Padding(
                  padding: EdgeInsets.all(20.0),
                  child: Icon(
                    animalIcons[int.parse(animal.id)],
                    size: 25.0,
                    color: selectedAnimalIconIndex == int.parse(animal.id)
                        ? Colors.white
                        : Theme.of(context).primaryColor,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 10.0,
            ),
            Text(
              animal.name,
              style: TextStyle(
                color: Theme.of(context).primaryColor,
                fontSize: 16.0,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ));
  }

  @override
  Widget build(BuildContext context) {
    final devicewidth = MediaQuery.of(context).size.width;
    return Material(
      child: Padding(
        padding: EdgeInsets.only(top: 50.0),
        child: Column(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 22.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Icon(FontAwesomeIcons.bars),
                  Column(
                    children: <Widget>[
                      Text(
                        'Adoption',
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 22.0,
                          color:
                              Theme.of(context).primaryColor.withOpacity(0.5),
                        ),
                      ),
                    ],
                  ),
                  CircleAvatar(
                    radius: 20.0,
                    backgroundImage: AssetImage('assets/images/adoption.jpg'),
                  )
                ],
              ),
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.only(top: 60.0),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30.0),
                    color: Theme.of(context).primaryColor.withOpacity(0.06),
                  ),
                  child: Column(
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 24.0,
                          vertical: 22.0,
                        ),
                        child: Container(
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20.0)),
                          padding: EdgeInsets.symmetric(horizontal: 12.0),
                          child: Row(
                            children: <Widget>[
                              Icon(
                                FontAwesomeIcons.search,
                                color: Colors.grey,
                              ),
                              Expanded(
                                child: TextField(
                                  style: TextStyle(fontSize: 18.0),
                                  decoration: InputDecoration(
                                      border: OutlineInputBorder(
                                          borderSide: BorderSide.none),
                                      hintText: 'Search Pets to Adopt'),
                                ),
                              ),
                              Icon(
                                FontAwesomeIcons.filter,
                                color: Colors.grey,
                              ),
                            ],
                          ),
                        ),
                      ),
                      Container(
                        height: 100.0,
                        child: ListView.builder(
                            padding: EdgeInsets.only(left: 24.0),
                            scrollDirection: Axis.horizontal,
                            itemCount: animalTypes.length,
                            itemBuilder: (context, index) {
                              return buildAnimalIcon(animalTypes[index]);
                            }),
                      ),
                      Expanded(
                        child: ListView.builder(
                            padding: EdgeInsets.only(
                              top: 10.0,
                            ),
                            itemCount: products.length,
                            itemBuilder: (Context, index) {
                              final product = products[index];

                              return Padding(
                                padding: EdgeInsets.only(
                                    bottom: 10.0, right: 20.0, left: 20.0),
                                child: Stack(
                                  alignment: Alignment.centerLeft,
                                  children: <Widget>[
                                    Material(
                                      borderRadius: BorderRadius.circular(20.0),
                                      elevation: 4.0,
                                      child: Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 20.0, vertical: 20.0),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: <Widget>[
                                            SizedBox(
                                              width: devicewidth * 0.4,
                                            ),
                                            Flexible(
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: <Widget>[
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    mainAxisSize:
                                                        MainAxisSize.max,
                                                    children: <Widget>[
                                                      Text(
                                                        product.title,
                                                        style: TextStyle(
                                                          fontSize: 26.0,
                                                          color:
                                                              Theme.of(context)
                                                                  .primaryColor,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                        ),
                                                      ),
                                                      Icon(FontAwesomeIcons
                                                          .venus),
                                                    ],
                                                  ),
                                                  SizedBox(
                                                    height: 10.0,
                                                  ),
                                                  Text(
                                                    product.title,
                                                    style: TextStyle(
                                                      fontSize: 16.0,
                                                      color: Theme.of(context)
                                                          .primaryColor,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: 10.0,
                                                  ),
                                                  Text(
                                                    '${product.title} years old',
                                                    style: TextStyle(
                                                      fontSize: 26.0,
                                                      color: Colors.grey,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: 10.0,
                                                  ),
                                                  Row(
                                                    children: <Widget>[
                                                      Icon(
                                                        FontAwesomeIcons
                                                            .mapMarkerAlt,
                                                        color: Theme.of(context)
                                                            .primaryColor,
                                                        size: 14.0,
                                                      ),
                                                      SizedBox(
                                                        width: 6.0,
                                                      ),
                                                      Text(
                                                        'Distance: ${product.title}',
                                                        style: TextStyle(
                                                          fontSize: 16.0,
                                                          color:
                                                              Theme.of(context)
                                                                  .primaryColor,
                                                          fontWeight:
                                                              FontWeight.w400,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    Stack(
                                      children: <Widget>[
                                        Container(
                                          decoration: BoxDecoration(
                                            color: Color.fromRGBO(
                                                203, 213, 216, 1.0),
                                            borderRadius:
                                                BorderRadius.circular(20.0),
                                          ),
                                          height: 220.0,
                                          width: devicewidth * 0.4,
                                        ),
                                        Image(
                                          image: AssetImage(
                                              'assets/images/sola.png'),
                                          height: 220.0,
                                          width: devicewidth * 0.4,
                                        ),
                                      ],
                                      alignment: Alignment.center,
                                    )
                                  ],
                                ),
                              );
                            }),
                      )
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
