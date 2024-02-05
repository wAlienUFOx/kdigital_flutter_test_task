import 'package:kdigital_test/src/data/repository/characters_repository_impl.dart';
import 'package:kdigital_test/src/di/dependencies/api_module.dart';

import '../../domain/repository/characters_repository.dart';

class RepositoryModule {
  static CharactersRepository _charactersRepository = CharactersRepositoryImpl(ApiModule.apiUtil);

  static CharactersRepository get charactersRepository => _charactersRepository;
}