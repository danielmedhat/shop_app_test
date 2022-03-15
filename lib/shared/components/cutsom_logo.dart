import 'package:flutter/material.dart';

class CustomLogo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top:  MediaQuery.of(context).size.height * .01,),
      child: Container(
        height: MediaQuery.of(context).size.height * .25,
        child: 
            Image(
              image: AssetImage('images/shop1.png',),
            ),
           
        
      ),
    );
  }
}
