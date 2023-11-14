import 'package:covid_app/Model/world_modal_state.dart';
import 'package:covid_app/Services/state_services.dart';
import 'package:covid_app/view/countries_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:pie_chart/pie_chart.dart';

class WorldScreen extends StatefulWidget {
  const WorldScreen({super.key});

  @override
  State<WorldScreen> createState() => _WorldScreenState();
}

class _WorldScreenState extends State<WorldScreen>
    with TickerProviderStateMixin {
  late final AnimationController _controller =
      AnimationController(duration: const Duration(seconds: 15), vsync: this)
        ..repeat();
  @override
  void dispose() {
    // TODO: implement dispose

    _controller.dispose();
  }

  final _ColorList = <Color>[
    const Color(0xfff4285F4),
    const Color(0xfff1aa260),
    const Color(0xfffde5246)
  ];
  @override
  Widget build(BuildContext context) {
    stateServices stateservices = stateServices();
    return Scaffold(
      backgroundColor: Colors.black38,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.black38,
        title: const Text('World State',style: TextStyle(color: Colors.white,fontSize: 25)),
        centerTitle: true,
      ),
      
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.01,),
                FutureBuilder(
                  future: stateservices.WorldStateRecord(),
                  builder:(context, AsyncSnapshot<covid_Modal>snapshot){
                     if(!snapshot.hasData){
                      return Expanded(
                          flex: 1,
                        child: SpinKitFadingCircle(
                          color: Colors.white,
                          size: 50,
                          controller: _controller,
                        )
                        
                        );
        
                     }else{
        
                      return Column(
                        children: [
                           PieChart(
                  dataMap:  {
                    "Total": double.parse(snapshot.data!.cases!.toString()),
                    "Recorvered": double.parse(snapshot.data!.recovered.toString()),
                    "Deaths": double.parse(snapshot.data!.deaths.toString()),
                  },
                  chartValuesOptions: const ChartValuesOptions(
                    showChartValuesInPercentage: true
                  ),
                  animationDuration: const Duration(milliseconds: 1200),
                  chartType: ChartType.ring,
                  colorList: _ColorList,
                  chartRadius: MediaQuery.of(context).size.width / 3,
                  legendOptions: const LegendOptions(
                    legendPosition: LegendPosition.left,
                    legendTextStyle: TextStyle(
                      color: Colors.white,
                    ),
                  )),
              Padding(
                padding: EdgeInsets.symmetric(
                    vertical: MediaQuery.of(context).size.height * 0.03),
                child:  Card(
                  child: Column(
                    children: [
                      ReuseableRow(title: 'Countries', vlaue: snapshot.data!.affectedCountries.toString()),
                      ReuseableRow(title: 'Total_Cases', vlaue: snapshot.data!.cases.toString()),
                      ReuseableRow(title: 'Today_Case', vlaue: snapshot.data!.todayCases.toString()),
                      ReuseableRow(title: 'Active', vlaue: snapshot.data!.active.toString()),
                      ReuseableRow(title: 'Critical', vlaue: snapshot.data!.critical.toString()),
                      ReuseableRow(title: 'Total_deaths', vlaue: snapshot.data!.deaths.toString()),
                      ReuseableRow(title: 'Today_Deaths', vlaue: snapshot.data!.todayDeaths.toString()),
                      ReuseableRow(title: 'Today_Recovered', vlaue: snapshot.data!.todayRecovered.toString()),
                     
                    ],
                  ),
                ),
              ),
              GestureDetector(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: ((context) => const CountryListData())));
                },
                child: Container(
                  height: MediaQuery.of(context).size.height * .07,
                  decoration: BoxDecoration(
                    color: const Color(0xff1aa260),
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color: Colors.white,
                      width: 1,
                    )
                  ),
                  child: const Center(
                    child: Text(
                      "Pick Country",
                      style: TextStyle(
                          fontWeight: FontWeight.normal, color: Colors.white),
                    ),
                  ),
                ),
              ),
                        ],
        
                      );
        
                     }
                  } ),
             
            ],
          ),
        ),
      )),
    );
  }
}

class ReuseableRow extends StatelessWidget {
  final String title, vlaue;
  const ReuseableRow({super.key, required this.title, required this.vlaue});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10, bottom: 5, top: 10),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(title),
              Text(vlaue),
            ],
          ),
          const SizedBox(
            height: 5,
          ),
          const Divider(),
        ],
      ),
    );
  }
}
