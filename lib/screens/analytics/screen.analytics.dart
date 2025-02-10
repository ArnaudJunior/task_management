

import 'package:flutter/material.dart';

class AnalytiqueScreen extends StatefulWidget {
  const AnalytiqueScreen({Key? key}) : super(key: key);

  static const String path = '/analytique';
  static const String name = 'Analytique';

  @override
  State<AnalytiqueScreen> createState() => _AnalytiqueScreenState();
}

class _AnalytiqueScreenState extends State<AnalytiqueScreen> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('Analytique'),
      ),
    );
  }
}