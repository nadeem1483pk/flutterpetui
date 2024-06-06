import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Product {
  final String id;
  final String title;
  final String age;
  final String scientific_name;
  final String distance_to_user;
  final String gender;
  final String category;
  final String image;

  Product({
    required this.id,
    required this.title,
    required this.age,
    required this.scientific_name,
    required this.distance_to_user,
    required this.gender,
    required this.category,
    required this.image,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      title: json['title'],
      age: json['age'],
      scientific_name: json['scientific_name'],
      distance_to_user: json['distance_to_user'],
      gender: json['gender'],
      category: json['category'],
      image: json['image'],
    );
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['name'] = title;
    _data['age'] = age;
    _data['scientific_name'] = scientific_name;
    _data['distance_to_user'] = distance_to_user;
    _data['gender'] = gender;
    _data['category'] = category;
    _data['image'] = image;
    return _data;
  }
}

class Category {
  final String id;
  final String name;
  final String icon;

  Category({
    required this.id,
    required this.name,
    required this.icon,
  });

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      id: json['id'],
      name: json['name'],
      icon: json['icon'],
    );
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['name'] = name;
    _data['icon'] = icon;
    return _data;
  }
}

class Animalnew {
  final String id;
  final String name;
  final IconData icon;

  Animalnew({required this.id, required this.name, required this.icon});

  factory Animalnew.fromJson(Map<String, dynamic> json) {
    return Animalnew(
      id: json['id'],
      name: json['name'],
      icon: _getIconData(json['icon']), // Handle icon mapping separately
    );
  }

  static IconData _getIconData(String iconName) {
    switch (iconName) {
      case 'cat':
        return FontAwesomeIcons.cat;
      case 'dog':
        return FontAwesomeIcons.dog;
      case 'parrot':
        return FontAwesomeIcons.crow; // Assuming this for parrots
      case 'fish':
        return FontAwesomeIcons.fish;
      default:
        return FontAwesomeIcons.question; // Default icon
    }
  }
}
