import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'main.dart';
class MenuScreen extends StatefulWidget {
  @override
  _MenuScreenState  createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
   int selectedMenuIndex = 0;

  List<String> menuItems = [
    'Adoption',
    'Donation',
    'Add Pet',
    'Favorites',
    'Messages',
    'Profiles'
  ];
  List<IconData> icons = [
    FontAwesomeIcons.paw,
    FontAwesomeIcons.home,
    FontAwesomeIcons.plus,
    FontAwesomeIcons.heart,
    FontAwesomeIcons.envelope,
    FontAwesomeIcons.userAlt,
  ];
  Widget buildMenuRow(int index){
    return InkWell(onTap: (){
      setState(() {
        selectedMenuIndex = index;
      });
    },
      child: Padding(
          padding: EdgeInsets.symmetric(vertical: 20.0),
          child: Row(
            children: <Widget> [
              Icon(
                icons[index],
                color: selectedMenuIndex == index
                    ? Colors.white
                    : Colors.white.withOpacity(0.5),
              ),
              SizedBox(
                width: 10.0,
              ),
              Text(
                menuItems[index],
                style: TextStyle(
                  color: selectedMenuIndex == index
                      ? Colors.white
                      : Colors.white.withOpacity(0.5),
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
    );
  }
  @override
  Widget build(BuildContext context) {
    return Material(
      child:Container(
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 30.0,
              horizontal: 15.0,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Row(children: <Widget>[
                  CircleAvatar(
                    radius: 24.0,
                    backgroundColor: Colors.orange,
                  ),
                  SizedBox(width: 16.0,
                  ),
                  Column(crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget> [
                      Text(
                        'PetPal',
                        style: TextStyle(
                            color: Colors.white,
                          fontWeight: FontWeight.w500,
                          fontSize: 22.0,
                        ),
                      ),
                      Text(
                        'Everything is here',
                        style: TextStyle(color: Colors.white.withOpacity(0.5)),
                      ),
                    ],
                  ),
                ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: menuItems
                      .asMap()
                      .entries
                      .map((mapEntry) => buildMenuRow(mapEntry.key))
                      .toList(),
                ),
                Row(
                  children: <Widget> [
                    Icon(
                      FontAwesomeIcons.cog,
                      color: Colors.white.withOpacity(0.5),
                    ),
                    SizedBox(
                      width: 10.0,
                    ),
                    Text(
                      'Settings   |    Logout',
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.5),
                        fontSize: 20.0,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [startingColor, mainColor])),

      ),
    );
  }
}
