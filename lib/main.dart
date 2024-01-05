import 'package:flutter/material.dart';
import 'package:flutter_proje/viewmodels/characters_page_viewmodel.dart';
import 'package:flutter_proje/views/characters_page.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData.dark(),
      home: ChangeNotifierProvider(
          create: (BuildContext context) {
            return CharactersPageViewModel(context);
          },
          child: const CharactersPage()),
    );
  }
}
