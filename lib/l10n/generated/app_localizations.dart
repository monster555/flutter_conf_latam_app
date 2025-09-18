import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_es.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'generated/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('es'),
  ];

  /// The title of the application
  ///
  /// In en, this message translates to:
  /// **'FlutterConf LATAM'**
  String get appTitle;

  /// Accessibility label for the bottom navigation bar
  ///
  /// In en, this message translates to:
  /// **'Navigation'**
  String get navigationBarLabel;

  /// Label for the home tab in the bottom navigation bar
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get homeTabLabel;

  /// Label for the agenda tab
  ///
  /// In en, this message translates to:
  /// **'Agenda'**
  String get agendaTabLabel;

  /// Label for the speakers tab
  ///
  /// In en, this message translates to:
  /// **'Speakers'**
  String get speakersTabLabel;

  /// Label for the sponsors tab
  ///
  /// In en, this message translates to:
  /// **'Sponsors'**
  String get sponsorsTabLabel;

  /// Label for the venue tab
  ///
  /// In en, this message translates to:
  /// **'Venue'**
  String get venueTabLabel;

  /// Label for the profile/more tab in navigation bar
  ///
  /// In en, this message translates to:
  /// **'More'**
  String get moreTabLabel;

  /// Tooltip for the more tab in navigation bar
  ///
  /// In en, this message translates to:
  /// **'Conference information and tips'**
  String get moreTabTooltip;

  /// Title shown above the venue banner
  ///
  /// In en, this message translates to:
  /// **'Next stop'**
  String get venueBannerTitle;

  /// Accessibility label for venue banner
  ///
  /// In en, this message translates to:
  /// **'Conference venue information'**
  String get venueBannerSemanticsLabel;

  /// Accessibility hint for venue banner
  ///
  /// In en, this message translates to:
  /// **'Tap to see venue details'**
  String get venueBannerSemanticsHint;

  /// Semantic label for speaker card accessibility
  ///
  /// In en, this message translates to:
  /// **'{name}, {title}, tap to view details'**
  String speakerCardSemanticLabel(String name, String title);

  /// Label for a speaker
  ///
  /// In en, this message translates to:
  /// **'Speaker'**
  String get speaker;

  /// Label for the Co-speakers
  ///
  /// In en, this message translates to:
  /// **'Co-speakers'**
  String get coSpeakersLabel;

  /// Title shown above the countdown timer
  ///
  /// In en, this message translates to:
  /// **'The magic begins in'**
  String get magicBeginsLabel;

  /// Plural label for days in countdown
  ///
  /// In en, this message translates to:
  /// **'days'**
  String get days;

  /// Plural label for hours in countdown
  ///
  /// In en, this message translates to:
  /// **'hours'**
  String get hours;

  /// Plural label for minutes in countdown
  ///
  /// In en, this message translates to:
  /// **'minutes'**
  String get minutes;

  /// Plural label for seconds in countdown
  ///
  /// In en, this message translates to:
  /// **'seconds'**
  String get seconds;

  /// Tooltip for the home tab in navigation bar
  ///
  /// In en, this message translates to:
  /// **'Home screen with event overview'**
  String get homeTabTooltip;

  /// Tooltip for the agenda tab in navigation bar
  ///
  /// In en, this message translates to:
  /// **'Conference schedule by day and time'**
  String get agendaTabTooltip;

  /// Tooltip for the speakers tab in navigation bar
  ///
  /// In en, this message translates to:
  /// **'Conference speakers and presentations'**
  String get speakersTabTooltip;

  /// Tooltip for the venue tab in navigation bar
  ///
  /// In en, this message translates to:
  /// **'Venue information and location'**
  String get venueTabTooltip;

  /// The dates of the conference (formatted for display in venue banner)
  ///
  /// In en, this message translates to:
  /// **'September {startDay} - {endDay}'**
  String conferenceDates(int startDay, int endDay);

  /// Basic difficulty level for conference sessions
  ///
  /// In en, this message translates to:
  /// **'Basic'**
  String get sessionLevelBasic;

  /// Intermediate difficulty level for conference sessions
  ///
  /// In en, this message translates to:
  /// **'Intermediate'**
  String get sessionLevelIntermediate;

  /// Advanced difficulty level for conference sessions
  ///
  /// In en, this message translates to:
  /// **'Advanced'**
  String get sessionLevelAdvanced;

  /// Expert difficulty level for conference sessions
  ///
  /// In en, this message translates to:
  /// **'Expert'**
  String get sessionLevelExpert;

  /// Universal label that works for all session types
  ///
  /// In en, this message translates to:
  /// **'Description'**
  String get sessionDescriptionLabel;

  /// Message displayed when no session data is available
  ///
  /// In en, this message translates to:
  /// **'No session data available'**
  String get sessionNoDataAvailable;

  /// Accessibility label for session details screen
  ///
  /// In en, this message translates to:
  /// **'Session details for: {title}'**
  String sessionDetailsSemanticLabel(String title);

  /// Tooltip for the favorite button on session details
  ///
  /// In en, this message translates to:
  /// **'Add to favorites'**
  String get sessionFavoriteTooltip;

  /// Tooltip for the share button on session details
  ///
  /// In en, this message translates to:
  /// **'Share this session'**
  String get sessionShareTooltip;

  /// Header for sessions on a specific date
  ///
  /// In en, this message translates to:
  /// **'Sessions for {date}'**
  String sessionsForDate(String date);

  /// Hint for interacting with session cards
  ///
  /// In en, this message translates to:
  /// **'Tap to view session details'**
  String get sessionCardHint;

  /// Button to open maps application with directions to venue
  ///
  /// In en, this message translates to:
  /// **'Get Directions'**
  String get actionGetDirections;

  /// Title for venue information section
  ///
  /// In en, this message translates to:
  /// **'Venue Information'**
  String get sectionTitleVenue;

  /// Title for venue accessibility section
  ///
  /// In en, this message translates to:
  /// **'Accessibility'**
  String get sectionTitleAccessibility;

  /// Error message when maps app cannot be opened
  ///
  /// In en, this message translates to:
  /// **'Unable to open maps application'**
  String get errorMapsOpen;

  /// Title for campus facilities section
  ///
  /// In en, this message translates to:
  /// **'Campus Facilities'**
  String get facilitiesCampusTitle;

  /// Description of venue campus facilities
  ///
  /// In en, this message translates to:
  /// **'The venue offers modern classrooms, auditoriums, and networking spaces equipped with high-speed WiFi throughout the campus.'**
  String get facilitiesCampusDescription;

  /// Title for food and refreshments section
  ///
  /// In en, this message translates to:
  /// **'Food & Refreshments'**
  String get facilitiesFoodTitle;

  /// Description of food options at venue
  ///
  /// In en, this message translates to:
  /// **'Several cafeterias and food options are available on campus, with special menus prepared for conference attendees.'**
  String get facilitiesFoodDescription;

  /// Title for getting around section
  ///
  /// In en, this message translates to:
  /// **'Getting Around'**
  String get navigatingCampusTitle;

  /// Description of how to navigate the venue
  ///
  /// In en, this message translates to:
  /// **'The campus is easy to navigate with clear signage. Event staff in Flutter blue shirts will be available to help with directions.'**
  String get navigatingCampusDescription;

  /// Description of venue accessibility features
  ///
  /// In en, this message translates to:
  /// **'The venue is fully accessible with ramps, elevators, and accessible restrooms. Contact the organizers if you need any special accommodations.'**
  String get accessibilityDescription;

  /// The capacity of the venue
  ///
  /// In en, this message translates to:
  /// **'Capacity: {capacity} people'**
  String venueCapacity(String capacity);

  /// Accessibility description of the venue image
  ///
  /// In en, this message translates to:
  /// **'Image of Universidad de las Américas campus'**
  String get imageVenueDescription;

  /// Title for the safety tips section
  ///
  /// In en, this message translates to:
  /// **'Safety Tips'**
  String get sectionTitleSafety;

  /// Title for the transportation section
  ///
  /// In en, this message translates to:
  /// **'Transportation'**
  String get sectionTitleTransportation;

  /// Title for the food section
  ///
  /// In en, this message translates to:
  /// **'Food'**
  String get sectionTitleFood;

  /// Title for the money section
  ///
  /// In en, this message translates to:
  /// **'Money'**
  String get sectionTitleMoney;

  /// Title for the weather section
  ///
  /// In en, this message translates to:
  /// **'Weather'**
  String get sectionTitleWeather;

  /// Title for safety precautions tip
  ///
  /// In en, this message translates to:
  /// **'Safety Precautions'**
  String get safetyPrecautionsTipTitle;

  /// Description for safety precautions tip
  ///
  /// In en, this message translates to:
  /// **'Avoid carrying large amounts of cash, and keep valuables secure in crowded areas.'**
  String get safetyPrecautionsTipDescription;

  /// Title for emergency contacts tip
  ///
  /// In en, this message translates to:
  /// **'Emergency Contacts'**
  String get emergencyContactsTipTitle;

  /// Description for emergency contacts tip
  ///
  /// In en, this message translates to:
  /// **'Dial 911 for police, ambulance, or fire services. For tourist assistance, call +593-123-HELP.'**
  String get emergencyContactsTipDescription;

  /// Title for taxis tip
  ///
  /// In en, this message translates to:
  /// **'Taxis and Rideshares'**
  String get taxisTipTitle;

  /// Description for taxis tip
  ///
  /// In en, this message translates to:
  /// **'Use authorized taxis or apps like Uber and Cabify. Avoid hailing unregistered taxis.'**
  String get taxisTipDescription;

  /// Title for delivery apps tip
  ///
  /// In en, this message translates to:
  /// **'Delivery Apps'**
  String get deliveryAppsTipTitle;

  /// Description for delivery apps tip
  ///
  /// In en, this message translates to:
  /// **'Popular options include Rappi and Uber Eats for fast and reliable service.'**
  String get deliveryAppsTipDescription;

  /// Title for local restaurants tip
  ///
  /// In en, this message translates to:
  /// **'Local Restaurants'**
  String get localRestaurantsTipTitle;

  /// Description for local restaurants tip
  ///
  /// In en, this message translates to:
  /// **'Taste Ecuadorian favorites like \"locro\" or \"ceviche\" at nearby restaurants like Café Quito.'**
  String get localRestaurantsTipDescription;

  /// Title for currency tip
  ///
  /// In en, this message translates to:
  /// **'Currency and Payments'**
  String get currencyTipTitle;

  /// Description for currency tip
  ///
  /// In en, this message translates to:
  /// **'US dollars are used in Ecuador. Credit cards are widely accepted, but keep small bills for taxis or street vendors.'**
  String get currencyTipDescription;

  /// Title for ATMs tip
  ///
  /// In en, this message translates to:
  /// **'ATMs and Currency Exchange'**
  String get atmsTipTitle;

  /// Description for ATMs tip
  ///
  /// In en, this message translates to:
  /// **'ATMs are available across the city. Avoid using ATMs in isolated or poorly lit areas at night.'**
  String get atmsTipDescription;

  /// Title for weather tip
  ///
  /// In en, this message translates to:
  /// **'Weather Tips'**
  String get weatherTipTitle;

  /// Description for weather tip
  ///
  /// In en, this message translates to:
  /// **'Bring layers! Quito\'s weather can change from warm and sunny to cool and rainy in minutes.'**
  String get weatherTipDescription;

  /// Retry button label
  ///
  /// In en, this message translates to:
  /// **'Retry'**
  String get actionRetry;

  /// Message displayed when no sessions are available
  ///
  /// In en, this message translates to:
  /// **'No sessions available'**
  String get errorSessionsNone;

  /// Message shown when there are no sessions for a specific day
  ///
  /// In en, this message translates to:
  /// **'No sessions scheduled for {date}'**
  String errorSessionsNoneForDay(String date);

  /// Message displayed when no sponsors are available
  ///
  /// In en, this message translates to:
  /// **'No sponsors available'**
  String get errorSponsorsNone;

  /// Message displayed when no speakers are available
  ///
  /// In en, this message translates to:
  /// **'No speakers available'**
  String get errorSpeakersNone;

  /// Message displayed when the Agenda is loading
  ///
  /// In en, this message translates to:
  /// **'Loading Agenda'**
  String get stateLoadingAgenda;

  /// Message displayed when the Sessions are loading
  ///
  /// In en, this message translates to:
  /// **'Loading Sessions'**
  String get stateLoadingSessions;

  /// Message displayed when the Speakers are loading
  ///
  /// In en, this message translates to:
  /// **'Loading Speakers'**
  String get stateLoadingSpeakers;

  /// Message displayed when the Sponsors are loading
  ///
  /// In en, this message translates to:
  /// **'Loading Sponsors'**
  String get stateLoadingSponsors;

  /// Label for the 'Speaks' widget
  ///
  /// In en, this message translates to:
  /// **'Speaks'**
  String get speaks;

  /// Prefix displayed before the languages a speaker knows
  ///
  /// In en, this message translates to:
  /// **'I speak'**
  String get iSpeakPrefix;

  /// Text showing which languages a speaker knows
  ///
  /// In en, this message translates to:
  /// **'I speak {languages}'**
  String iSpeakLanguages(String languages);

  /// Accessibility label for country flag emoji
  ///
  /// In en, this message translates to:
  /// **'{country} flag'**
  String countryFlag(String country);

  /// Message shown when there are no sessions to preview on the home screen
  ///
  /// In en, this message translates to:
  /// **'No sessions to preview yet. Check back soon!'**
  String get agendaPreviewEmptyMessage;

  /// Label for the favorite sessions section
  ///
  /// In en, this message translates to:
  /// **'Favorite Sessions'**
  String get favoriteSessionsLabel;

  /// Tooltip text for the favorite sessions button
  ///
  /// In en, this message translates to:
  /// **'Show favorite sessions'**
  String get favoriteSessionsTooltip;

  /// Label for the filter button
  ///
  /// In en, this message translates to:
  /// **'Filters'**
  String get filterButtonLabel;

  /// Announcement when a new date is selected
  ///
  /// In en, this message translates to:
  /// **'Showing sessions for {date}'**
  String dateSelectedAnnouncement(String date);

  /// Accessibility label for the venue banner component
  ///
  /// In en, this message translates to:
  /// **'Venue: {venueName}. Location: {location}. Dates: {dates}'**
  String venueBannerSemanticLabel(
    String venueName,
    String location,
    String dates,
  );

  /// Accessibility label for the user profile button in app bar
  ///
  /// In en, this message translates to:
  /// **'User profile'**
  String get userProfileLabel;

  /// Accessibility hint for the user profile button
  ///
  /// In en, this message translates to:
  /// **'Tap to view your profile and settings'**
  String get userProfileHint;

  /// Tooltip text for the user profile button
  ///
  /// In en, this message translates to:
  /// **'Your profile'**
  String get userProfileTooltip;

  /// Tooltip text for the filter speakers button
  ///
  /// In en, this message translates to:
  /// **'Filter speakers'**
  String get filterSpeakersTooltip;

  /// Description for the agenda tab in navigation bar
  ///
  /// In en, this message translates to:
  /// **'2 days full of talks, workshops, activities and prizes!'**
  String get agendaNavigationDescription;

  /// Description for the speakers tab in navigation bar
  ///
  /// In en, this message translates to:
  /// **'Over 20 speakers from 5 different countries'**
  String get speakersNavigationDescription;

  /// Description for the sponsors tab in navigation bar
  ///
  /// In en, this message translates to:
  /// **'Partners and friends who help make this possible'**
  String get sponsorsNavigationDescription;

  /// Platinum sponsor tier
  ///
  /// In en, this message translates to:
  /// **'Platinum'**
  String get sponsorTierPlatinum;

  /// Gold sponsor tier
  ///
  /// In en, this message translates to:
  /// **'Gold'**
  String get sponsorTierGold;

  /// Silver sponsor tier
  ///
  /// In en, this message translates to:
  /// **'Silver'**
  String get sponsorTierSilver;

  /// Bronze sponsor tier
  ///
  /// In en, this message translates to:
  /// **'Bronze'**
  String get sponsorTierBronze;

  /// In-kind sponsor tier
  ///
  /// In en, this message translates to:
  /// **'In-kind'**
  String get sponsorTierInkind;

  /// Senior sponsor tier
  ///
  /// In en, this message translates to:
  /// **'Senior'**
  String get sponsorTierSenior;

  /// Junior sponsor tier
  ///
  /// In en, this message translates to:
  /// **'Junior'**
  String get sponsorTierJunior;

  /// Other sponsor tier
  ///
  /// In en, this message translates to:
  /// **'Others'**
  String get sponsorTierOther;

  /// Label for the 'Don't be shy' section
  ///
  /// In en, this message translates to:
  /// **'Don\'t be shy and say hi!'**
  String get dontBeShyLabel;

  /// Label for the English language
  ///
  /// In en, this message translates to:
  /// **'English'**
  String get languageEnglish;

  /// Label for the Spanish language
  ///
  /// In en, this message translates to:
  /// **'Spanish'**
  String get languageSpanish;

  /// Conjunction 'and' in English
  ///
  /// In en, this message translates to:
  /// **'and'**
  String get conjunctionAnd;

  /// Label for other social networks
  ///
  /// In en, this message translates to:
  /// **'Other'**
  String get socialNetworkOther;

  /// Accessibility prefix for social media links, followed by platform name
  ///
  /// In en, this message translates to:
  /// **'Open profile on '**
  String get socialProfilePrefix;

  /// Title for the social media links section on speaker details
  ///
  /// In en, this message translates to:
  /// **'Let\'s keep in touch'**
  String get contactSectionTitle;

  /// Error message when a link cannot be opened
  ///
  /// In en, this message translates to:
  /// **'Cannot open this link'**
  String get errorCannotOpenLink;

  /// Generic error message
  ///
  /// In en, this message translates to:
  /// **'An error occurred'**
  String get errorGeneric;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'es'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'es':
      return AppLocalizationsEs();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
