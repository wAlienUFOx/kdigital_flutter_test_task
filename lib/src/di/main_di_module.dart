import 'package:kdigital_test/src/di/dependencies/repositoty_module.dart';
import 'package:kdigital_test/src/domain/repository/characters_repository.dart';
import 'package:get_it/get_it.dart';

class MainDIModule {
  void configure(GetIt getIt) {

    getIt.registerLazySingleton<CharactersRepository>(
        () => RepositoryModule.charactersRepository);
  }
}
