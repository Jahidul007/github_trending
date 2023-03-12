import 'package:github_trending/app/module/core/controller/base_controller.dart';
import 'package:github_trending/app/module/core/model/base_response.dart';
import 'package:github_trending/app/module/home_screen/data/model/top_user/top_user_response.dart';
import 'package:github_trending/app/module/home_screen/data/repository/home_repository.dart';
import 'package:rxdart/rxdart.dart';

mixin TopUserController on BaseController {
  final BehaviorSubject<TopUserResponse?> _topUserController =
      BehaviorSubject<TopUserResponse?>();

  Stream<TopUserResponse?> get topUsersStream => _topUserController.stream;

  final BehaviorSubject<String?> _selectedCountryController =
      BehaviorSubject<String?>.seeded('bangladesh');

  Stream<String?> get selectedCountryStream =>
      _selectedCountryController.stream;

  final HomeRepository homeRepository = HomeRepository();

  void getTopUsers() async {
    showLoadingState();
    var _topRepositories = await homeRepository.getTopUserByCountry(
        countryName: _selectedCountryController.value);
    handleApiCall(_topRepositories, onSuccess: _onTopRepositoriesSuccess);
  }

  _onTopRepositoriesSuccess(BaseResponse baseResponse) {
    showSuccessState();
    TopUserResponse topUserResponse = baseResponse as TopUserResponse;

    if (topUserResponse.isSuccess) {
      _topUserController.sink.add(topUserResponse);
    }
  }

  String? selectedCountryName = 'Bangladesh';

  updateCountry(String countryName) {
    selectedCountryName = countryName;
    _selectedCountryController.sink.add(countryName);
  }

  resetAll() {
  //  _selectedCountryController.add(null);
    //selectedCountryName = null;
  }

  bool checkCountryInput() {
    bool okay = true;
    if (_selectedCountryController.hasValue) {
      if (_selectedCountryController.value!=null) {
        _selectedCountryController.value;
      } else {
        okay = false;
      }
    } else {
      okay = false;
    }
    return okay;
  }

  @override
  void dispose() {
    _topUserController.close();
    super.dispose();
  }
}
