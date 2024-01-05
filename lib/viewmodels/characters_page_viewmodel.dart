import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_proje/models/character.dart';
import 'package:http/http.dart' as http;

class CharactersPageViewModel with ChangeNotifier {
  final List<Character> _characterList = [];
  CharactersPageViewModel(BuildContext c) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _getCharacters(c);
    });
  }
  List<Character> get characterList => _characterList;
  final String url = "https://rickandmortyapi.com/api/character";

  void _getCharacters(BuildContext c) async {
    Uri uri = Uri.parse(url);
    http.Response res = await http.get(uri);

    if (res.statusCode == 200) {
      List<dynamic> characters = jsonDecode(res.body)["results"];
      print(characters[0]["name"]);
      for (Map<String, dynamic> characterMap in characters) {
        Character char = Character.fromMap(characterMap);
        _characterList.add(char);
      }
      notifyListeners();
    } else {
      createSnackbar(c, "failed to get proper response");
    }
  }

  void createSnackbar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(message),
    ));
  }
}
