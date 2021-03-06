import 'dart:convert';

import 'package:Flutter/PokeManDetails.dart';
import 'package:Flutter/pokeman.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Poke Man App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.cyan,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String url =
      "https://raw.githubusercontent.com/Biuni/PokemonGO-Pokedex/master/pokedex.json";

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  PokeHub pokehub;

  fetchData() async {
    var res = await http.get(url);
    var decodedJson = jsonDecode(res.body);
    pokehub = PokeHub.fromJson(decodedJson);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Poke App"),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            pokehub = null;
            fetchData();
          });
        },
        child: Icon(Icons.refresh),
      ),
      body: (pokehub != null)
          ? GridView.count(
              crossAxisCount: 2,
              children: pokehub.pokemon
                  .map((poke) => Padding(
                        padding: const EdgeInsets.all(2.0),
                        child: InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => PokeDetail( pokemon: poke,)));
                          },
                          child: Hero(
                            tag: poke.img,
                            child: Card(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  Container(
                                    height: 100,
                                    width: 100,child: CachedNetworkImage(
                                imageUrl: poke.img,
                                placeholder: (context, url) => new CircularProgressIndicator(),
                                errorWidget: (context, url, error) => new Icon(Icons.error),
                              ),

                                  ),
                                  Text(
                                    poke.name,
                                    style: TextStyle(
                                        fontSize: 20.0,
                                        fontWeight: FontWeight.bold),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      ))
                  .toList(),
            )
          : Center(child: CircularProgressIndicator()),
    );
  }
}
