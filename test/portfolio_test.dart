import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kamlesh_portfolio/app/portfolio_app.dart';
import 'package:kamlesh_portfolio/app/portfolio_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> _settle(WidgetTester tester) async {
  // Entrance + reveal animations run on timers, so pump a fixed window
  // instead of waiting for everything to settle.
  await tester.pump();
  await tester.pump(const Duration(milliseconds: 1400));
}

Future<void> _settleTheme(WidgetTester tester) async {
  // The shadcn animated theme + our rebuild chain need several frames
  // to propagate a light <-> dark switch.
  for (var i = 0; i < 10; i++) {
    await tester.pump(const Duration(milliseconds: 300));
  }
}

void main() {
  setUpAll(() => SharedPreferences.setMockInitialValues({}));

  testWidgets('Portfolio renders every section', (WidgetTester tester) async {
    await tester.pumpWidget(const PortfolioApp());
    await _settle(tester);

    expect(find.text('Kamlesh Savale'), findsWidgets);
    expect(find.text("Hello, I'm"), findsOneWidget);
    expect(find.text('From blank file to working product.'), findsOneWidget);
    expect(find.text('What I work with.'), findsOneWidget);
    expect(find.text('Selected projects.'), findsOneWidget);
    expect(find.text('Get in touch.'), findsOneWidget);
    expect(find.text('Let’s build something together.'), findsOneWidget);
    expect(find.text('Connect on LinkedIn'), findsNothing);
    expect(find.text('LinkedIn'), findsOneWidget);
    expect(find.text('GitHub'), findsOneWidget);
    expect(find.text('kamlesh2112sawale@gmail.com'), findsOneWidget);
    expect(find.text('Made with'), findsOneWidget);
    expect(find.text('in Flutter'), findsOneWidget);
    expect(find.textContaining('©'), findsOneWidget);
  });

  testWidgets('Theme toggle switches to dark mode', (WidgetTester tester) async {
    await tester.pumpWidget(const PortfolioApp());
    await _settle(tester);

    Scaffold getScaffold() => tester.widget<Scaffold>(
          find.descendant(
              of: find.byType(PortfolioPage),
              matching: find.byType(Scaffold)));
    expect(getScaffold().backgroundColor, const Color(0xFFFFFFFF));

    await tester.tap(find.byTooltip('Switch to dark mode'));
    await _settleTheme(tester);
    expect(getScaffold().backgroundColor, const Color(0xFF000000));

    await tester.tap(find.byTooltip('Switch to light mode'));
    await _settleTheme(tester);
    expect(getScaffold().backgroundColor, const Color(0xFFFFFFFF));
  });

  testWidgets('No layout overflow across screen sizes',
      (WidgetTester tester) async {
    addTearDown(tester.view.reset);
    for (final size in const [
      Size(360, 740),
      Size(390, 844),
      Size(768, 1024),
      Size(1280, 800),
      Size(1920, 1080),
    ]) {
      tester.view.physicalSize = size;
      tester.view.devicePixelRatio = 1.0;
      await tester.pumpWidget(const PortfolioApp());
      await _settle(tester);
      // Any RenderFlex overflow surfaces here and fails the test.
      expect(tester.takeException(), isNull);
    }
  });
}
