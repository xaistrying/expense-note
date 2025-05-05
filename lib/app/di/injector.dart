import 'package:expense_note/app/service/app_prefs_service_helper.dart';
import 'package:get_it/get_it.dart';

import '../../data/datasource/local/list_card_local_datasource.dart';

final getIt = GetIt.instance;

Future<void> initDependencies() async {
  // Datasource //
  getIt.registerLazySingleton<ListCardLocalDatasource>(
    () => ListCardLocalDatasourceImpl(),
  );

  // Service //
  getIt.registerLazySingleton<AppPrefsServiceHelper>(
    () => AppPrefsServiceHelper(),
  );
}
