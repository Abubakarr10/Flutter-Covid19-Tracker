//import 'dart:html'as http;

//import 'package:covid_tracker/Models/worldStatesModel.dart';
import 'package:covid_19_tracker/Models/worldStatesModel.dart';
//import 'package:covid_tracker/Models/worldStatesModel.dart';
//import 'package:covid_tracker/Services/states_services.dart';
//import 'package:covid_tracker/View/countries_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:pie_chart/pie_chart.dart';

import '../Services/states_services.dart';
import 'countries_list.dart';

class worldStatesScreen extends StatefulWidget {
  const worldStatesScreen({Key? key}) : super(key: key);

  @override
  State<worldStatesScreen> createState() => _worldStatesScreenState();
}

class _worldStatesScreenState extends State<worldStatesScreen> with TickerProviderStateMixin {

  late final AnimationController _controller = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this)..repeat();


  @override
  void dispose(){
    super.dispose();
    _controller.dispose();
  }
  final colorList = <Color> [
    Colors.blue,
    Colors.green,
    Colors.red,
  ];

  @override
  Widget build(BuildContext context) {
    StatesServices statesServices = StatesServices();
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            children: [
              SizedBox(height: MediaQuery.of(context).size.height * .01,),
              FutureBuilder(
                  future: statesServices.fetchWorldStatesRecords(),
                  builder: (context,AsyncSnapshot<WorldStatesModel> snapshot){
                    if(!snapshot.hasData){
                      return Expanded(
                          flex: 1,
                          child: SpinKitFadingCircle(
                            color: Colors.white,
                            size: 50,
                            controller: _controller,
                          ));
                    }
                    else{
                      return Column(
                        children: [
                          PieChart(
                            dataMap: {
                              "Total": double.parse(snapshot.data!.cases.toString()),
                              "Recovered": double.parse(snapshot.data!.recovered.toString()),
                              "Deaths": double.parse(snapshot.data!.deaths.toString()),
                            },
                            chartRadius: MediaQuery.of(context).size.width / 3.2,
                            chartValuesOptions: const ChartValuesOptions(
                              showChartValuesInPercentage: true,
                            ),
                            legendOptions: const LegendOptions(
                                legendPosition: LegendPosition.left
                            ),
                            animationDuration: const Duration(milliseconds: 1800),
                            chartType: ChartType.ring,
                            colorList: colorList,
                          ),
                          const SizedBox(height: 8,),
                          Padding(
                            padding:  EdgeInsets.symmetric(vertical: MediaQuery.of(context).size.height * .06),
                            child: Card(
                              child: Column(
                                children: [
                                  ReuseableRow(title: 'Total', value: snapshot.data!.cases.toString()),
                                  ReuseableRow(title: 'Recovered', value: snapshot.data!.recovered.toString()),
                                  ReuseableRow(title: 'Deaths', value: snapshot.data!.deaths.toString()),
                                  ReuseableRow(title: 'Active', value: snapshot.data!.active.toString()),
                                  ReuseableRow(title: 'Tests', value: snapshot.data!.tests.toString()),
                                  ReuseableRow(title: 'Critical', value: snapshot.data!.critical.toString()),
                                  ReuseableRow(title: 'Affected Countries', value: snapshot.data!.affectedCountries.toString()),
                                  ReuseableRow(title: 'Population', value: snapshot.data!.population.toString()),
                                  ReuseableRow(title: 'Active Per One Million', value: snapshot.data!.activePerOneMillion.toString()),
                                  ReuseableRow(title: 'Recovered Per One Million', value: snapshot.data!.recoveredPerOneMillion.toString()),
                                ],
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap:(){
                              Navigator.push(context, MaterialPageRoute(builder: (context) => const CountriesListScreen()));
                    },
                            child: Container(
                              height: 60,
                              decoration:  BoxDecoration(
                                  color: const Color(0xff1aa260),
                                  borderRadius: BorderRadius.circular(10)
                              ),
                              child:const Center(
                                child: Text('Track Countries',style: TextStyle(fontSize: 20,fontWeight: FontWeight.normal),),
                              ),
                            ),
                          )
                        ],
                      );
                    }
              }),
            ],
          ),
        ),
      ),
    );
  }
}

class ReuseableRow extends StatelessWidget {
  String title,value;
   ReuseableRow({Key? key, required this.title,required this.value }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10,right: 10,top: 10,bottom: 5),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(title,style: TextStyle(fontSize: 18),),
              Text(value,style: TextStyle(fontSize: 18),),
            ],
          ),
          SizedBox(height: 5,),
          Divider()
        ],
      ),
    );
  }
}
