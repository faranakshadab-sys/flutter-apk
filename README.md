# Parkingplus • Android Application

### SDK Versions

dart sdk: ``` 3.0.2 • stable ```
flutter sdk: ``` 3.10.2 • stable ```

### pubspec content:

```yaml
some:
name: parkingandroid
description: Parking Plus Android Project.
publish_to: "none"
version: 1.0.0+1
environment:
	sdk: ">=2.19.0 <3.0.0"
dependencies:
flutter:
	sdk: flutter
cupertino_icons: ^1.0.2
get: ^4.6.5
flutter_feather_icons: ^2.0.0+1
flutter_svg: ^2.0.1
shamsi_date: ^1.0.1
camera: ^0.10.4+1
permission_handler: ^10.2.0
cached_network_image: ^3.2.3
skeletons: ^0.0.3
carousel_slider: ^4.2.1
pinch_zoom: ^1.0.0
dio: ^5.0.1
dartz: ^0.10.1
equatable: ^2.0.5
connectivity_plus: any
image: ^3.0.1
shared_preferences: any
ffi: any
lottie: ^2.2.0
qr_code_scanner: ^1.0.1
qr_flutter: ^4.0.0
geolocator: ^9.0.2
photo_view: ^0.14.0

dependency_overrides:
camera: ^0.10.4
xml: any
crypto: any
analyzer: any
archive: any

dev_dependencies:
build_runner: ^2.3.3
flutter_test:
sdk: flutter
json_serializable: any

flutter:
	uses-material-design: true

assets:
	assets/images/
	assets/icons/
	assets/animations/

fonts:
	family: IranSans

fonts:
	asset: assets/fonts/IranSans.ttf
```