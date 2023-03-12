import 'package:github_trending/app/module/core/controller/base_controller.dart';
import 'package:github_trending/app/module/core/model/base_response.dart';
import 'package:github_trending/app/module/home_screen/data/model/top_repository/top_repository_response.dart';
import 'package:github_trending/app/module/home_screen/data/repository/home_repository.dart';
import 'package:rxdart/rxdart.dart';

mixin TopRepositoriesController on BaseController {
  final BehaviorSubject<TopRepositoryResponse?> _topRepositoryController =
  BehaviorSubject<TopRepositoryResponse?>();

  Stream<TopRepositoryResponse?> get topRepositoriesStream =>
      _topRepositoryController.stream;

  final HomeRepository homeRepository = HomeRepository();

  void getTopRepositories() async {
    showLoadingState();
    var _topRepositories = await homeRepository.getTopRepository();
    handleApiCall(_topRepositories, onSuccess: _onTopRepositoriesSuccess);
  }

  _onTopRepositoriesSuccess(BaseResponse baseResponse) {
    showSuccessState();
    TopRepositoryResponse topRepositories =
    baseResponse as TopRepositoryResponse;

    if (topRepositories.isSuccess) {
      _topRepositoryController.sink.add(topRepositories);
    }
  }

  @override
  void dispose() {
    _topRepositoryController.close();
    super.dispose();
  }
}
