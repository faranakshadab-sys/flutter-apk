import 'package:get/get.dart';
import 'package:parkingandroid/features/common/presentation/pages/test-page.dart';
import 'package:parkingandroid/features/common/presentation/pages/welcome-page.dart';
import 'package:parkingandroid/features/moto-park/common/presentation/bindings/app-moto-park-bindings.dart';
import 'package:parkingandroid/features/moto-park/common/presentation/pages/drawer-wrapper-page.dart';
import 'package:parkingandroid/features/parking/common/presentation/bindings/app-parking-bindings.dart';
import 'package:parkingandroid/features/parking/common/presentation/pages/drawer-wrapper-page.dart';

getRoutes() => [
      GetPage(
        name: '/welcome',
        page: () => WelcomePage(),
        transition: Transition.cupertino,
        transitionDuration: Duration(milliseconds: 500),
      ),
      GetPage(
          name: '/parking',
          page: () => ParkingDrawerWrapperPage(),
          transition: Transition.cupertino,
          transitionDuration: Duration(milliseconds: 500),
          binding: AppParkingBindings()),
      GetPage(
          name: '/moto-park',
          page: () => MotoParkDrawerWrapperPage(),
          transition: Transition.cupertino,
          transitionDuration: Duration(milliseconds: 500),
          binding: AppMotoParkBindings()),
      GetPage(
        name: '/test',
        page: () => TestPage(),
        transition: Transition.cupertino,
        transitionDuration: Duration(milliseconds: 500),
      ),
    ];

class MyMiddelware extends GetMiddleware {
  @override
  GetPage? onPageCalled(GetPage? page) {
    return super.onPageCalled(page);
  }
}
