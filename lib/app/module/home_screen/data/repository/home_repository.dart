import 'package:github_trending/app/module/core/repository/ApiHelper.dart';
import 'package:github_trending/app/module/core/repository/base_repository.dart';
import 'package:github_trending/app/module/home_screen/data/model/top_user/top_user_response.dart';
import 'package:github_trending/app/module/home_screen/data/model/top_user/user_response.dart';

import '../model/top_repository/top_repository_response.dart';

class HomeRepository extends BaseRepository {
  Future<TopRepositoryResponse> getTopRepository() async {
    return callApiAndHandleErrors(
      () async {
        var response = await apiHelper.get(
          "/search/repositories?q=stars:>1000#",
        );

        return TopRepositoryResponse.fromJson(response.data);
      },
      (message, errorType) async {
        return TopRepositoryResponse.responseWithError(message, errorType);
      },
    );
  }

  Future<TopUserResponse> getTopUserByCountry({String? countryName}) async {
    return callApiAndHandleErrors(
      () async {
        var response = await apiHelper.get(
          "/search/users?q=location:$countryName+followers:>1000#",
        );

        return TopUserResponse.fromJson(response.data);
      },
      (message, errorType) async {
        return TopUserResponse.responseWithError(message, errorType);
      },
    );
  }

  Future<UserResponse> getTopUserDetails({String? userName}) async {
    return callApiAndHandleErrors(
      () async {
        var response = await apiHelper.get(
          "/users/$userName#",
        );

        return UserResponse.fromJson(response.data);
      },
      (message, errorType) async {
        return UserResponse.responseWithError(message, errorType);
      },
    );
  }
}
