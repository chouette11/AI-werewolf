import 'package:audioplayers/audioplayers.dart';
import 'package:riverpod/riverpod.dart';

final audioProvider = Provider((_) => AudioPlayer());

final audioCacheProvider = Provider((_) => AudioCache());

final buttonSoundProvider = StateProvider<String>((ref) => '');

final notSoundProvider = StateProvider((ref) => '');
