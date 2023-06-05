import 'dart:async';
import 'package:flappy_bird/Barrier.dart';
import 'package:flappy_bird/Bird.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  static double birdY = 0;
  late BuildContext context;
  double time =0;
  double height =0;
  double initialHeight=birdY;
  bool gameHasStarted=false;
  static double barriTwo=1;
  double barriOne= barriTwo +1.5;

  void startGame() {
    gameHasStarted=true;
    Timer.periodic(const Duration(milliseconds: 60), (timer) {
      time+=0.05;
      height=-4.9*time*time+2.8*time;
      setState(() {
        birdY =initialHeight-height;
        barriOne-=0.05;
        barriTwo-=0.05;
      });
      setState(() {
        if(barriOne<-2)
        {
          barriOne+=3.5;
        }
        else
        {
          barriOne-=0.05;
        }
      });
      setState(() {
        if(barriTwo<-2)
        {
          barriTwo+=3.5;
        }
        else
        {
          barriTwo-=0.05;
        }
      });
      if(birdY >1)
        {
          timer.cancel();
          gameHasStarted=false;
        }
      if(BirdDie())
      {
        timer.cancel();
        gameHasStarted=false;
        restartGame();
      }
    });


  }
  void jump()
  {
    setState(() {
      time=0;
      initialHeight=birdY;

    });
  }
  bool BirdDie()
  {
    if(birdY<-1 || birdY >1)
      {
        return true;
      }
    return false ;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: gameHasStarted ? jump :startGame,
      child: Scaffold(
          body: Column(
            children: [
              Expanded(
                  flex: 2,
                  child: Stack(
                    children: [
                      AnimatedContainer(
                          alignment: Alignment(0, birdY),
                          color: Colors.blue,
                          duration: const Duration(milliseconds: 0),
                          child: const Bird()
                      ),
                      Container(
                        alignment: const Alignment(0,-0.3),
                        child: Text(gameHasStarted ? '': 'TAP  TO  PLAY',style: const TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.white),),
                      ),
                      AnimatedContainer(
                        alignment: Alignment(barriOne,1.1),
                        duration: const Duration(milliseconds: 0),
                      child: Barrier(
                        size: 200,
                      ),
                      ),
                      AnimatedContainer(
                        alignment: Alignment(barriOne,-1.1),
                        duration: const Duration(milliseconds: 0),
                        child: Barrier(
                          size: 200,
                        ),
                      ),
                      AnimatedContainer(
                        alignment: Alignment(barriTwo,1.1),
                        duration: const Duration(milliseconds: 0),
                        child: Barrier(
                          size: 140,
                        ),),
                      AnimatedContainer(
                        alignment: Alignment(barriTwo,-1.1),
                        duration: const Duration(milliseconds: 0),
                        child: Barrier(
                          size: 260,
                        ),)
                    ],
                  )),
              Container(height: 15,color: Colors.green,),
              Expanded(child: Container(color: Colors.brown,child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Text("Điểm",style: TextStyle(
                        color: Colors.white,
                        fontSize: 25
                      ),),
                      Text("0",style: TextStyle(
                          color: Colors.white,
                          fontSize: 25
                      )),
                    ],
                  ),
                  const SizedBox(
                    width: 30,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Text("Tốt nhất",style: TextStyle(
                          color: Colors.white,
                          fontSize: 25
                      )),
                      Text("0",style: TextStyle(
                          color: Colors.white,
                          fontSize: 25
                      )),
                    ],
                  )
                ],
              ),))
            ],
          )
      ),
    );
  }
  void restartGame()
  {
    setState(() {
      birdY=0;
      time=0;
      gameHasStarted=false;
      initialHeight=birdY;
    });
  }
  void _showDialog() {
    showDialog
      (context:context, builder: (BuildContext context)=>AlertDialog(
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10) ),
          side:BorderSide(
              color: Colors.orange,
              width: 1
          )
      ),
      title: Container(
        decoration: const BoxDecoration(
            border: Border(
                bottom: BorderSide(
                    color: Colors.orange,
                    width: 1
                )
            )
        ),
        alignment: Alignment.center,
        child: const Text('Game over'),
      ),
      content: Container(
        height: 50,
        alignment: Alignment.center,
        child: const Text('Core'),
      ),
      actions: [
        ElevatedButton(onPressed:(){
          Navigator.of(context).pop();
        },style:ElevatedButton.styleFrom(
            backgroundColor: Colors.orange
        ) , child: const Text('Hủy bỏ'),),
        ElevatedButton(onPressed:restartGame,style:ElevatedButton.styleFrom(
            backgroundColor: Colors.orange
        ), child: const Text('Tiếp tục '),
        ),
      ],
    )
    );
}


}

