import 'package:kdigital_test/src/data/models/character.dart';
import 'package:kdigital_test/src/domain/repository/characters_repository.dart';
import 'package:kdigital_test/src/presentation/bloc/main_bloc.dart';
import 'package:kdigital_test/src/presentation/bloc/main_event.dart';
import 'package:kdigital_test/src/presentation/bloc/main_state.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

@immutable
class CharactersScreen extends StatelessWidget {
  final MainPageBloc mainPageBloc = MainPageBloc(
      InitialMainPageState(),
      GetIt.I.get<CharactersRepository>()
  );
  final ScrollController scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    List<Character> characters = [];
    return Scaffold(
      body: BlocProvider(
        create: (context) => mainPageBloc..add(const LoadingDataOnMainPageEvent()),
        child: BlocConsumer<MainPageBloc, MainPageState>(
          listener: (context, state) {},
          builder: (blocContext, state) {
            if (state is LoadingMainPageState) {
              return _loadingWidget(context);
            } else if (state is LoadingNextMainPageState || state is SuccessfulMainPageState
                || state is UnSuccessfulNextMainPageState) {
              if (state is SuccessfulMainPageState) characters.addAll(state.characters);
              return Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  _successfulWidget(context, characters),
                  if (state is LoadingNextMainPageState) _loadingNextPageWidget(context),
                  if (state is UnSuccessfulNextMainPageState) _errorLoadingWidget(context),
                ],
              );
            } else {
              return Center(child: const Text("error"));
            }
          },
        ),
      ),
    );
  }

  Widget _loadingWidget(BuildContext context) {
    return Center(
      child: Container(
        width: 50,
        height: 50,
        margin: EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(12)),
        ),
        child: const CircularProgressIndicator(),
      ),
    );
  }

  Widget _loadingNextPageWidget(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: CircularProgressIndicator(),
    );
  }

  Widget _errorLoadingWidget(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(46.0),
      child: Text('error', style: TextStyle(color: Colors.red),),
    );
  }

  Widget _successfulWidget(
      BuildContext context, List<Character> characters) {
    scrollController.addListener(() {
      if (scrollController.offset == scrollController.position.maxScrollExtent) {
        mainPageBloc.add(LoadingNextDataOnMainPageEvent());
      }
    });
    return ListView.builder(
      cacheExtent: double.infinity,
      controller: scrollController,
      itemCount: characters.length,
      itemBuilder: (context, index) {
        return _characterWidget(context, characters[index]);
      },
    );
  }

  Widget _characterWidget(BuildContext context, Character character) {
    return Container(
      alignment: Alignment.topLeft,
      padding: EdgeInsets.all(8),
      child: Container(
        padding: const EdgeInsets.all(16),
        width: double.infinity,
        decoration: ShapeDecoration(
          color: Color.fromARGB(120, 204, 255, 255),
          shape: ContinuousRectangleBorder(
            borderRadius: BorderRadius.circular(32),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(2.0),
              child: Text(character.name),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  height: 50,
                  width: 50,
                  child: CachedNetworkImage(
                    imageUrl: character.image,
                    placeholder: (context, url) => CircularProgressIndicator(),
                    errorWidget: (context, url, error) => Icon(Icons.error),
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(2.0),
                      child: Text(character.gender),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(2.0),
                      child: Text(
                        character.status,
                        style: TextStyle(color: character.status == 'Alive'
                            ? Colors.green
                            : Colors.red
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
