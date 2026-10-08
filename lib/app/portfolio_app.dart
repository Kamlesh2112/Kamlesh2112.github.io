import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../design/palette.dart';
import '../design/type.dart';
import 'portfolio_page.dart';

void main() {
  runApp(const PortfolioApp());
}

class PortfolioApp extends StatefulWidget {
  const PortfolioApp({super.key});

  @override
  State<PortfolioApp> createState() => _PortfolioAppState();
}

class _PortfolioAppState extends State<PortfolioApp> {
  static const _prefKey = 'kamlesh_portfolio_dark';
  bool? _overrideDark;

  @override
  void initState() {
    super.initState();
    _restore();
  }

  Future<void> _restore() async {
    final prefs = await SharedPreferences.getInstance();
    if (!mounted) return;
    final saved = prefs.getBool(_prefKey);
    if (saved != null) setState(() => _overrideDark = saved);
  }

  bool get _isDark =>
      _overrideDark ??
      WidgetsBinding.instance.platformDispatcher.platformBrightness ==
          Brightness.dark;

  Future<void> _toggleTheme() async {
    final next = !_isDark;
    setState(() => _overrideDark = next);
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_prefKey, next);
  }

  @override
  Widget build(BuildContext context) {
    final mode = _overrideDark == null
        ? ThemeMode.system
        : (_overrideDark! ? ThemeMode.dark : ThemeMode.light);
    return ShadApp.custom(
      themeMode: mode,
      theme: ShadThemeData(
        brightness: Brightness.light,
        colorScheme: const ShadBlueColorScheme.light(),
      ),
      darkTheme: ShadThemeData(
        brightness: Brightness.dark,
        colorScheme: const ShadBlueColorScheme.dark(),
      ),
      appBuilder: (context) {
        // Listen to the shadcn theme so this subtree rebuilds while it
        // animates (e.g. light <-> dark) instead of freezing the first
        // frame's theme into MaterialApp.
        return Builder(
          builder: (context) {
            ShadTheme.of(context);
            final pal = Palette.of(context);
            return MaterialApp(
              title: 'Kamlesh Savale — Full-Stack Developer',
              debugShowCheckedModeBanner: false,
              theme: Type.merge(Theme.of(context), pal),
              localizationsDelegates: const [
                GlobalShadLocalizations.delegate,
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
              ],
              builder: (context, child) => ShadAppBuilder(child: child!),
              home: PortfolioPage(
                isDark: pal.isDark,
                onToggleTheme: _toggleTheme,
              ),
            );
          },
        );
      },
    );
  }
}
