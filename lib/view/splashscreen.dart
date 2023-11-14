import 'dart:async';

import 'package:covid_app/Services/state_services.dart';
import 'package:covid_app/view/world_state.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;

class SplasScreen extends StatefulWidget {
  const SplasScreen({super.key});

  @override
  State<SplasScreen> createState() => _SplasScreenState();
}

class _SplasScreenState extends State<SplasScreen>
    with TickerProviderStateMixin {
  late final AnimationController _controller =
      AnimationController(duration: const Duration(seconds: 3), vsync: this)
        ..repeat();
    @override
    void dispose() {
    // TODO: implement dispose
    
    _controller.dispose();
  }
  void initState() {
    // TODO: implement initState
    
    Timer( const Duration(seconds: 5),
    ()=> Navigator.push(context, MaterialPageRoute(builder: (context)=> const WorldScreen())));
  }
  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      backgroundColor: Colors.black38,
      body:  Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            AnimatedBuilder(
                animation: _controller,
                child:  Center(
                  
                    child: Container(
                      height: MediaQuery.of(context).size.height*.2,
                      width: MediaQuery.of(context).size.width*.5,
                      
                      
                      child: const Center(
                        child: Image(image: AssetImage('images/virus1.png')),
                      ),
                    ),
                  
                ),
                builder: (BuildContext context, Widget? child) {
                  return Transform.rotate(
                    angle: _controller.value * 2.0 * math.pi,
                    child: child,
                  );
                }),
               SizedBox(height: MediaQuery.of(context).size.height*.08),
             
               const Text("Covid-19 \n Tracker App",textAlign: TextAlign.center,style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 25,
                  color: Colors.red
                ),),
             
          ],
        ),
      
    );
  }
}
