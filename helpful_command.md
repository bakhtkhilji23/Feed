<!-- Change Package Name Android Command -->
flutter pub run change_app_package_name:main com.new.package.name

<!-- Change Splash Screen -->
flutter pub run flutter_native_splash:create

<!-- BUILD APK FOR TEST -->
flutter build apk --split-per-abi --obfuscate --split-debug-info=./private/data/

<!-- BUILD APPBUNDLE FOR RELEASE -->
flutter build appbundle --obfuscate --split-debug-info=./private/data/
