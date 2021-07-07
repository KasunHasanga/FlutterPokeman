import 'package:Flutter/pokeman.dart';
import 'package:flutter/material.dart';

class PokeDetails extends StatelessWidget {
  final Pokemon pokemon;
  const PokeDetails({this.pokemon}) ;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(pokemon.name),
      ),
    );
  }
}
