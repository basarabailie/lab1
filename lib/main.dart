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
  double _convertedAmount = 0.0;

  // Example exchange rates
  double _mdlToUsd = 17.65; // 1 USD = 17.65 MDL
  double _mdlToEur = 19.00; // 1 EUR = 19.00 MDL
  double _eurToUsd = 1.10;  // 1 EUR = 1.10 USD

  String _fromCurrency = 'MDL';
  String _toCurrency = 'USD';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Currency Converter', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.deepPurple,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Currency Converter', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.deepPurple)),
            SizedBox(height: 20),
            _buildInputSection(),
            SizedBox(height: 20),
            _buildOutputSection(),
            SizedBox(height: 20),
            Text('Indicative Exchange Rates', style: TextStyle(color: Colors.grey)),
            SizedBox(height: 5),
            Text('1 USD = $_mdlToUsd MDL', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            Text('1 EUR = $_mdlToEur MDL', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }

  Widget _buildInputSection() {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [BoxShadow(color: Colors.grey.shade300, blurRadius: 8, spreadRadius: 2)],
      ),
      child: Column(
        children: [
          Row(
            children: [
              _currencyDropdown('from', _fromCurrency),
              SizedBox(width: 10),
              Expanded(
                child: TextField(
                  controller: _amountController,
                  keyboardType: TextInputType.numberWithOptions(decimal: true),
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Enter amount',
                    hintStyle: TextStyle(color: Colors.grey),
                  ),
                  textAlign: TextAlign.right,
                  onChanged: _convertCurrency,
                ),
              ),
            ],
          ),
          Divider(),
          Row(
            children: [
              _currencyDropdown('to', _toCurrency),
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
    );
  }

  Widget _buildOutputSection() {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [BoxShadow(color: Colors.grey.shade300, blurRadius: 8, spreadRadius: 2)],
      ),
      child: Column(
        children: [
          Text('Converted Amount', style: TextStyle(fontSize: 20)),
          SizedBox(height: 10),
          Text(
            _convertedAmount.toStringAsFixed(2),
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }

  void _convertCurrency(String value) {
    if (value.isEmpty) {
      setState(() {
        _convertedAmount = 0.0;
      });
      return;
    }
    double amount = double.tryParse(value) ?? 0.0;

    if (_fromCurrency == 'MDL' && _toCurrency == 'USD') {
      _convertedAmount = amount / _mdlToUsd;
    } else if (_fromCurrency == 'MDL' && _toCurrency == 'EUR') {
      _convertedAmount = amount / _mdlToEur;
    } else if (_fromCurrency == 'USD' && _toCurrency == 'MDL') {
      _convertedAmount = amount * _mdlToUsd;
    } else if (_fromCurrency == 'USD' && _toCurrency == 'EUR') {
      _convertedAmount = amount / _eurToUsd;
    } else if (_fromCurrency == 'EUR' && _toCurrency == 'MDL') {
      _convertedAmount = amount * _mdlToEur;
    } else if (_fromCurrency == 'EUR' && _toCurrency == 'USD') {
      _convertedAmount = amount * _eurToUsd;
    } else {
      _convertedAmount = amount; // If both currencies are the same
    }
    setState(() {});
  }

  Widget _currencyDropdown(String type, String selectedCurrency) {
    return DropdownButton<String>(
      value: selectedCurrency,
      icon: Icon(Icons.arrow_drop_down),
      onChanged: (String? newValue) {
        setState(() {
          if (type == 'from') {
            _fromCurrency = newValue!;
          } else {
            _toCurrency = newValue!;
          }
          _convertCurrency(_amountController.text); // Recalculate on currency change
        });
      },
      items: <String>['MDL', 'USD', 'EUR'].map<DropdownMenuItem<String>>((String value) {
        String flag = '';
        switch (value) {
          case 'MDL':
            flag = '🇲🇩'; // Moldovan Leu flag
            break;
          case 'USD':
            flag = '🇺🇸'; // US Dollar flag
            break;
          case 'EUR':
            flag = '🇪🇺'; // Euro flag
            break;
        }
        return DropdownMenuItem<String>(
          value: value,
          child: Row(
            children: [
              Text(flag, style: TextStyle(fontSize: 20)), // Display flag
              SizedBox(width: 8),
              Text(value),
            ],
          ),
        );
      }).toList(),
    );
  }
}
