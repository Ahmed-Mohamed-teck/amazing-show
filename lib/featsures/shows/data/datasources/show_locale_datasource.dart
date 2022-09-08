import 'package:amazing_tv/core/error/exception.dart';

import '../../../../core/resources/constants_manager.dart';
import '../../../../core/util/local_storage.dart';
import '../../domain/usecases/get_is_favourites.dart';
import '../../domain/usecases/get_toggle_favourites.dart';
import '../models/show_model.dart';

abstract class ShowLocaleDataSource {
  /// get all the Favourites from db
  Future<List<ShowModel?>> getAllFavourites();

  Future<void> saveFavourites();

  Future<List<ShowModel?>> toggleFavourites(ToggleFavouritesParameters parameters);

  Future<bool> isFavourites(IsFavouritesParameters parameters);
}

class ShowLocaleDataSourceImpl implements ShowLocaleDataSource {
  var _favList = <ShowModel?>[];
  final _storage = LocalStorageService();

  List<ShowModel?> get favList => _favList;

  @override
  Future<List<ShowModel?>> getAllFavourites() async {
    final list = await _storage.getFromLocal(LocalStorageKey.favouritesKey);
    if (list != null) {
      _favList = List.from(
        (list as List).map((i) => ShowModel.fromJson(i)),
      );
      return favList;
    }
    throw OfflineException();
  }

  @override
  Future<void> saveFavourites() async {
    await _storage.saveToLocal(
      LocalStorageKey.favouritesKey,
      favList.map((i) => i?.toJson()).toList(),
    );
  }

  @override
  Future<List<ShowModel?>> toggleFavourites(ToggleFavouritesParameters parameters) async {
    try {
      var item = _favList.firstWhere((element) => element!.id == parameters.favProduct.id,
          orElse: () => null);

      if (item != null) {
        _favList.removeWhere((i) => i!.id == parameters.favProduct.id);
      } else {
        _favList.add(ShowModel.fromJson(ShowModel().toJsonShow(parameters.favProduct)));
      }
      await saveFavourites();
      await getAllFavourites();
      return favList;
    } catch (e) {
      throw OfflineException();
    }
  }

  @override
  Future<bool> isFavourites(IsFavouritesParameters parameters) async {
    try {
      var item = _favList.firstWhere((element) => element!.id == parameters.favProduct.id,
          orElse: () => null);
      return (item != null);
    } catch (e) {
      throw OfflineException();
    }
  }
}
