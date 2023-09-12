import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wordwolf/provider/audio_provider.dart';
import 'package:wordwolf/provider/domain_providers.dart';
import 'package:wordwolf/util/constant/color_constant.dart';
import 'package:wordwolf/util/environment/src/firebase_options_dev.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
   await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
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
      ref.read(buttonSoundProvider.notifier).update((state) => path.path);
      ref.read(notSoundProvider.notifier).update((state) => path2.path);
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
