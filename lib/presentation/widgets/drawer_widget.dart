import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/theme/theme_controller.dart';
import '../viewmodels/project/bloc/project_bloc.dart';

class DrawerWidget extends StatelessWidget {
  const DrawerWidget({super.key});
  @override
  Widget build(BuildContext context) {
    final themeNotifier = Provider.of<ThemeNotifier>(context);

    return Container(
      color: Theme.of(context).scaffoldBackgroundColor,
      width: MediaQuery.sizeOf(context).width * 0.5,
      child: Padding(
        padding: EdgeInsets.only(top: MediaQuery.of(context).viewPadding.top),
        child: Column(
          spacing: 10,
          children: [
            SizedBox(height: 20),
            Text("Theme"),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: ToggleButtons(
                borderRadius: BorderRadius.circular(8),
                isSelected: [!themeNotifier.isDark, themeNotifier.isDark],
                onPressed: (index) {
                  final newIsDark = index == 1;
                  if (newIsDark != themeNotifier.isDark) {
                    themeNotifier.toggleTheme();
                  }
                },
                children: const [Icon(Icons.light_mode), Icon(Icons.dark_mode)],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
