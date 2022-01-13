import 'dart:math';

import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Calcula-Thor",
      theme: ThemeData(
        primarySwatch: Colors.purple,
        backgroundColor: Colors.black26
      ),
      home: CalculatorHomePage(title: "Calcula-Thor",),
    );
  }
}

class CalculatorHomePage extends StatefulWidget{
  CalculatorHomePage({Key? key,required this.title}) : super(key: key);
  final String title;

  @override
  _CalculatorHomePageState createState() => _CalculatorHomePageState();
}

class _CalculatorHomePageState extends State<CalculatorHomePage>{

  String equation = '0';
  String result = '0';
  String expression = '0';
  double equationFontSize=25;
  double resultFontSize=40;
  buttonPressed(String buttonText){
    setState(() {
      if(buttonText == "C"){
        equation="0";
        result="0";
        equationFontSize=25;
        resultFontSize=40;
      }

      else if(buttonText == "⌫"){
        equationFontSize=40;
        resultFontSize=25;
        equation=equation.substring(0, equation.length-1);
        if(equation == ""){
          equation="0";
        }
      }

      else if(buttonText == "="){
        equationFontSize=25;
        resultFontSize=40;

        expression=equation;
        expression=expression.replaceAll('×', '*');
        expression=expression.replaceAll('÷', '/');

        try{
          Parser p =new Parser();
          Expression exp =p.parse(expression);

          ContextModel cm= ContextModel();
          result= '${exp.evaluate(EvaluationType.REAL, cm)}';
        }catch(e){
          result="Error";
        }

      }

      else{
        equationFontSize=40;
        resultFontSize=25;
        if(equation == "0"){
          equation=buttonText;
        }else {
          equation = equation + buttonText;
        }
      }
    });
  }

  Widget buildButton(String buttonText, double buttonHeight, Color buttonColor){
    return Container(
      height: MediaQuery.of(context).size.height * 0.1 * buttonHeight,
      color: buttonColor,
      child: FlatButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
          side: BorderSide(
            color: Colors.white,
            width:2,
            style: BorderStyle.solid,
          )
        ),
        padding: EdgeInsets.all(16),
        onPressed: () => buttonPressed(buttonText),
        child: Text(
            buttonText,
        style: TextStyle(
            color:Colors.white,
            fontSize:30,
            fontFamily: 'Montserrat'
        ))
      )
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title,
            style: TextStyle(
                color: Colors.black,
                fontSize: 34,
                letterSpacing: 2,
                fontFamily: 'Montserrat'
                ),),
        centerTitle: true,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[

          Container(
            alignment: Alignment.centerRight,
            padding: EdgeInsets.fromLTRB(10, 20, 10, 0),
            color: Colors.purple[50],
            child: Text(
                  equation,
                  textScaleFactor: 2.0,
                  style: TextStyle(
                      color:Colors.deepPurple,
                      fontSize:equationFontSize,
                      fontFamily: 'Montserrat'
                )
            ),
          ),

          Container(
            alignment: Alignment.centerRight,
            padding: EdgeInsets.fromLTRB(10, 20, 10, 0),
            color: Colors.purple[50],
            child: Text(
                result,
                textScaleFactor: 2.0,
                style: TextStyle(
                    color:Colors.deepPurple,
                    fontSize:resultFontSize,
                    fontFamily: 'Montserrat'
                )
            ),
          ),

          Expanded(
            child: Image(
              image: AssetImage("assets/canva.jpg"),
              fit: BoxFit.cover,
            ),
          ),

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: MediaQuery.of(context).size.width * .75,
                child: Table(
                  children: [

                    TableRow(
                      children: [
                        buildButton("C", 1, Colors.deepPurpleAccent),
                        buildButton("⌫", 1, Colors.purpleAccent),
                        buildButton("÷", 1, Colors.purpleAccent),
                      ],
                    ),

                    TableRow(
                      children: [
                        buildButton("7", 1, Colors.black),
                        buildButton("8", 1, Colors.black),
                        buildButton("9", 1, Colors.black),
                      ],
                    ),

                    TableRow(
                      children: [
                        buildButton("4", 1, Colors.black),
                        buildButton("5", 1, Colors.black),
                        buildButton("6", 1, Colors.black),
                      ],
                    ),

                    TableRow(
                      children: [
                        buildButton("1", 1, Colors.black),
                        buildButton("2", 1, Colors.black),
                        buildButton("3", 1, Colors.black),
                      ],
                    ),

                    TableRow(
                      children: [
                        buildButton(".", 1, Colors.black),
                        buildButton("0", 1, Colors.black),
                        buildButton("00", 1, Colors.black),
                      ],
                    )

                  ],
                ),
              ),

              Container(
                width: MediaQuery.of(context).size.width * 0.25,
                child: Table(
                  children: [

                    TableRow(
                      children: [
                        buildButton("×", 1, Colors.purpleAccent),
                      ]
                    ),

                    TableRow(
                        children: [
                          buildButton("+", 1, Colors.purpleAccent),
                        ]
                    ),

                    TableRow(
                        children: [
                          buildButton("-", 1, Colors.purpleAccent),
                        ]
                    ),

                    TableRow(
                        children: [
                          buildButton("=", 2, Colors.deepPurpleAccent),
                        ]
                    )

                  ],
                )
              )
            ],
          )
        ],
      ),

    );
  }
}