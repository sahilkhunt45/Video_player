import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../global.dart';
import '../models/model.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<nVideos> allVideos = [];

  lodeJsonBank() async {
    String jsonData = await rootBundle.loadString("assets/json/nature.json");

    List res = jsonDecode(jsonData);

    setState(() {
      allVideos = res.map((e) => nVideos.fromJSON(e)).toList();
    });
  }

  @override
  void initState() {
    super.initState();
    lodeJsonBank();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.amber.withOpacity(0.2),
      appBar: AppBar(
        leading: Icon(Icons.ac_unit),
        elevation: 10,
        title: const Text("Nature"),
        centerTitle: true,
        backgroundColor: Colors.orangeAccent,
      ),
      body: Container(
        margin: const EdgeInsets.symmetric(horizontal: 15),
        child: ListView.builder(
          physics: const BouncingScrollPhysics(),
          itemCount: allVideos.length,
          itemBuilder: (context, i) => Container(
            margin: const EdgeInsets.only(top: 15, bottom: 15),
            child: InkWell(
              borderRadius: BorderRadius.circular(38),
              onTap: () {
                setState(() {
                  Global.data = allVideos[i];
                  Navigator.of(context)
                      .pushNamed("video page", arguments: allVideos[i]);
                });
              },
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Stack(
                      alignment: Alignment.topCenter,
                      children: [
                        Container(
                          height: 500,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            borderRadius: const BorderRadius.only(
                              topRight: Radius.circular(38),
                              topLeft: Radius.circular(38),
                              bottomLeft: Radius.circular(38),
                              bottomRight: Radius.circular(38),
                            ),
                            image: DecorationImage(
                              image: AssetImage(allVideos[i].images),
                              fit: BoxFit.cover,
                              filterQuality: FilterQuality.high,
                            ),
                          ),
                        ),
                        Text(
                          allVideos[i].type,
                          style: TextStyle(
                            fontSize: 40,
                            fontStyle: FontStyle.italic,
                            textBaseline: TextBaseline.alphabetic,
                            fontWeight: FontWeight.bold,
                            color: Colors.black.withOpacity(0.6),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
