import 'package:envied/envied.dart';

part 'env.g.dart';

@Envied(path: '.env')
final class Env {
  @EnviedField(varName: 'API_KEY')
  static const String apiKey = _Env.apiKey;
  static const String apiKey2 = _Env.apiKey2;
  static const String apiGemini = _Env.apiGemini;
}
