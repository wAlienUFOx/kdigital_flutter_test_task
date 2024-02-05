import 'package:kdigital_test/src/data/api/api_util.dart';
import 'package:kdigital_test/src/data/api/service/character_service.dart';

class ApiModule {
  static ApiUtil _apiUtil = ApiUtil(CharacterService());

  static ApiUtil get apiUtil => _apiUtil;
}