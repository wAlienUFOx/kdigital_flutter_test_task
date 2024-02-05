import 'package:kdigital_test/src/data/api/service/character_service.dart';
import '../models/character.dart';

class ApiUtil {
  final CharacterService _characterService;

  ApiUtil(this._characterService);

  Future<List<Character>?> getCharacters(int page) async {
    return _characterService.getCharacters(page);
  }
}