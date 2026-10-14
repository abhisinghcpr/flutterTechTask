import 'package:flutter/material.dart';

class WebTemplateModel {
  const WebTemplateModel({
    required this.name,
    required this.role,
    required this.tagline,
    required this.color,
    required this.imageUrl,
  });

  final String name;
  final String role;
  final String tagline;
  final Color color;
  final String imageUrl;
}
