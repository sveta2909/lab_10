import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Text Preview App',
      home: InputScreen(),
    );
  }
}

class InputScreen extends StatefulWidget {
  @override
  _InputScreenState createState() => _InputScreenState();
}

class _InputScreenState extends State<InputScreen> {
  final TextEditingController textController = TextEditingController();
  double fontSize = 14;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Text Preview')),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: TextField(
                  controller: textController,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Enter text',
                    contentPadding: EdgeInsets.all(16),
                  ),
                ),
              ),
              SizedBox(height: 20),
              Text('Font size: ${fontSize.toInt()}'),
              Slider(
                value: fontSize,
                min: 1,
                max: 100,
                divisions: 30,
                label: fontSize.round().toString(),
                onChanged: (double value) {
                  setState(() {
                    fontSize = value;
                  });
                },
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => PreviewScreen(
                        text: textController.text,
                        fontSize: fontSize,
                      ),
                    ),
                  );
                },
                child: Text('Preview'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class PreviewScreen extends StatelessWidget {
  final String text;
  final double fontSize;

  PreviewScreen({required this.text, required this.fontSize});

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        _showDialog(context, "Don't know what to say");
        return false;
      },
      child: Scaffold(
        appBar: AppBar(title: Text('Preview')),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(text, style: TextStyle(fontSize: fontSize)),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                      _showDialog(context, 'Cool!');
                    },
                    child: Text('Ok'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                      _showDialog(context, 'Let’s try something else');
                    },
                    child: Text('Cancel'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showDialog(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        contentPadding: EdgeInsets.all(20),
        title: Column(
          children: [
            Image.network(
              'https://emojiisland.com/cdn/shop/products/Robot_Emoji_Icon_abe1111a-1293-4668-bdf9-9ceb05cff58e_large.png?v=1571606090',
              width: 40,
              height: 40,
            ),
            SizedBox(height: 10),
            Text(message),
          ],
        ),
        actions: [
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text('Ok'),
          ),
        ],
      ),
    );
  }
}