import 'package:flutter/material.dart';
import 'package:flutter_fortune_wheel/flutter_fortune_wheel.dart';
import 'package:rxdart/subjects.dart';

class WheelPage extends StatefulWidget {
  const WheelPage({super.key});

  @override
  State<WheelPage> createState() => _WheelPageState();
}

class _WheelPageState extends State<WheelPage> {
  List<String> wheeldata = [
    'tea',
    'coffee',
    'butter ',
    'Malar ',
    'bear',
    'bubble tea',
    'chocolate cake',
    'salad',
  ];
  final firstdata = TextEditingController();
  String first = '';
  final selected = BehaviorSubject<int>();
  String rewards = '0';
  @override
  void dispose() {
    selected.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.purple.shade100,
          title: const Center(
            child: Text('Let play this game'),
          ),
        ),
        body: Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 300,
              child: FortuneWheel(
                duration: const Duration(milliseconds: 2000),
                indicators: <FortuneIndicator>[
                  FortuneIndicator(
                    alignment: Alignment
                        .topCenter, // <-- changing the position of the indicator
                    child: TriangleIndicator(
                      color: Colors.deepPurpleAccent
                          .shade700, // <-- changing the color of the indicator
                    ),
                  ),
                ],
                physics: CircularPanPhysics(
                  curve: Curves.decelerate,
                ),
                onAnimationStart: () {
                  print('animation start');
                },
                onAnimationEnd: () {
                  setState(() {
                    rewards = wheeldata[selected.value];
                    showDialog(
                      context: context,
                      builder: (ctx) => AlertDialog(
                        icon: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: const Image(
                            image: AssetImage('assets/success.png'),
                            height: 100,
                          ),
                        ),
                        content: Text('Your Choice is $rewards',
                            style: const TextStyle(
                                fontSize: 18, fontWeight: FontWeight.w500)),
                        actions: <Widget>[
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                  color: Colors.purple.shade300,
                                  borderRadius: BorderRadius.circular(10)),
                              padding: const EdgeInsets.all(14),
                              child: const Text("OK",
                                  style: TextStyle(color: Colors.white)),
                            ),
                          ),
                        ],
                      ),
                    );
                  });
                },
                animateFirst: false,
                selected: selected.stream,
                items: [
                  for (int i = 0; i < wheeldata.length; i++) ...<FortuneItem>{
                    FortuneItem(child: Text(wheeldata[i]))
                  },
                ],
              ),
            ),
            const SizedBox(height: 40),
            GestureDetector(
                onTap: () {
                  setState(() {
                    selected.add(Fortune.randomInt(0, wheeldata.length));
                  });
                },
                child: Container(
                    width: 100,
                    height: 50,
                    decoration: BoxDecoration(
                        color: Colors.deepPurple,
                        borderRadius: BorderRadius.circular(10)),
                    child: const Center(
                        child: Text('Spain',
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.white,
                            ))))),
          ],
        )));
  }
}
