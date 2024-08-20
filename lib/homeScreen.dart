import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';

import 'model/asteroid_models.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  double shipX = 0.0, shipY = 0.0; //responsible for moving the ship
  double maxHeight = 0.0; // to attain a maximum height
  double initialPosition = 0.0; // to store the initial position
  double time = 0.0; // to store the value of time
  double velocity = 2.9; // the speed of the game
  double gravity = -4.9; // value of gravity is 9.8, so we divide it by 2 (Newton's Law)
  bool isGameRunning = false;

  List <AsteroidData> asteroidData =[

  ];

  List<AsteroidData> setAsteroidData () {
    List <AsteroidData> data = [
      AsteroidData(
          size: Size(40, 60),
          alignment: Alignment(2,0.7)
      ),
      AsteroidData(
          size: Size(80, 100),
          alignment: Alignment(1.5, -0.5)
      ),
      AsteroidData(
          size: Size(40, 50),
          alignment: Alignment(3,-0.2)
      ),
      AsteroidData(
          size: Size(70, 60),
          alignment: Alignment(2.2,0.2)
      ),
    ];
    return data;
  }


  void startGame(){
    isGameRunning = true;
      Timer.periodic(Duration(milliseconds: 30),(timer){

        time = time + 0.02;

          setState(() {
            maxHeight = velocity * time + gravity * time * time;

            shipY = initialPosition - maxHeight;
          });
          moveAsteroid();
        }
      );
  }

  void onJump(){
    setState(() {
      time = 0;
      initialPosition = shipY;
    });
  }

  @override
  void initState(){
    super.initState();
    asteroidData = setAsteroidData();
  }

  double generateRandomNumber(){
    Random rand = Random();

    double randomDouble = rand.nextDouble() * (-1.0 - 1.0) + 1.0;
    return randomDouble;
  }

  void moveAsteroid(){
    Alignment asteroid1 = asteroidData[0].alignment;
    Alignment asteroid2 = asteroidData[1].alignment;
    Alignment asteroid3 = asteroidData[2].alignment;
    Alignment asteroid4 = asteroidData[3].alignment;

    if(asteroid1.x > -1.4){
      asteroidData[0].alignment = Alignment(asteroid1.x -0.02, asteroid1.y);
    }else{
     asteroidData[0].alignment = Alignment(2, generateRandomNumber());
    }
    if(asteroid2.x > -1.4){
      asteroidData[1].alignment = Alignment(asteroid2.x -0.02, asteroid2.y);
    }else{
      asteroidData[1].alignment = Alignment(1.5, generateRandomNumber());
    }
    if(asteroid3.x > -1.4){
      asteroidData[2].alignment = Alignment(asteroid3.x -0.02, asteroid3.y);
    }else{
      asteroidData[2].alignment = Alignment(3, generateRandomNumber());
    }
    if(asteroid4.x > -1.4){
      asteroidData[3].alignment = Alignment(asteroid4.x -0.02, asteroid4.y);
    }else{
      asteroidData[3].alignment = Alignment(2.2, generateRandomNumber());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
          body:GestureDetector(
            onTap: isGameRunning ? onJump : startGame,
            child: Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage(
                        "assets/image/bg.jpg"
                    ),
                  fit: BoxFit.cover,
                ),
              ),
              child: Stack(
                children: [
                  Align(
                    alignment: Alignment(shipX,shipY),
                    child: Container(
                      height: 60,
                      width: 840,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                         image: AssetImage(
                          "assets/image/ship.png"
                          ),
                        ),
                      ),
                    ),
                  ),
                  Align(
                    alignment: asteroidData[0].alignment,
                    child: Container(
                      width: asteroidData[0].size.height,
                      height: asteroidData[0].size.height,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage(asteroidData[0].path)
                        ),
                      ),
                    ),
                  ),
                  Align(
                    alignment: asteroidData[1].alignment,
                    child: Container(
                      width: asteroidData[1].size.height,
                      height: asteroidData[1].size.height,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage(asteroidData[0].path)
                        ),
                      ),
                    ),
                  ),
                  Align(
                    alignment: asteroidData[2].alignment,
                    child: Container(
                      width: asteroidData[2].size.height,
                      height: asteroidData[2].size.height,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage(asteroidData[0].path)
                        ),
                      ),
                    ),
                  ),
                  Align(
                    alignment: asteroidData[3].alignment,
                    child: Container(
                      width: asteroidData[3].size.height,
                      height: asteroidData[3].size.height,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage(asteroidData[0].path)
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
    );
  }
}
