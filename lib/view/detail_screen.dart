import 'package:covid_app/view/countries_list.dart';
import 'package:covid_app/view/world_state.dart';
import 'package:flutter/material.dart';

class DetailScreen extends StatefulWidget {
  String name;
    String image;
  int totalcases, totaldeaths,totalrecovered,active,critical,todayrecovered,test;
   DetailScreen({super.key,
  required this.name,
   required this.image,
  required this.totalcases,
  required this.todayrecovered,
  required this.totaldeaths,
  required this.active,
  required this.critical,
  required this.test,
  required this.totalrecovered,
  });

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black38,
      appBar: AppBar(
         leading: IconButton(onPressed: (){
          Navigator.push(context, MaterialPageRoute(builder: (context)=> const CountryListData()));
        }
        , icon: const Icon(Icons.arrow_back_outlined,color: Colors.white,size: 25,) ),
        backgroundColor: Colors.black38,
        title: Text(widget.name),
        titleTextStyle: const TextStyle(color: Colors.white,fontSize: 25),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Stack(
                    alignment: Alignment.topCenter,
                    children: [
                      Padding(
                        padding:  EdgeInsets.only(top: MediaQuery.of(context).size.height*.068),
                        child: Center(
                          child: Card(
                            
                            
                            
                              child: Column(
                                children: [
                                  SizedBox(height: MediaQuery.of(context).size.height*.06,),
                                  const  Center(child: Text("Total Record")),
                                 ReuseableRow(title: 'Cases', vlaue: widget.totalcases.toString()),
                                  ReuseableRow(title: 'Recovered', vlaue: widget.totalrecovered.toString()),
                                  ReuseableRow(title: 'Death', vlaue: widget.totaldeaths.toString()),
                                  ReuseableRow(title: 'Critical', vlaue: widget.critical.toString()),
                                  ReuseableRow(title: 'Today Recovered', vlaue: widget.todayrecovered.toString()),
                                  
                                  
                                ],
                              ),
                            
                          ),
                        ),
                      ),
                      CircleAvatar(
                        radius: 50,
                        backgroundImage: NetworkImage(widget.image),
                      )
                
                    ],
                  ),
                
              ],
            ),
          ),
        ),
      ),
    );
  }
}