//import 'package:covid_tracker/Services/states_services.dart';
//import 'package:covid_tracker/View/detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:shimmer/shimmer.dart';

import '../Services/states_services.dart';
import 'detail_screen.dart';

class CountriesListScreen extends StatefulWidget {
  const CountriesListScreen({Key? key}) : super(key: key);

  @override
  State<CountriesListScreen> createState() => _CountriesListScreenState();
}

class _CountriesListScreenState extends State<CountriesListScreen>with TickerProviderStateMixin{

  late final AnimationController _controller = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this)..repeat();
  StatesServices statesServices = StatesServices();
  TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.black,
      ),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: TextFormField(
                controller: searchController,
                onChanged: (value){
                  setState(() {

                  });
                },
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.symmetric(horizontal: 20),
                  hintText: 'Search with country name',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(50.0),
                  ),
                ),
              ),
            ),
            Expanded(
                child: FutureBuilder(
                  future: statesServices.countriesListAPI(),
                  builder: (context, AsyncSnapshot<List<dynamic>> snapshot){

                    if(!snapshot.hasData){
                      return ListView.builder(
                          itemCount: 20,
                          itemBuilder: (context, index){
                            return Shimmer.fromColors(
                                baseColor: Colors.grey.shade700,
                                highlightColor: Colors.grey.shade100,
                                child: Column(
                                  children: [
                                    ListTile(
                                      title: Container(height: 10,width: 80,color: Colors.white,),
                                      subtitle: Container(height: 10,width: 80,color: Colors.white,),
                                      leading: Container(height: 70,width: 70,color: Colors.white,),
                                    )
                                  ],
                                )
                            );
                          });
                    }
                    else{
                      return ListView.builder(
                          itemCount: snapshot.data!.length,
                          itemBuilder: (context, index){
                            String name = snapshot.data![index]['country'];

                            if(searchController.text.isEmpty){
                              return Column(
                                children: [
                                  InkWell(
                                    onTap: (){
                                      Navigator.push(context,
                                          MaterialPageRoute(builder: (context) => DetailScreen(
                                        name: snapshot.data![index]['country'],
                                            continent: snapshot.data![index]['continent'],
                                            population: snapshot.data![index]['population'],
                                        image: snapshot.data![index]['countryInfo']['flag'],
                                        tests: snapshot.data![index]['tests'],
                                        active: snapshot.data![index]['active'],
                                        todayCases: snapshot.data![index]['todayCases'],
                                            deaths: snapshot.data![index]['deaths'],
                                        todayRecovered: snapshot.data![index]['todayRecovered'],
                                        critical: snapshot.data![index]['critical'],
                                      )));
                                    },
                                    child: ListTile(
                                      title: Text(snapshot.data![index]['country']),
                                      subtitle: Text(snapshot.data![index]['cases'].toString()) ,
                                      leading: Image(
                                          height: 70,
                                          width: 70,
                                          image: NetworkImage(
                                              snapshot.data![index]['countryInfo']['flag']
                                          )),
                                    ),
                                  )
                                ],
                              );
                            }else if(name.toLowerCase().contains(searchController.text.toLowerCase())){
                              return Column(
                                children: [
                                  InkWell(
                                    onTap: (){
                                      Navigator.push(context,
                                          MaterialPageRoute(builder: (context) => DetailScreen(
                                            name: snapshot.data![index]['country'],
                                            continent: snapshot.data![index]['continent'],
                                            image: snapshot.data![index]['countryInfo']['flag'],
                                            population: snapshot.data![index]['population'],
                                            tests: snapshot.data![index]['tests'],
                                            active: snapshot.data![index]['active'],
                                            todayCases: snapshot.data![index]['todayCases'],
                                            deaths: snapshot.data![index]['deaths'],
                                            todayRecovered: snapshot.data![index]['todayRecovered'],
                                            critical: snapshot.data![index]['critical'],

                                          )));
                                    },
                                    child: ListTile(
                                      title: Text(snapshot.data![index]['country']),
                                      subtitle: Text(snapshot.data![index]['cases'].toString()) ,
                                      leading: Image(
                                          height: 70,
                                          width: 70,
                                          image: NetworkImage(
                                              snapshot.data![index]['countryInfo']['flag']
                                          )),
                                    ),
                                  )
                                ],
                              );
                            }else{
                              return Container();
                            }
                          });
                    }
                  },
                ),
            )
          ],
        ),
      ),
    );
  }
}
