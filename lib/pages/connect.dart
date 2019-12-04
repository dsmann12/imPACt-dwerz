import 'package:flutter/material.dart';
import 'package:impact/card_animation/card_index.dart';

class Recommendations extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: DisplayRecommendations()),
    );
  }
}

class DisplayRecommendations extends StatefulWidget
{
  @override
  State<StatefulWidget> createState() => _DisplayRecommendationsState();
}

class _DisplayRecommendationsState extends State<DisplayRecommendations>
{

  @override
  Widget build(BuildContext context) {
    return CardDemo();
  }
}
