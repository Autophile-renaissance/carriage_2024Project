import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class AutocompleteScreen extends StatefulWidget {
  @override
  _AutocompleteScreenState createState() => _AutocompleteScreenState();
}

class _AutocompleteScreenState extends State<AutocompleteScreen> {
  final TextEditingController _controller = TextEditingController();
   Future<List<dynamic>> fetchPredictions(String input, String apiKey) async {
  final url =
      'https://maps.googleapis.com/maps/api/place/autocomplete/json?input=$input&key=$apiKey';
  
  final response = await http.get(Uri.parse(url));

  if (response.statusCode == 200) {
    final data = json.decode(response.body);
    return data['predictions']; // Adjust based on API response structure
  } else {
    throw Exception('Failed to load predictions');
  }
}



  List<dynamic> _predictions = [];
  bool _isLoading = false;
  final String apiKey = 'AIzaSyAla7c_rE9yLOP7tSvuuJs09DaCx9XkgUE'; // Replace with your API key

  void _onTextChanged(String value) async {
    if (value.isNotEmpty) {
      setState(() {
        _isLoading = true;
      });

      try {
        final predictions = await fetchPredictions(value, apiKey);
        setState(() {
          _predictions = predictions;
        });
      } catch (e) {
        // Handle error
        print('Error fetching predictions: $e');
      } finally {
        setState(() {
          _isLoading = false;
        });
      }
    } else {
      setState(() {
        _predictions = [];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Autocomplete')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: _controller,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Search',
                suffixIcon: _isLoading
                    ? CircularProgressIndicator()
                    : null,
              ),
              onChanged: _onTextChanged,
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _predictions.length,
              itemBuilder: (context, index) {
                final prediction = _predictions[index];
                return ListTile(
                  title: Text(prediction['description']),
                  onTap: () {
                    // Handle selection of prediction
                    print('Selected: ${prediction['description']}');
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
