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

  int _page = 1;
  bool _canIncrease = true;
  int get page => _page;

  set page(int value) {
    _page = value;
  }

  String url = "https://rickandmortyapi.com/api/character?page=";
  void _getCharacters(BuildContext c) async {
    Uri uri = Uri.parse(url);
    http.Response res = await http.get(uri);

    if (res.statusCode == 200) {
      _canIncrease = true;
      characterList.clear();
      List<dynamic> characters = jsonDecode(res.body)["results"];
      //print(characters[0]["name"]);
      for (Map<String, dynamic> characterMap in characters) {
        Character char = Character.fromMap(characterMap);
        _characterList.add(char);
      }
      notifyListeners();
    } else {
      //_canIncrease = false;
      _page--;
      createSnackbar(c, "failed to get proper response");
    }
  }

  void createSnackbar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(message),
    ));
  }

  void nextButton(BuildContext c) {
    _page++;
    url = "https://rickandmortyapi.com/api/character?page=$_page";
    _getCharacters(c);
  }

  void prevButton(BuildContext c) {
    if (_page >= 2) {
      _page--;
      url = "https://rickandmortyapi.com/api/character?page=$_page";
      _getCharacters(c);
    }
  }
}
