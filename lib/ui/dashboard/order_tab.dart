
import 'package:flutter/material.dart';

class OrderTab extends StatefulWidget {
  @override
  _OrderTabState createState() => _OrderTabState();
}

class _OrderTabState extends State<OrderTab> {
  int catCounter = 1;

  void _incrementCatCounter() {
    setState(() {
      catCounter++;
    });
  }
  void _decrementCatCounter() {
    if (catCounter > 1) {
      setState(() {
        catCounter--;
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Order Your Cat Tab'),
              Spacer(),
              IconButton(
                icon: Icon(Icons.remove),
                onPressed: () {
                  _decrementCatCounter();
                },
              ),
              IconButton(
                icon: Icon(Icons.add),
                onPressed: () {
                  _incrementCatCounter();
                },
              ),
            ],
          ),
          Expanded(
            child: ListView.builder(
              itemCount: catCounter,
              itemBuilder: (context, index) {
                return Container(
                  margin: EdgeInsets.all(8),
                  child: Row(
                    children: [
                      Image.asset("assets/images/cat.jpg", height: 102),
                      SizedBox(width: 16),
                      Text("Cat Number: ${index + 1}"),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
