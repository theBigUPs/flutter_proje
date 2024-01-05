import 'package:flutter/material.dart';
import 'package:flutter_proje/models/character.dart';
import 'package:flutter_proje/viewmodels/characters_page_viewmodel.dart';
import 'package:provider/provider.dart';

class CharactersPage extends StatelessWidget {
  const CharactersPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child: _charactersListView(context)),
      backgroundColor: const Color(0xff272b33),
    );
  }

  Widget _charactersListView(BuildContext context) {
    return Consumer<CharactersPageViewModel>(
      builder: (context, viewModel, child) => ListView.builder(
        itemCount: viewModel.characterList.length,
        itemBuilder: (context, index) {
          return ChangeNotifierProvider.value(
            value: viewModel.characterList[index],
            child: _buildListTile(context),
          );
        },
      ),
    );
  }

  Widget _buildListTile(BuildContext context) {
    CharactersPageViewModel viewModel = Provider.of<CharactersPageViewModel>(
      context,
      listen: false,
    );
    return Consumer<Character>(
        builder: (context, value, child) => Center(
            child: Card(
                color: const Color(0xff3c3e44),
                elevation: 0,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(12)),
                ),
                child: SizedBox(
                    width: double.infinity,
                    height: 100,
                    child: Row(
                      children: [
                        ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: Image.network(value.imgURl)),
                        const SizedBox(
                          width: 12,
                        ),
                        Expanded(
                          child: SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Column(
                              //mainAxisAlignment: MainAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(value.name),
                                Row(children: [
                                  Container(
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: value.status == "Alive"
                                          ? Colors.green
                                          : value.status == "unknown"
                                              ? Colors.grey
                                              : Colors.red,
                                    ),
                                    height: 12,
                                    width: 12,
                                  ),
                                  const SizedBox(
                                    width: 8,
                                  ),
                                  Text("${value.status} - ${value.species}"),
                                ]),
                                Text(
                                    "First Seen In:  ${value.originalLocationName}"),
                                Text("Last Seen In: ${value.lastLocationName}"),
                              ],
                            ),
                          ),
                        )
                      ],
                    )))));
  }
}
