import 'package:bank/view/bank_map_page.dart';
import 'package:bank/view/home_page.dart';
import 'package:bank/view/transations_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FooterWidget extends StatefulWidget {
  const FooterWidget({super.key});

  @override
  State<FooterWidget> createState() => _FooterWidgetState();
}

class _FooterWidgetState extends State<FooterWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15, left: 15, right: 15),
      child: Stack(
        
        clipBehavior: Clip.none, 
        children: [
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: 80,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(100)),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                 Padding(
  padding: EdgeInsets.only(right: 32),
  child: GestureDetector(
    onTap: () {
  
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => HomePage()),
        (Route<dynamic> route) => false, 
      );
    },
    child: Icon(
      CupertinoIcons.home,
      color: Colors.black,
      size: 32,
    ),
  ),


                  ),
                   Padding(
                  padding: EdgeInsets.only(left: 32),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => BankMapPage()),
                      );
                    },
                    child: Image.asset(
                      'assets/logobank.png', 
                      width: 32,
                      height: 32, 
                    ),
                  ),
                ),

                ],
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: SizedBox(
              height: 100,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => TransationsPage()));
                },
                style: ElevatedButton.styleFrom(
                  shape: const CircleBorder(),
                  padding: const EdgeInsets.all(20),
                  backgroundColor: Colors.blue, 
                  elevation: 8,
                ),
                child: const Icon(Icons.add, size: 32, color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
