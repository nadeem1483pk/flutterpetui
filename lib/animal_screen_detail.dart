import 'dart:convert';
import 'dart:html';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:petpal_ui/adoption_screen.dart';
import 'package:petpal_ui/model/api2model.dart';
import 'package:http/http.dart' as http;

class AnimalDetailScreen extends StatefulWidget {
  final String productId;
  AnimalDetailScreen({required this.productId});
  @override
  _AnimalDetailScreenState createState() => _AnimalDetailScreenState();
}

class _AnimalDetailScreenState extends State<AnimalDetailScreen> {
  List<Product> products = [];

  final Animal animal = Animal(
    name: '',
    scientificName: '',
    age: 0,
    distanceToUser: '',
    isFemale: true,
    imageUrl: '',
    backgroundColor: Color.fromRGBO(203, 213, 216, 1.0),
  );
  @override
  void initState() {
    super.initState();

    fetchProductDetail(widget.productId);
  }

  Future<void> fetchProductDetail(productId) async {
    // you can replace your api link with this link: https://lightningspeeddating.com/events/api/blogs
    Map<String, String> headers = {
      "Content-Type": "text/json",
    };
    final response = await http.get(Uri.parse(
        'https://mybizit.com/ci4_api_data/api/products_detail/${productId}'));
    if (response.statusCode == 200) {
      // print(listdata['allblogs']);
      List<dynamic> jsonData = json.decode(response.body);

      setState(() {
        products = jsonData.map((data) => Product.fromJson(data)).toList();
        animal.name = products[0].title;
        animal.scientificName = products[0].scientific_name;
        animal.imageUrl = products[0].image;
      });
    } else {
      // Handle error if needed
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    print('product ID' + widget.productId);

    return Scaffold(
      body: SingleChildScrollView(
        child: Stack(
          alignment: Alignment.center,
          children: <Widget>[
            Column(
              children: <Widget>[
                Stack(
                  alignment: Alignment.center,
                  children: <Widget>[
                    Container(
                      height: screenHeight * 0.5,
                      color: animal.backgroundColor,
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 20.0,
                          vertical: 60.0,
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Icon(
                                  FontAwesomeIcons.arrowLeft,
                                  color: Theme.of(context).primaryColor,
                                ),
                                Icon(
                                  CupertinoIcons.share,
                                  color: Theme.of(context).primaryColor,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      height: screenHeight * 0.35,
                      child: Image(
                        image: NetworkImage(animal.imageUrl),
                        fit: BoxFit.fitHeight,
                      ),
                    ),
                  ],
                ),
                Expanded(
                    child: Container(
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 22.0,
                      vertical: 30.0,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          mainAxisSize: MainAxisSize.max,
                          children: <Widget>[
                            CircleAvatar(
                              radius: 20.0,
                              backgroundImage:
                                  AssetImage('assets/images/me.jpg'),
                            ),
                            SizedBox(
                              width: 8.0,
                            ),
                            Flexible(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Text(
                                        'Tahir khan',
                                        style: TextStyle(
                                          color: Theme.of(context).primaryColor,
                                          fontSize: 16.0,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Text(
                                        'May 25, 2019',
                                        style: TextStyle(
                                          color: Colors.grey,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 10.0,
                                  ),
                                  Text(
                                    'Owner',
                                    style: TextStyle(
                                      color: Colors.grey,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 20.0,
                        ),
                        Text(
                          'I want to donate my pet,coz of moving another country for job, so would you like to adopt it',
                          style: TextStyle(
                            color: Colors.grey,
                            fontWeight: FontWeight.w600,
                            fontSize: 16.0,
                          ),
                        ),
                      ],
                    ),
                  ),
                  color: Colors.white,
                )),
                Container(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 22.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Material(
                          borderRadius: BorderRadius.circular(20.0),
                          elevation: 4.0,
                          color: Theme.of(context).primaryColor,
                          child: Padding(
                            padding: EdgeInsets.all(20.0),
                            child: Icon(
                              FontAwesomeIcons.heart,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        Expanded(
                          child: Material(
                            borderRadius: BorderRadius.circular(20.0),
                            elevation: 4.0,
                            color: Theme.of(context).primaryColor,
                            child: Padding(
                                padding: EdgeInsets.all(20.0),
                                child: Text(
                                  'Adoption',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18.0,
                                  ),
                                  textAlign: TextAlign.center,
                                )),
                          ),
                        )
                      ],
                    ),
                  ),
                  height: 100,
                  decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor.withOpacity(0.06),
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(30.0),
                      topLeft: Radius.circular(30.0),
                    ),
                  ),
                )
              ],
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 22.0),
              child: Material(
                borderRadius: BorderRadius.circular(20.0),
                elevation: 6.0,
                child: Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 20.0,
                    vertical: 20.0,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        mainAxisSize: MainAxisSize.max,
                        children: <Widget>[
                          Text(
                            animal.name,
                            style: TextStyle(
                              fontSize: 26.0,
                              color: Theme.of(context).primaryColor,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Icon(animal.isFemale
                              ? FontAwesomeIcons.venus
                              : FontAwesomeIcons.mars),
                        ],
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            animal.scientificName,
                            style: TextStyle(
                              fontSize: 16.0,
                              color: Theme.of(context).primaryColor,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Text(
                            '${animal.age} years old',
                            style: TextStyle(
                              fontSize: 26.0,
                              color: Colors.grey,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      Row(
                        children: <Widget>[
                          Icon(
                            FontAwesomeIcons.mapMarkerAlt,
                            color: Theme.of(context).primaryColor,
                            size: 14.0,
                          ),
                          SizedBox(
                            width: 6.0,
                          ),
                          Text(
                            'Address',
                            style: TextStyle(
                              fontSize: 16.0,
                              color: Theme.of(context).primaryColor,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  height: 140.0,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
