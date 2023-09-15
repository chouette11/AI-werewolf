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
	cd ios;arch -x86_64 pod install

.PHONY: dev
dev: 
	flutterfire configure --project=wordwolf-1f53d --out=lib/util/environment/src/firebase_options_dev.dart --platforms=android,ios,web --ios-bundle-id=com.AI.werewolf.dev --android-package-name=com.AI.werewolf.dev

.PHONY: prod
prod:
	flutterfire configure --project=ai-werewolf --out=lib/util/environment/src/firebase_options_prod.dart --platforms=android,ios,web --ios-bundle-id=com.AI.werewolf --android-package-name=com.AI.werewolf

.PHONY: web-dev
web-dev:
	fvm flutter clean
	fvm flutter build web --no-tree-shake-icons --dart-define-from-file=dart_defines/dev.json
	cd build/web;echo "google.com, pub-3443545166967285, DIRECT, f08c47fec0942fa0" > ads.txt
	sed -i '' '3d' firebase.json
	ex -s -c '2a|"site": "ai-werewolf-dev",' -c 'x' firebase.json
	firebase deploy --only hosting:ai-werewolf-dev

.PHONY: web-prod
web-prod:
	fvm flutter clean
	fvm flutter build web --no-tree-shake-icons --dart-define-from-file=dart_defines/prod.json
	cd build/web;echo "google.com, pub-3443545166967285, DIRECT, f08c47fec0942fa0" > ads.txt
	sed -i '' '3d' firebase.json
	ex -s -c '2a|"site": "ai-werewolf",' -c 'x' firebase.json
	cd web-prod;firebase deploy

.PHONY: release-android
release-android:
	fvm flutter build appbundle --release --no-tree-shake-icons

.PHONY: release-ios
release-ios: ## clean project
	fvm flutter clean
	cd ios; rm -rf Podfile.lock Pods
	fvm flutter pub get
	make pod-install
	fvm flutter build ios --no-tree-shake-icons --dart-define-from-file=dart_defines/prod.json