import 'dart:convert';
import 'package:http/http.dart';
import '../../models/character.dart';

class CharacterService {
  static const _BASE_URL = 'https://rickandmortyapi.com/api/character/?page=';

  Future<List<Character>?> getCharacters(int page) async {
    var client = Client();
    try {
      final charResult = await client.get(
        Uri.parse('$_BASE_URL$page'),
      );
      final jsonMap = await json.decode(charResult.body) as Map<String, dynamic>;

      return Future.value(
        List.of(
          (jsonMap["results"] as List<dynamic>).map(
                (value) => Character.fromJson(value),
          ),
        ),
      );
    } catch (e) {
      await Future.delayed(const Duration(seconds: 1));
      print(e);
    }
    return Future(() => null);
  }
}