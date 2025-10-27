import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

import 'package:taskflow_mini/core/di/injection.dart';
import 'package:taskflow_mini/core/router/router.dart';
import 'package:taskflow_mini/core/theme/theme_controller.dart';

import 'package:taskflow_mini/presentation/viewmodels/project/bloc/project_bloc.dart';
import 'package:taskflow_mini/presentation/viewmodels/subtasks/bloc/bloc/subtasks_bloc.dart';
import 'package:taskflow_mini/presentation/viewmodels/tasks/bloc/task_bloc.dart';
import 'package:taskflow_mini/presentation/viewmodels/tasks/provider/task_controller.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initDependencies();
  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle(statusBarColor: Colors.transparent),
  );
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => sl<ProjectBloc>()..add(FetchProjects())),
        BlocProvider(create: (_) => sl<TaskBloc>()),
        BlocProvider(create: (_) => sl<SubtasksBloc>()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => TaskFormProvider()),
        ChangeNotifierProvider(create: (context) => ThemeNotifier()),
      ],
      child: Builder(
        builder: (context) {
          final themeNotifier = Provider.of<ThemeNotifier>(context);
          return MaterialApp.router(
            debugShowCheckedModeBanner: false,
            theme: themeNotifier.currentTheme,
            routerConfig: appRouter,
          );
        },
      ),
    );
  }
}
