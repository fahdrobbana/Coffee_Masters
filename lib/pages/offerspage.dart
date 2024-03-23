// ignore_for_file: use_key_in_widget_constructors

import 'package:flutter/material.dart';

class OffersPage extends StatelessWidget {
  const OffersPage({Key? key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: const [
        Offer(
          title: "My Great offer ever",
          description: "Buy 1 get 10 for free!",
        ),
                Offer(
          title: "My Great offer ever",
          description: "Buy 1 get 10 for free!",
        ),
                Offer(
          title: "My Great offer ever",
          description: "Buy 1 get 10 for free!",
        ),
                Offer(
          title: "My Great offer ever",
          description: "Buy 1 get 10 for free!",
        ),
                Offer(
          title: "My Great offer ever",
          description: "Buy 1 get 10 for free!",
        ),
                Offer(
          title: "My Great offer ever",
          description: "Buy 1 get 10 for free!",
        ),
                Offer(
          title: "My Great offer ever",
          description: "Buy 1 get 10 for free!",
        ),
                Offer(
          title: "My Great offer ever",
          description: "Buy 1 get 10 for free!",
        ),
                Offer(
          title: "My Great offer ever",
          description: "Buy 1 get 10 for free!",
        ),
      ],
    );
  }
}

class Offer extends StatelessWidget {
  final String title;
  final String description;

  const Offer({super.key, required this.title, required this.description});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 150,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Card(
          color: Colors.amber.shade50,
          elevation: 7,
          child: Container(
            decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("images/background.png"),
                    fit: BoxFit.cover)),
            child: Column(
              children: [
                Center(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      color: Colors.amber.shade50,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          title,
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Center(
                    child: Container(
                      color: Colors.amber.shade50,
                      child: Text(description),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

void main() {
  runApp(const MaterialApp(
    home: Scaffold(
      body: OffersPage(),
    ),
  ));
}
