/// Exporta a implementação Web e o fallback para outras plataformas.
export 'vlibras_demo_launcher_stub.dart'
    if (dart.library.html) 'vlibras_demo_launcher_web.dart';
