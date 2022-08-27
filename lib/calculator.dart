
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:math_expressions/math_expressions.dart';

import 'config.dart';



class Calculator extends StatefulWidget {
  @override
  _CalculatorState createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {


  int segmentedControlGroupValue = 0;
  final Map<int, Widget> myTabs = const <int, Widget>{
    0: Text("Deg", style: TextStyle(color: Colors.white),),
    1: Text("Rad", style: TextStyle(color: Colors.white),)
  };

  final List<String> buttons1 = ['CALC','COPY', '∫ₐᵇ dx', 'x⁻¹', 'logₓ', 'SOLVE', 'd/dx', 'x!', 'Σ', '=','X','Y'];
  final List<String> buttons2 = ['ˣ/ₓ', '√x', 'x²', 'xˣ', 'log', 'ln', 'x ˣ/ₓ', '3√x', 'x³','ˣ√x','10ˣ','eˣ'];
  final List<String> buttons3 = ['(-)', "° ' \" ", 'hyp', 'sin', 'cos', 'tan', 'Abs', 'sin⁻¹', 'cos⁻¹','tan⁻¹','A','B'];
  final List<String> buttons4 = ['ENG', '(', ')', 'S<->D', 'M+', 'nPr','nCr', '%', "M-",'M','C','D'];



  String _mode = 'Simple';
  String equation = '';
  String result = '';
  String expression = '';
  double resultFont = 0;
  int fact = 1;
  int i,num;
  bool isShiftPressed = true;
  final List<String> conversionType = ['Length'];

  List conversionSelected = [] ;

  TypeC(String type){
    setState(() {
      if(type == 'Length'){
        conversionSelected = [' in -> cm', ' cm -> in', ' ft -> m', ' m -> ft', ' yd -> m', ' m -> yd', ' mile -> km',
          ' km -> mile', ' n mile -> m', ' m -> n mile', ' acre -> m\u00B2', ' m\u00B2 -> acre', ' gal(US) -> L', ' L -> gal(US)',
          ' gal(UK) -> L', ' L -> gal(UK)', ' pc -> km', ' km -> pc', ' km/h -> m/s', ' m/s -> km/h', ' mile/h -> km/h',
          ' km/h -> mile/h', ' oz -> g', ' g -> oz', ' lb -> kg', ' kg -> lb', ' atm -> Pa', ' Pa -> atm', ' mmHg -> Pa',
          ' Pa -> mmHg', ' hp -> kW', ' kW -> hp', ' kgf/cm\u00B2 -> Pa', ' Pa -> kgf/cm\u00B2', ' kgf.m -> J', ' J -> kgf.m',
          ' lbf/in\u00B2 -> kPa', ' kPa -> lbf/in\u00B2', ' ᵅF -> ᵅC', ' ᵅC -> ᵅF', ' J -> cal', ' cal -> J',
        ];
      }
    });
  }

  int factorial(int n) {
    if (n < 0) throw ('Negative numbers are not allowed.');
    return n <= 1 ? 1 : n * factorial(n - 1);

  }

  ButtonPressed(String buttonText){
    setState(() {
      if(buttonText == 'AC'){
        equation = '';
        result = '';

      }else if(buttonText == 'DEL'){
        equation = equation.substring(0, equation.length - 1);
      }
      else if(buttonText == '='){
        expression = equation;
        expression = expression.replaceAll('x', '*');
        expression = expression.replaceAll(' in -> cm', '*2.54');
        expression = expression.replaceAll(' cm -> in', '/2.54');
        expression = expression.replaceAll(' ft -> m', '/3.281');
        expression = expression.replaceAll(' m -> ft', '*3.281');
        expression = expression.replaceAll(' yd -> m', '/1.094');
        expression = expression.replaceAll(' m -> yd', '*1.094');
        expression = expression.replaceAll(' mile -> km', '*1.609');
        expression = expression.replaceAll(' km -> mile', '/1.609');
        expression = expression.replaceAll(' n mile -> m', '/');
        expression = expression.replaceAll('in -> cm', '*2.54');
        expression = expression.replaceAll('x', '*');
        expression = expression.replaceAll('/', '/');
        expression = expression.replaceAll('in -> cm', '*2.54');
        expression = expression.replaceAll('x', '*');
        expression = expression.replaceAll('/', '/');
        expression = expression.replaceAll('in -> cm', '*2.54');
        expression = expression.replaceAll('x', '*');
        expression = expression.replaceAll('/', '/');
        expression = expression.replaceAll('in -> cm', '*2.54');
        expression = expression.replaceAll('x', '*');
        expression = expression.replaceAll('/', '/');
        expression = expression.replaceAll('in -> cm', '*2.54');
        expression = expression.replaceAll('x', '*');
        expression = expression.replaceAll('/', '/');
        expression = expression.replaceAll('in -> cm', '*2.54');
        expression = expression.replaceAll('x', '*');
        expression = expression.replaceAll('/', '/');
        expression = expression.replaceAll('in -> cm', '*2.54');
        expression = expression.replaceAll('x', '*');
        expression = expression.replaceAll('⁻¹', '^-1');
        expression = expression.replaceAll('in -> cm', '*2.54');
        expression = expression.replaceAll('π', '3.14159');


        try{
          Parser p = new Parser();
          Expression exp = p.parse(expression);

          ContextModel cn = ContextModel();
          result = '${exp.evaluate(EvaluationType.REAL, cn)}';
          if(result.length <= 8){
            resultFont = 0.100;
          }
          if(result.length >= 9){
            resultFont = 0.054;
          }
        }catch(e){
          result = 'Error';
        }

      }
      else if(buttonText == '!'){
        expression = equation;
        var one = int.parse(expression);
        try{
          result = factorial(one).toString();
          print(result);
        }catch(e){
          result = 'Error';
        }

      }
      else{
        if(equation == '0'){
          equation = buttonText;
        }else{
          if(equation.length <= 35){
            equation = equation + buttonText;
          }
        }
      }
    });
  }


  @override
  Widget build(BuildContext context) {

     SystemChrome.setPreferredOrientations(
         [DeviceOrientation.portraitDown, DeviceOrientation.portraitUp]);

     double h = MediaQuery.of(context).size.height;
     double w = MediaQuery.of(context).size.width;

    if(_mode == 'Simple'){
      return Scaffold(
       // backgroundColor: Colors.white,
        body: Container(
          height: h,
          width: w,
          child: Column(
            children: <Widget>[
              Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: IconButton(
                        icon: Icon(Icons.brightness_high),
                        onPressed: (){
                          currentTheme.switchTheme();
                        },
                      ),
                    ),
                    Container(
                      height: h*0.090,
                      alignment: Alignment.centerRight,
                      padding: EdgeInsets.fromLTRB(10.0, 0, 10.0, 0),
                      child: Text(equation, style: TextStyle(fontSize: MediaQuery.of(context).size.height*0.042, color: Colors.grey[600])),
                    ),
                    Container(
                      height: h*0.128,
                      alignment: Alignment.centerRight,
                      padding: EdgeInsets.fromLTRB(10.0, 2.0, 10.0, 10.0),
                      child: Text(result, style: TextStyle(fontSize: MediaQuery.of(context).size.height*resultFont)),
                    )
                  ],
                ),
               // color: Colors.white,
                height: h*0.340,
                width: w,
              ),
              Container(
                height: h*0.050,
                width: w,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    ButtonTheme(
                      height: h*0.050,
                      minWidth: w*0.200,
                      child: RaisedButton(
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(35.0)),
                        elevation: 5.0,
                        color: Color(0xFF000034),
                        //color: Color(0xFF1a1aff),
                        child: Text('Simple', style: TextStyle(color: Colors.white,),),
                        onPressed: (){
                          setState(() {
                            _mode = 'Simple';
                          });
                        },
                      ),
                    ),
                    ButtonTheme(
                      height: h*0.050,
                      minWidth: w*0.200,
                      child: RaisedButton(
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(35.0)),
                        elevation: 5.0,
                       // color: Colors.grey[100],
                        //color: Color(0xFF1a1aff),
                        child: Text('', style: TextStyle(
                          color: Color(0xFF000034),
                          //color: Color(0xFF000034),
                        ),),
                        onPressed: (){
                          setState(() {
                            // _mode = 'Scientific';
                          });
                        },
                      ),
                    ),
                    ButtonTheme(
                      height: MediaQuery.of(context).size.height*0.050,
                      minWidth: MediaQuery.of(context).size.width*0.200,
                      child: RaisedButton(
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(35.0)),
                        elevation: 5.0,
                        //color: Colors.grey[100],
                        //color: Color(0xFF1a1aff),
                        child: Text('', style: TextStyle(
                          color: Color(0xFF000034),
                          //color: Color(0xFF000034),
                        ),),
                        onPressed: (){
                          setState(() {
                            // _mode = 'Conversions';
                          });
                        },
                      ),
                    ),
                    ButtonTheme(
                      height: MediaQuery.of(context).size.height*0.050,
                      minWidth: MediaQuery.of(context).size.width*0.200,
                      child: RaisedButton(
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(35.0)),
                        elevation: 5.0,
                        //color: Colors.grey[100],
                        //color: Color(0xFF1a1aff),
                        child: Text('', style: TextStyle(
                          color: Color(0xFF000034),
                        ),),
                        onPressed: (){
//                          setState(() {
//                            _mode = 'Constants';
//                          });
                        },
                      ),
                    ),
                  ],
                ),
              ),
              SafeArea(
                child: Container(
                  //color: Colors.white,
                  alignment: Alignment.topCenter,
                  height: MediaQuery.of(context).size.height*0.555,
                  width: MediaQuery.of(context).size.width,
                  child: Table(
                    defaultColumnWidth: FractionColumnWidth(0.24),
                    children: [
                      TableRow(
                          children:[
                            Padding(
                              padding: const EdgeInsets.fromLTRB(8.0, 0, 4.0, 4.0),
                              child: ButtonTheme(
                                height: MediaQuery.of(context).size.height*0.100,
                                child: RaisedButton(
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
                                  elevation: 2.0,
                                  color: Color(0xFF000034),
                                  //color: Color(0xFF000034),
                                  child: Text('AC', style: TextStyle(color: Colors.white,fontSize: 20.0),),
                                  onPressed: (){
                                    ButtonPressed('AC');
                                  },
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(4.0, 0, 4.0, 4.0),
                              child: ButtonTheme(
                                height: MediaQuery.of(context).size.height*0.100,
                                child: RaisedButton(
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
                                  elevation: 2.0,
                                 // color: Colors.grey[100],
                                  //color: Color(0xFF1a1aff),
                                  //child: Text('DEL', style: TextStyle(color: Color(0xFF1a1aff),fontSize: 20.0),),
                                  child: Icon(Icons.backspace,
                                    //color: Color(0xFF1a1aff),
                                  ),
                                  onPressed: (){
                                    ButtonPressed('DEL');
                                  },
                                ),
                              ),
                            ),Padding(
                              padding: const EdgeInsets.fromLTRB(4.0, 0, 4.0, 4.0),
                              child: ButtonTheme(
                                height: MediaQuery.of(context).size.height*0.100,
                                child: RaisedButton(
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
                                  elevation: 2.0,
                                 // color: Colors.grey[100],
//                              color: Color(0xFF1a1aff),
                                  child: Text('π', style: TextStyle(
                                      //color: Color(0xFF1a1aff),
                                      fontSize: 30.0),),
                                  onPressed: (){
                                    ButtonPressed('π');
                                  },
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(4.0, 0, 8.0, 4.0),
                              child: ButtonTheme(
                                height: MediaQuery.of(context).size.height*0.100,
                                child: RaisedButton(
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
                                  elevation: 2.0,
                                  color: Color(0xFF1a1aff),
                                  child: Text('÷', style: TextStyle(color: Colors.white,fontSize: 30.0),),
                                  onPressed: (){
                                    ButtonPressed('/');
                                  },
                                ),
                              ),
                            ),
                          ]
                      ),
                      TableRow(
                          children:[
                            Padding(
                              padding: const EdgeInsets.fromLTRB(8.0, 4.0, 4.0, 4.0),
                              child: ButtonTheme(
                                height: MediaQuery.of(context).size.height*0.100,
                                child: RaisedButton(
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
                                  elevation: 2.0,
                                 // color: Colors.grey[100],
                                  child: Text('7', style: TextStyle(
                                      //color: Color(0xFF1a1aff),
                                      fontSize: 30.0),),
                                  onPressed: (){
                                    ButtonPressed('7');
                                  },
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(4.0, 4.0, 4.0, 4.0),
                              child: ButtonTheme(
                                height: MediaQuery.of(context).size.height*0.100,
                                child: RaisedButton(
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
                                  elevation: 2.0,
                               //   color: Colors.grey[100],
                                  child: Text('8', style: TextStyle(
                                     // color: Color(0xFF1a1aff),
                                      fontSize: 30.0),),
                                  onPressed: (){
                                    ButtonPressed('8');
                                  },
                                ),
                              ),
                            ),Padding(
                              padding: const EdgeInsets.fromLTRB(4.0, 4.0, 4.0, 4.0),
                              child: ButtonTheme(
                                height: MediaQuery.of(context).size.height*0.100,
                                child: RaisedButton(
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
                                  elevation: 2.0,
                                  //color: Colors.grey[100],
                                  child: Text('9', style: TextStyle(
                                   //   color: Color(0xFF1a1aff),
                                      fontSize: 30.0),),
                                  onPressed: (){
                                    ButtonPressed('9');
                                  },
                                ),
                              ),
                            ),Padding(
                              padding: const EdgeInsets.fromLTRB(4.0, 4.0, 8.0, 4.0),
                              child: ButtonTheme(
                                height: MediaQuery.of(context).size.height*0.100,
                                child: RaisedButton(
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
                                  elevation: 2.0,
                                  color: Color(0xFF1a1aff),
                                  child: Text('×', style: TextStyle(color: Colors.white,fontSize: 30.0),),
                                  onPressed: (){
                                    ButtonPressed('x');
                                  },
                                ),
                              ),
                            ),
                          ]
                      ),
                      TableRow(
                          children:[
                            Padding(
                              padding: const EdgeInsets.fromLTRB(8.0, 4.0, 4.0, 4.0),
                              child: ButtonTheme(
                                height: MediaQuery.of(context).size.height*0.100,
                                child: RaisedButton(
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
                                  elevation: 2.0,
                               //   color: Colors.grey[100],
                                  child: Text('4', style: TextStyle(
                                    //  color: Color(0xFF1a1aff),
                                      fontSize: 30.0),),
                                  onPressed: (){
                                    ButtonPressed('4');
                                  },
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(4.0, 4.0, 4.0, 4.0),
                              child: ButtonTheme(
                                height: MediaQuery.of(context).size.height*0.100,
                                child: RaisedButton(
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
                                  elevation: 2.0,
                               //   color: Colors.grey[100],
                                  child: Text('5', style: TextStyle(
                                    //  color: Color(0xFF1a1aff),
                                      fontSize: 30.0),),
                                  onPressed: (){
                                    ButtonPressed('5');
                                  },
                                ),
                              ),
                            ),Padding(
                              padding: const EdgeInsets.fromLTRB(4.0, 4.0, 4.0, 4.0),
                              child: ButtonTheme(
                                height: MediaQuery.of(context).size.height*0.100,
                                child: RaisedButton(
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
                                  elevation: 2.0,
                                //  color: Colors.grey[100],
                                  child: Text('6', style: TextStyle(
                                      //color: Color(0xFF1a1aff),
                                      fontSize: 30.0),),
                                  onPressed: (){
                                    ButtonPressed('6');
                                  },
                                ),
                              ),
                            ),Padding(
                              padding: const EdgeInsets.fromLTRB(4.0, 4.0, 8.0, 4.0),
                              child: ButtonTheme(
                                height: MediaQuery.of(context).size.height*0.100,
                                child: RaisedButton(
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
                                  elevation: 2.0,
                                  color: Color(0xFF1a1aff),
                                  child: Text('-', style: TextStyle(color: Colors.white,fontSize: 30.0),),
                                  onPressed: (){
                                    ButtonPressed('-');
                                  },
                                ),
                              ),
                            ),
                          ]
                      ),
                      TableRow(
                          children:[
                            Padding(
                              padding: const EdgeInsets.fromLTRB(8.0, 4.0, 4.0, 4.0),
                              child: ButtonTheme(
                                height: MediaQuery.of(context).size.height*0.100,
                                child: RaisedButton(
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
                                  elevation: 2.0,
                                  //color: Colors.grey[100],
                                  child: Text('1', style: TextStyle(
                                     // color: Color(0xFF1a1aff),
                                      fontSize: 30.0),),
                                  onPressed: (){
                                    ButtonPressed('1');
                                  },
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(4.0, 4.0, 4.0, 4.0),
                              child: ButtonTheme(
                                height: MediaQuery.of(context).size.height*0.100,
                                child: RaisedButton(
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
                                  elevation: 2.0,
                                 // color: Colors.grey[100],
                                  child: Text('2', style: TextStyle(
                                     // color: Color(0xFF1a1aff),
                                      fontSize: 30.0),),
                                  onPressed: (){
                                    ButtonPressed('2');
                                  },
                                ),
                              ),
                            ),Padding(
                              padding: const EdgeInsets.fromLTRB(4.0, 4.0, 4.0, 4.0),
                              child: ButtonTheme(
                                height: MediaQuery.of(context).size.height*0.100,
                                child: RaisedButton(
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
                                  elevation: 2.0,
                                 // color: Colors.grey[100],
                                  child: Text('3', style: TextStyle(
                                     // color: Color(0xFF1a1aff),

                                      fontSize: 30.0),),
                                  onPressed: (){
                                    ButtonPressed('3');
                                  },
                                ),
                              ),
                            ),Padding(
                              padding: const EdgeInsets.fromLTRB(4.0, 4.0, 8.0, 4.0),
                              child: ButtonTheme(
                                height: MediaQuery.of(context).size.height*0.100,
                                child: RaisedButton(
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
                                  elevation: 2.0,
                                  color: Color(0xFF1a1aff),
                                  child: Text('+', style: TextStyle(color: Colors.white,fontSize: 30.0),),
                                  onPressed: (){
                                    ButtonPressed('+');
                                  },
                                ),
                              ),
                            ),
                          ]
                      ),
                      TableRow(
                          children:[
                            Padding(
                              padding: const EdgeInsets.fromLTRB(8.0, 4.0, 4.0, 4.0),
                              child: ButtonTheme(
                                height: MediaQuery.of(context).size.height*0.100,
                                child: RaisedButton(
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
                                  elevation: 2.0,
                               //   color: Colors.grey[100],
                                  child: Text('0', style: TextStyle(
                                     // color: Color(0xFF1a1aff),
                                      fontSize: 30.0),),
                                  onPressed: (){
                                    ButtonPressed('0');
                                  },
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(4.0, 4.0, 4.0, 4.0),
                              child: ButtonTheme(
                                height: MediaQuery.of(context).size.height*0.100,
                                child: RaisedButton(
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
                                  elevation: 2.0,
                                 // color: Colors.grey[100],
                                  child: Text('00', style: TextStyle(
                                     // color: Color(0xFF1a1aff),
                                      fontSize: 30.0),),
                                  onPressed: (){
                                    ButtonPressed('00');
                                  },
                                ),
                              ),
                            ),Padding(
                              padding: const EdgeInsets.fromLTRB(4.0, 4.0, 4.0, 4.0),
                              child: ButtonTheme(
                                height: MediaQuery.of(context).size.height*0.100,
                                child: RaisedButton(
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
                                  elevation: 2.0,
                                 // color: Colors.grey[100],
                                  child: Text('.', style: TextStyle(
                                     // color: Color(0xFF1a1aff),
                                      fontSize: 30.0),),
                                  onPressed: (){
                                    ButtonPressed('.');
                                  },
                                ),
                              ),
                            ),Padding(
                              padding: const EdgeInsets.fromLTRB(4.0, 4.0, 8.0, 4.0),
                              child: ButtonTheme(
                                height: MediaQuery.of(context).size.height*0.100,
                                child: RaisedButton(
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
                                  elevation: 2.0,
                                  color: Color(0xFF000034),
                                  //color: Color(0xFF000034),
                                  child: Text('=', style: TextStyle(color: Colors.white,fontSize: 30.0),),
                                  onPressed: (){
                                    ButtonPressed('=');
                                  },
                                ),
                              ),
                            ),
                          ]
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    }
    if(_mode == 'Scientific'){
      return Container();
    }
    if(_mode == 'Conversions')
    {
      return Container();
    }
    else{
      return Container();
    }
  }
}

class MyTheme with ChangeNotifier{

  static bool _isDark = true;

  ThemeMode currentTheme(){
    return _isDark ? ThemeMode.dark : ThemeMode.light;
  }

  void switchTheme(){
    _isDark = !_isDark;
    notifyListeners();
  }
}