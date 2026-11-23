import 'package:flutter/material.dart';

import 'app.dart';
import 'state/sinalmundo_controller.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(SinalMundoApp(controller: SinalMundoController()));
}
