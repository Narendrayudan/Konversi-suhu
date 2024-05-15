import 'package:flutter/material.dart';

void main() {
  runApp(SuhuKonversiApp());
}

class SuhuKonversiApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Konversi Suhu',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: KonversiSuhuScreen(),
    );
  }
}

class KonversiSuhuScreen extends StatefulWidget {
  @override
  _KonversiSuhuScreenState createState() => _KonversiSuhuScreenState();
}

class _KonversiSuhuScreenState extends State<KonversiSuhuScreen> {
  final TextEditingController _controller = TextEditingController();
  String _selectedInputUnit = 'Celcius';
  String _selectedOutputUnit = 'Fahrenheit';
  String _result = '';

  void _convert() {
    double input = double.tryParse(_controller.text) ?? 0;
    double output;

    if (_selectedInputUnit == 'Celcius') {
      if (_selectedOutputUnit == 'Fahrenheit') {
        output = (input * 9/5) + 32;
      } else if (_selectedOutputUnit == 'Kelvin') {
        output = input + 273.15;
      } else {
        output = input;
      }
    } else if (_selectedInputUnit == 'Fahrenheit') {
      if (_selectedOutputUnit == 'Celcius') {
        output = (input - 32) * 5/9;
      } else if (_selectedOutputUnit == 'Kelvin') {
        output = (input - 32) * 5/9 + 273.15;
      } else {
        output = input;
      }
    } else if (_selectedInputUnit == 'Kelvin') {
      if (_selectedOutputUnit == 'Celcius') {
        output = input - 273.15;
      } else if (_selectedOutputUnit == 'Fahrenheit') {
        output = (input - 273.15) * 9/5 + 32;
      } else {
        output = input;
      }
    } else {
      output = input;
    }

    setState(() {
      _result = output.toStringAsFixed(2);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Konversi Suhu'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _controller,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Masukkan nilai suhu',
              ),
            ),
            SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                DropdownButton<String>(
                  value: _selectedInputUnit,
                  items: ['Celcius', 'Fahrenheit', 'Kelvin']
                      .map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    setState(() {
                      _selectedInputUnit = newValue!;
                    });
                  },
                ),
                Icon(Icons.arrow_forward),
                DropdownButton<String>(
                  value: _selectedOutputUnit,
                  items: ['Celcius', 'Fahrenheit', 'Kelvin']
                      .map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    setState(() {
                      _selectedOutputUnit = newValue!;
                    });
                  },
                ),
              ],
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: _convert,
              child: Text('Konversi'),
            ),
            SizedBox(height: 16),
            Text(
              'Hasil: $_result $_selectedOutputUnit',
              style: TextStyle(fontSize: 20),
            ),
          ],
        ),
      ),
    );
  }
}
