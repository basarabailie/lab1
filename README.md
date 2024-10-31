import 'package:flutter/material.dart';

void main() {
runApp(CurrencyConverterApp());
}

class CurrencyConverterApp extends StatelessWidget {
@override
Widget build(BuildContext context) {
return MaterialApp(
debugShowCheckedModeBanner: false,
home: CurrencyConverter(),
);
}
}

class CurrencyConverter extends StatefulWidget {
@override
_CurrencyConverterState createState() => _CurrencyConverterState();
}

class _CurrencyConverterState extends State<CurrencyConverter> {
final TextEditingController _amountController = TextEditingController(text: '1000.00');
double _convertedAmount = 736.70; // Example converted amount
double _exchangeRate = 17.65; // Example exchange rate

@override
Widget build(BuildContext context) {
return Scaffold(
appBar: AppBar(
title: Text('Currency Converter', style: TextStyle(color: Colors.deepPurple)),
backgroundColor: Colors.white,
elevation: 0,
iconTheme: IconThemeData(color: Colors.black),
),
body: Padding(
padding: const EdgeInsets.all(16.0),
child: Column(
mainAxisAlignment: MainAxisAlignment.center,
children: [
Text('Currency Converter', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.deepPurple)),
SizedBox(height: 20),
Container(
padding: EdgeInsets.all(16),
decoration: BoxDecoration(
color: Colors.white,
borderRadius: BorderRadius.circular(12),
boxShadow: [BoxShadow(color: Colors.grey.shade200, blurRadius: 8, spreadRadius: 2)],
),
child: Column(
children: [
Row(
children: [
_currencyDropdown('MDL', '🇲🇩'),
SizedBox(width: 10),
Expanded(
child: TextField(
controller: _amountController,
keyboardType: TextInputType.numberWithOptions(decimal: true),
decoration: InputDecoration(
border: InputBorder.none,
hintText: 'Enter amount',
),
textAlign: TextAlign.right,
),
),
],
),
Divider(),
Row(
children: [
_currencyDropdown('USD', '🇺🇸'),
SizedBox(width: 10),
Expanded(
child: Text(
_convertedAmount.toStringAsFixed(2),
style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
textAlign: TextAlign.right,
),
),
],
),
],
),
),
SizedBox(height: 20),
Text('Indicative Exchange Rate', style: TextStyle(color: Colors.grey)),
SizedBox(height: 5),
Text('1 USD = $_exchangeRate MDL', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
],
),
),
);
}

Widget _currencyDropdown(String currency, String flag) {
return DropdownButton<String>(
value: currency,
icon: Icon(Icons.arrow_drop_down),
onChanged: (String? newValue) {
setState(() {
// Update currency if needed
});
},
items: <String>['MDL', 'USD'].map<DropdownMenuItem<String>>((String value) {
return DropdownMenuItem<String>(
value: value,
child: Row(
children: [
Text(flag),
SizedBox(width: 8),
Text(value),
],
),
);
}).toList(),
);
}
}
