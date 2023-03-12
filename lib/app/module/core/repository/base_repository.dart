import 'package:github_trending/app/module/core/network/dio_provider.dart';
import 'package:github_trending/app/module/core/repository/ApiHelper.dart';

abstract class BaseRepository {
  final apiHelper = ApiBaseHelper(
    'https://api.github.com',
    httpDio(),
  );
}
