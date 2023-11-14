import 'package:covid_app/Services/state_services.dart';
import 'package:covid_app/view/detail_screen.dart';
import 'package:covid_app/view/world_state.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class CountryListData extends StatefulWidget {
  const CountryListData({super.key});

  @override
  State<CountryListData> createState() => _CountryListDataState();
}

class _CountryListDataState extends State<CountryListData> {
  TextEditingController Searcheditcontroller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    stateServices stateservices = stateServices();
    return  Scaffold(
      
      backgroundColor: Colors.black38,
      appBar: AppBar(
        leading: IconButton(onPressed: (){
          Navigator.push(context, MaterialPageRoute(builder: (context)=> const WorldScreen()));
        }
        , icon: const Icon(Icons.arrow_back_outlined,color: Colors.white,size: 25,) ),
      
        title: const Text("Countries",style: TextStyle(color: Colors.white,fontSize: 25),) ,
        centerTitle: true,
      elevation: 0,
      backgroundColor: Colors.black38
      
      ),
      body: SafeArea(
      
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: TextFormField(
                  style: const TextStyle(color: Colors.white),
                  controller: Searcheditcontroller,
                  onChanged: (value){
                    setState(() {
                      
                    });
                  },
                  decoration: InputDecoration(
                    hintText: 'Search Country',
                    hintStyle: const TextStyle(color: Colors.white),
                    fillColor: Colors.grey.withOpacity(0.4),
                    filled: true,
                     suffixIcon: const Icon(Icons.flag,color: Colors.white,size: 25,),
                     enabledBorder: UnderlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      
                     ),
                      focusedBorder: UnderlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      
                     ),
                  ),
                ),
              ),
              Expanded(
                child: FutureBuilder(
                    future: stateservices.CountriesStateApi(),
                  builder:(context,AsyncSnapshot<List<dynamic>>snapshot){
                    if(!snapshot.hasData){
                       return  ListView.builder(
                        itemCount: 10,
                      itemBuilder: (context,index){
                        
                      
                      return Shimmer.fromColors(
                         baseColor: Colors.grey.shade700,
                         highlightColor: Colors.grey.shade100,
                         child: Column(
                          children: [
                            ListTile(
                              
                              title: Container(height: 10,width: 89,color: Colors.grey,),
                              subtitle: Container(height: 10,width: 89,color: Colors.grey,),
                              
                              leading:Container(height: 20,width: 89,color: Colors.grey)
                              )
                            
                          ],
                        )
                        );
                        });
                       
                    }
                    else{
                      return ListView.builder(
                        itemCount: snapshot.data!.length,
                      itemBuilder: (context,index){
                        String name =  snapshot.data![index]['country'];
                        if(Searcheditcontroller.text.isEmpty){
                                    return Column(
                          children: [
                            InkWell(
                               onTap: (){
                                
                               Navigator.push(context, MaterialPageRoute(builder: (context)=>  DetailScreen(
                                    name: snapshot.data![index]['country'],
                                    image: snapshot.data![index]['countryInfo']['flag'],
                                   totalcases: snapshot.data![index]['cases'],
                                   todayrecovered: snapshot.data![index]['todayRecovered'],
                                   totaldeaths: snapshot.data![index]['deaths'],
                                   active: snapshot.data![index]['active'],
                                   critical: snapshot.data![index]['critical'],
                                   test: snapshot.data![index]['tests'],
                                   totalrecovered: snapshot.data![index]['recovered'],
                                   



                                 )));
                              },
                              child: ListTile(
                                titleTextStyle: const TextStyle(color: Colors.white,fontSize: 15),
                                title: Text(snapshot.data![index]['country']),
                                subtitle: Text(snapshot.data![index]['cases'].toString()), 
                                subtitleTextStyle: const TextStyle(color: Colors.red,fontSize: 15),
                                leading: Image(
                                  height: 50,
                                  width: 50,
                                  image: NetworkImage(snapshot.data![index]['countryInfo']['flag'])
                                )
                              ),
                            )
                          ],
                        );
                        }
                        else if(name.toLowerCase().contains(Searcheditcontroller.text.toLowerCase())){
                           return Column(
                          children: [
                            InkWell(
                              onTap: (){
                                
                                 Navigator.push(context, MaterialPageRoute(builder: (context)=>  DetailScreen(
                                    name: snapshot.data![index]['country'],
                                    image: snapshot.data![index]['countryInfo']['flag'],
                                   totalcases: snapshot.data![index]['cases'],
                                   todayrecovered: snapshot.data![index]['todayRecovered'],
                                   totaldeaths: snapshot.data![index]['deaths'],
                                   active: snapshot.data![index]['active'],
                                   critical: snapshot.data![index]['critical'],
                                   test: snapshot.data![index]['tests'],
                                   totalrecovered: snapshot.data![index]['recovered'],
                                   



                                 )));
                              },
                              child: ListTile(
                                titleTextStyle: const TextStyle(color: Colors.white,fontSize: 15),
                                title: Text(snapshot.data![index]['country']),
                                subtitle: Text(snapshot.data![index]['cases'].toString()), 
                                subtitleTextStyle: const TextStyle(color: Colors.red,fontSize: 15),
                                leading: Image(
                                  height: 50,
                                  width: 50,
                                  image: NetworkImage(snapshot.data![index]['countryInfo']['flag'])
                                )
                              ),
                            )
                          ],
                        );

                        } else{
                                Container();
                        }
                        
                        
                      });

                    }
                    
                  }))
            ],
          ),
        )),
    );
  }
}