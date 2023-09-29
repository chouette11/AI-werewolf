import 'package:ai_werewolf/util/environment/environment.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ai_werewolf/provider/audio_provider.dart';
import 'package:ai_werewolf/provider/domain_providers.dart';
import 'package:ai_werewolf/util/constant/color_constant.dart';
import 'package:ai_werewolf/util/environment/src/firebase_options_dev.dart';
import 'package:ai_werewolf/provider/domain_providers.dart';
import 'package:ai_werewolf/util/constant/color_constant.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  const flavorName = String.fromEnvironment('flavor');
  final flavor = Flavor.values.byName(flavorName);
  await Firebase.initializeApp(
    options: firebaseOptionsWithFlavor(flavor),
  );
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerStatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  ConsumerState<MyApp> createState() => _MyAppState();
}

class _MyAppState extends ConsumerState<MyApp> {

  @override
  void initState() {
    Future(() async {
      final cache = ref.read(audioCacheProvider);
      final path = await cache.load("audios/button7.mp3");
      final path2 = await cache.load("audios/button8.mp3");
      final path3 = await cache.load('audios/title.mp3');
      final path4 = await cache.load('audios/wait.mp3');
      ref.read(buttonSoundProvider.notifier).update((state) => path.path);
      ref.read(notSoundProvider.notifier).update((state) => path2.path);
      ref.read(titleSoundProvider.notifier).update((state) => path3.path);
      ref.read(waitSoundProvider.notifier).update((state) => path4.path);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
   final router = ref.watch(routerProvider);
    return MaterialApp.router(
      theme: ThemeData(
        primaryColor: ColorConstant.black100,
        fontFamily: 'NotoSans',
        dividerColor: Colors.transparent,
      ),
      debugShowCheckedModeBanner: false,
      routerConfig: router,
    );
  }
}
