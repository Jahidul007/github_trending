import 'package:github_trending/app/module/core/controller/base_controller.dart';
import 'package:github_trending/app/module/core/model/base_response.dart';
import 'package:github_trending/app/module/home_screen/data/model/top_user/user_response.dart';
import 'package:github_trending/app/module/home_screen/data/repository/home_repository.dart';
import 'package:rxdart/rxdart.dart';

class TopUserDetailsController extends BaseController {
  final _topUserDetailsController = BehaviorSubject<UserResponse?>();

  Stream<UserResponse?> get userDetailsStream =>
      _topUserDetailsController.stream;

  final HomeRepository homeRepository = HomeRepository();

  getUserDetails({required String userName}) async {
    showLoadingState();
    var baseResponse =
        await homeRepository.getTopUserDetails(userName: userName);
    handleApiCall(baseResponse, onSuccess: _handleSuccessResponse);
  }

  _handleSuccessResponse(BaseResponse baseResponse) {
    showSuccessState();

    UserResponse response = baseResponse as UserResponse;

    if (response.isSuccess) {
      _topUserDetailsController.sink.add(response);
    }
  }

  @override
  void dispose() {
    _topUserDetailsController.close();
    super.dispose();
  }
}
