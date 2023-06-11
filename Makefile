################################################################################################
## 環境変数 flavor
################################################################################################
LOCAL_FLAVOR := local
DEV_FLAVOR := dev
PROD_FLAVOR := prod

################################################################################################
## 基本コマンド
################################################################################################
.PHONY: help
help: ## Show this help
	@egrep -h '\s##\s' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-20s\033[0m %s\n", $$1, $$2}'

.PHONY: setup
setup: ## setup
	fvm install

.PHONY: activate_fvm
activate-fvm: ## activate_fvm
	dart pub global activate fvm

.PHONY: clean
clean: ## clean project
	fvm flutter clean
	cd ios; rm -rf Podfile.lock Pods
	fvm flutter pub get
	make pod-install

.PHONY: build-runner
build-runner: ## code generate
	fvm flutter packages pub run build_runner build --delete-conflicting-outputs

################################################################################################
## 実行・ビルド
################################################################################################
.PHONY: change-dev
change-dev:
	cd ios/Runner; rm -rf GoogleService-Info.plist
	flutterfire configure -p pocket-schedule-de -o lib/firebase_options_dev.dart
	fvm flutter clean

.PHONY: change-prod
change-prod:
	cd ios/Runner;rm -rf GoogleService-Info.plist
	flutterfire configure -p pocket-schedule-1dab1 -o lib/firebase_options_dev.dart
	fvm flutter clean

.PHONY: pod-install
pod-install:
	sudo arch -x86_64 gem install cocoapods
	sudo arch -x86_64 gem install ffi
	cd ios;arch -x86_64 pod install --repo-update

.PHONY: dev
prod:
	flutterfire configure --out=lib/environment/src/firebase_options_dev.dart --platforms=android,ios --ios-bundle-id=com.flutter.template.dev --android-package-name=com.flutter.template.dev

.PHONY: prod
prod:
	flutterfire configure --out=lib/environment/src/firebase_options_prod.dart --platforms=android,ios --ios-bundle-id=com.flutter.template --android-package-name=com.flutter.template

.PHONY: release-android
release-android:
	fvm flutter build appbundle --no-tree-shake-icons

.PHONY: release-ios
release-ios: ## clean project
	fvm flutter clean
	cd ios; rm -rf Podfile.lock Pods
	fvm flutter pub get
	make pod-install
	fvm flutter build ios --no-tree-shake-icons