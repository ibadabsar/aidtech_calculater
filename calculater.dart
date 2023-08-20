import 'package:flutter/material.dart';

void main() {
  runApp(CalculatorApp());
}

class CalculatorApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calculator App',
      theme: ThemeData.light(),
      home: CalculatorScreen(),
    );
  }
}

class CalculatorScreen extends StatefulWidget {
  @override
  _CalculatorScreenState createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  String _output = "0";
  double _num1 = 0;
  double _num2 = 0;
  String _operator = "";
  bool _isOperatorChosen = false;

  void _buttonPressed(String buttonText) {
    setState(() {
      if (buttonText == "C") {
        _output = "0";
        _num1 = 0;
        _num2 = 0;
        _operator = "";
        _isOperatorChosen = false;
      } else if (buttonText == "=") {
        if (_isOperatorChosen && _operator.isNotEmpty) {
          _num2 = double.parse(_output);
          _output = _performCalculation(_num1, _num2, _operator).toString();
          _num1 = double.parse(_output);
          _num2 = 0;
          _operator = "";
          _isOperatorChosen = false;
        }
      } else if (buttonText == "+" || buttonText == "-" || buttonText == "*" || buttonText == "/") {
        if (_isOperatorChosen) {
          _num2 = double.parse(_output);
          _output = _performCalculation(_num1, _num2, _operator).toString();
          _num1 = double.parse(_output);
          _num2 = 0;
          _operator = buttonText;
        } else {
          _isOperatorChosen = true;
          _operator = buttonText;
          _num1 = double.parse(_output);
          _output = "0"; // Reset output for next number
        }
      } else {
        if (_output == "0" || (_isOperatorChosen && _output == _num1.toString())) {
          _output = buttonText;
        } else {
          _output += buttonText;
        }
        if (!_isOperatorChosen) {
          _num1 = double.parse(_output);
        }
      }
    });
  }

  double _performCalculation(double num1, double num2, String operator) {
    switch (operator) {
      case "+":
        return num1 + num2;
      case "-":
        return num1 - num2;
      case "*":
        return num1 * num2;
      case "/":
        if (num2 != 0) {
          return num1 / num2;
        } else {
          return double.infinity; // Handle division by zero
        }
      default:
        return 0;
    }
  }

  Widget _buildCalculatorButton(String buttonText, {Color color = Colors.white}) {
    return Expanded(
      child: Container(
        margin: EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.3),
              spreadRadius: 1,
              blurRadius: 5,
            ),
          ],
        ),
        child: TextButton(
          onPressed: () => _buttonPressed(buttonText),
          style: ButtonStyle(
            padding: MaterialStateProperty.all(EdgeInsets.all(20)),
          ),
          child: Text(
            buttonText,
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.black),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Calculator'),
        centerTitle: true,
        backgroundColor: Colors.black,
      ),
      body: Container(
        color: Colors.grey[300], // Light gray background color
        child: Column(
          children: [
            Expanded(
              child: Container(
                alignment: Alignment.bottomRight,
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 30),
                child: Text(
                  _output,
                  style: TextStyle(fontSize: 48, fontWeight: FontWeight.bold, color: Colors.black),
                ),
              ),
            ),
            Divider(height: 1, color: Colors.black),
            Row(
              children: [
                _buildCalculatorButton("7"),
                _buildCalculatorButton("8"),
                _buildCalculatorButton("9"),
                _buildCalculatorButton("/", color: Colors.orange),
              ],
            ),
            Row(
              children: [
                _buildCalculatorButton("4"),
                _buildCalculatorButton("5"),
                _buildCalculatorButton("6"),
                _buildCalculatorButton("*", color: Colors.orange),
              ],
            ),
            Row(
              children: [
                _buildCalculatorButton("1"),
                _buildCalculatorButton("2"),
                _buildCalculatorButton("3"),
                _buildCalculatorButton("-", color: Colors.orange),
              ],
            ),
            Row(
              children: [
                _buildCalculatorButton("C", color: Color.fromARGB(255, 53, 53, 53)),
                _buildCalculatorButton("0"),
                _buildCalculatorButton("=", color: Colors.orange),
                _buildCalculatorButton("+", color: Colors.orange),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
