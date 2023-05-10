//import 'package:covid_tracker/View/world_States.dart';
import 'package:covid_19_tracker/View/world_States.dart';
import 'package:flutter/material.dart';

class DetailScreen extends StatefulWidget {
  String name;
  String image;
  int population;
  int tests, active, todayCases, deaths, todayRecovered, critical;
  String continent;
   DetailScreen({
     required this.name,            required this.image,
     required this.population,
     required this.tests,           required this.active,
     required this.todayCases,      required this.deaths,
     required this.todayRecovered,  required this.critical,
     required this.continent,
   });

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text(widget.name),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Stack(
              alignment: Alignment.topCenter,
              children: [
                Padding(
                  padding:  EdgeInsets.only(top: MediaQuery.of(context).size.height * .070),
                  child: Card(
                   child: Padding(
                     padding: const EdgeInsets.symmetric(horizontal: 10),
                     child: Column(
                       children:[
                         SizedBox(height: MediaQuery.of(context).size.height * .06,),
                         ReuseableRow(title: 'Name', value: widget.name.toString()),
                         ReuseableRow(title: 'Continent', value: widget.continent.toString()),
                         ReuseableRow(title: 'Population', value: widget.population.toString()),
                         ReuseableRow(title: 'Active', value: widget.active.toString()),
                         ReuseableRow(title: 'Tests', value: widget.tests.toString()),
                         ReuseableRow(title: 'Deaths', value: widget.deaths.toString()),
                         ReuseableRow(title: 'Critical', value: widget.critical.toString()),
                         ReuseableRow(title: 'Total Cases', value: widget.todayCases.toString()),
                         ReuseableRow(title: 'Total Recovered', value: widget.todayRecovered.toString()),
                     ]),
                   ),
                  ),
                ),
                CircleAvatar(
                  radius: 70,
                  backgroundImage: NetworkImage(widget.image),
                )

              ],
            )
          ],
        ),
      ),
    );
  }
}
