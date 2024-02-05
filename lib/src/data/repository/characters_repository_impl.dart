import 'dart:async';
import 'package:kdigital_test/src/data/models/character.dart';
import 'package:kdigital_test/src/domain/repository/characters_repository.dart';
import '../api/api_util.dart';

class CharactersRepositoryImpl implements CharactersRepository {
  final ApiUtil _apiUtil;

  CharactersRepositoryImpl(this._apiUtil);

  @override
  Future<List<Character>?> getCharacters(int page) async {
    return _apiUtil.getCharacters(page);
  }
}
