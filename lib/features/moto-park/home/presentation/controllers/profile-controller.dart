import 'package:get/get.dart';
import 'package:parkingandroid/core/utilities/snackbar-utility.dart';
import 'package:parkingandroid/features/moto-park/home/domain/models/profile-model.dart';
import 'package:parkingandroid/features/moto-park/home/domain/use-cases/profile-information-case.dart';

class ProfileController extends GetxController {
  final ProfileInformationCase profileInformationCase;

  ProfileController({required this.profileInformationCase});

  bool loading = true;
  ProfileModel? information;

  @override
  void onReady() {
    getProfileInformation();
    super.onReady();
  }

  void getProfileInformation() async {
    var response =
        await profileInformationCase(params: ProfileInformationCaseParams());

    response.fold((failure) {
      SnackbarUtility.showSnackbar(message: failure.message);
    }, (success) {
      information = success;
      loading = false;
      update();
    });
  }
}
