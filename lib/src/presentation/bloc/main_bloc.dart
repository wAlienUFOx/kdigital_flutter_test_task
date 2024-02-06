import 'package:kdigital_test/src/domain/repository/characters_repository.dart';
import 'package:kdigital_test/src/presentation/bloc/main_event.dart';
import 'package:kdigital_test/src/presentation/bloc/main_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MainPageBloc
    extends Bloc<MainPageEvent, MainPageState> {
  final CharactersRepository _charactersRepository;
  int pageIndex = 1;

  MainPageBloc(
    MainPageState initialState,
    this._charactersRepository,
  ) : super(initialState) {
    on<DataLoadedOnMainPageEvent>(
      (event, emitter) => _dataLoadedOnMainPageCasino(event, emitter),
    );
    on<LoadingDataOnMainPageEvent>(
      (event, emitter) {
        emitter(LoadingMainPageState());
        _getDataOnMainPageCasino(emitter);
      },
    );
    on<LoadingNextDataOnMainPageEvent>(
          (event, emitter) {
            if (pageIndex < 42) {
              pageIndex++;
              emitter(LoadingNextMainPageState());
              _getDataOnMainPageCasino(emitter);
            }
          },
    );
  }

  Future<void> _dataLoadedOnMainPageCasino(
    DataLoadedOnMainPageEvent event,
    Emitter<MainPageState> emit,
  ) async {
    if (event.characters != null) {
      emit(SuccessfulMainPageState(event.characters!));
    } else {
      if (pageIndex == 1) {
        emit(UnSuccessfulMainPageState());
      } else {
        emit(UnSuccessfulNextMainPageState());
      }
      _getDataOnMainPageCasino(emit);
    }
  }

  Future<void> _getDataOnMainPageCasino(
    Emitter<MainPageState> emit,
  ) async {
    _charactersRepository.getCharacters(pageIndex).then(
      (value) {
        add(DataLoadedOnMainPageEvent(value));
      },
    );
  }
}
