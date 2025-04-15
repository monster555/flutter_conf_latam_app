import 'package:conf_ui_kit/conf_ui_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_conf_latam/agenda/agenda_page.dart';
import 'package:flutter_conf_latam/app/localizations_manager.dart';
import 'package:flutter_conf_latam/home/home_page.dart';
import 'package:flutter_conf_latam/l10n/l10n.dart';
import 'package:flutter_conf_latam/more/more_page.dart';
import 'package:flutter_conf_latam/speakers/speakers_page.dart';
import 'package:flutter_conf_latam/venue/venue_page.dart';

typedef TabItem =
    ({
      String label,
      String tooltip,
      Widget icon,
      Widget activeIcon,
      Widget screen,
    });

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> with SingleTickerProviderStateMixin {
  static const _fadeOutCurve = Curves.easeOut;
  static const _fadeInCurve = Curves.easeIn;

  int _currentIndex = 0;
  late final AnimationController _fadeController;
  Widget? _currentScreen;
  final Map<int, Widget> _screenCache = {};

  @override
  void initState() {
    super.initState();
    _fadeController = AnimationController(
      vsync: this,
      duration: UiConstants.animationXShort,
      value: 1,
    );
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    LocalizationsManager.updateWithContext(context);

    _currentScreen ??= _getScreen(_currentIndex);
  }

  @override
  void dispose() {
    _fadeController.dispose();
    super.dispose();
  }

  Widget _getScreen(int index) {
    if (_screenCache.containsKey(index)) {
      return _screenCache[index]!;
    }

    final tabs = _createTabs(context.l10n);
    final screen = tabs[index].screen;
    _screenCache[index] = screen;
    return screen;
  }

  Future<void> _setTabIndex(int index) async {
    if (index == _currentIndex) return;

    // Start animation immediately
    final fadeOutFuture = _fadeController.animateTo(0, curve: _fadeOutCurve);

    // Prepare the next screen before animation completes (optional pre-warming)
    final nextScreen = _getScreen(index);

    // Now wait for animation to complete
    await fadeOutFuture;

    setState(() {
      _currentIndex = index;
      _currentScreen = nextScreen;
    });

    await _fadeController.animateTo(1, curve: _fadeInCurve);
  }

  void _onNavigateToVenue() => _setTabIndex(3);

  List<TabItem> _createTabs(AppLocalizations l10n) {
    return [
      (
        label: l10n.homeTabLabel,
        tooltip: l10n.homeTabTooltip,
        icon: const Icon(Icons.home_outlined),
        activeIcon: const Icon(Icons.home),
        screen: Homepage(onNavigateToVenue: _onNavigateToVenue),
      ),
      (
        label: l10n.agendaTabLabel,
        tooltip: l10n.agendaTabTooltip,
        icon: const Icon(Icons.calendar_today_outlined),
        activeIcon: const Icon(Icons.calendar_month),
        screen: const AgendaPage(),
      ),
      (
        label: l10n.speakersTabLabel,
        tooltip: l10n.speakersTabTooltip,
        icon: const Icon(Icons.people_outline),
        activeIcon: const Icon(Icons.people),
        screen: const SpeakersPage(),
      ),
      (
        label: l10n.venueTabLabel,
        tooltip: l10n.venueTabTooltip,
        icon: const Icon(Icons.location_on_outlined),
        activeIcon: const Icon(Icons.location_on),
        screen: const VenuePage(),
      ),
      (
        label: l10n.moreTabLabel,
        tooltip: l10n.moreTabTooltip,
        icon: const Icon(Icons.info_outline),
        activeIcon: const Icon(Icons.info),
        screen: const MorePage(),
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    final tabs = _createTabs(l10n);
    final currentTabName = tabs[_currentIndex].label;

    return Scaffold(
      appBar: MainAppBar(
        profileLabel: l10n.userProfileLabel,
        profileHint: l10n.userProfileHint,
        profileTooltip: l10n.userProfileTooltip,
      ),
      extendBody: true,
      extendBodyBehindAppBar: true,
      body: Semantics(
        label: currentTabName,
        liveRegion: true,
        explicitChildNodes: true,
        child: FadeTransition(opacity: _fadeController, child: _currentScreen),
      ),
      bottomNavigationBar: ConferenceBottomNavigationBar(
        currentIndex: _currentIndex,
        onTabSelected: _setTabIndex,
        semanticsLabel: l10n.navigationBarLabel,
        itemsBuilder:
            (context) =>
                tabs
                    .map(
                      (tab) => BottomNavigationBarItem(
                        tooltip: tab.tooltip,
                        icon: tab.icon,
                        activeIcon: tab.activeIcon,
                        label: tab.label,
                      ),
                    )
                    .toList(),
      ),
    );
  }
}
