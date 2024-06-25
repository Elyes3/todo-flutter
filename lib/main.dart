import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todoflutter/home/home_page.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:todoflutter/todos/todos_page.dart';
import 'package:todoflutter/todos/todos_service.dart';

void main() async {
  await dotenv.load(fileName: '.env');
  runApp(ModularApp(
      module: AppModule(), child: const ProviderScope(child: MyApp())));
}

class AppModule extends Module {
  @override
  void binds(i) {
   i.addSingleton(TodosService.new); 
  }
  @override
  void routes(r) {
    r.child('/', child: (_) => const HomePage());
    r.child('/todos/:millis',
        child: (_) => TodosPage(millis: int.parse(r.args.params['millis'])));
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Todo Flutter',
      debugShowCheckedModeBanner: false,
      routerConfig: Modular.routerConfig,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
    );
  }
}
