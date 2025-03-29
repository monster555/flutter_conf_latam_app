import 'package:conf_shared_models/conf_shared_models.dart';
import 'package:conf_ui_kit/conf_ui_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_conf_latam/l10n/l10n.dart';

class MorePage extends StatelessWidget {
  const MorePage({super.key});

  List<InfoSection> _buildSafetyTips(AppLocalizations l10n) {
    return [
      InfoSection(
        title: l10n.safetyPrecautionsTipTitle,
        description: l10n.safetyPrecautionsTipDescription,
        icon: Icons.security,
      ),
      InfoSection(
        title: l10n.emergencyContactsTipTitle,
        description: l10n.emergencyContactsTipDescription,
        icon: Icons.contact_phone,
      ),
    ];
  }

  List<InfoSection> _buildTransportationTips(AppLocalizations l10n) {
    return [
      InfoSection(
        title: l10n.taxisTipTitle,
        description: l10n.taxisTipDescription,
        icon: Icons.local_taxi,
      ),
    ];
  }

  List<InfoSection> _buildFoodTips(AppLocalizations l10n) {
    return [
      InfoSection(
        title: l10n.deliveryAppsTipTitle,
        description: l10n.deliveryAppsTipDescription,
        icon: Icons.delivery_dining,
      ),
      InfoSection(
        title: l10n.localRestaurantsTipTitle,
        description: l10n.localRestaurantsTipDescription,
        icon: Icons.restaurant,
      ),
    ];
  }

  List<InfoSection> _buildMoneyTips(AppLocalizations l10n) {
    return [
      InfoSection(
        title: l10n.currencyTipTitle,
        description: l10n.currencyTipDescription,
        icon: Icons.payments,
      ),
      InfoSection(
        title: l10n.atmsTipTitle,
        description: l10n.atmsTipDescription,
        icon: Icons.credit_card,
      ),
    ];
  }

  List<InfoSection> _buildWeatherTips(AppLocalizations l10n) {
    return [
      InfoSection(
        title: l10n.weatherTipTitle,
        description: l10n.weatherTipDescription,
        icon: Icons.wb_cloudy,
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final padding = context.padding;
    final topPadding = padding.top;
    final bottomPadding = padding.bottom;

    // Safety tips section
    final safetyTips = _buildSafetyTips(l10n);

    // Transportation section
    final transportationTips = _buildTransportationTips(l10n);

    // Food section
    final foodTips = _buildFoodTips(l10n);

    // Money section
    final moneyTips = _buildMoneyTips(l10n);

    // Weather section
    final weatherTips = _buildWeatherTips(l10n);

    return Semantics(
      container: true,
      label: l10n.moreTabLabel,
      explicitChildNodes: true,
      child: CustomScrollView(
        slivers: [
          SliverList(
            delegate: SliverChildListDelegate([
              ExcludeSemantics(child: SizedBox(height: topPadding)),
              InfoSectionGroup(
                title: l10n.sectionTitleSafety,
                sections: safetyTips,
              ),
              InfoSectionGroup(
                title: l10n.sectionTitleTransportation,
                sections: transportationTips,
              ),
              InfoSectionGroup(
                title: l10n.sectionTitleFood,
                sections: foodTips,
              ),
              InfoSectionGroup(
                title: l10n.sectionTitleMoney,
                sections: moneyTips,
              ),
              InfoSectionGroup(
                title: l10n.sectionTitleWeather,
                sections: weatherTips,
              ),
              ExcludeSemantics(child: SizedBox(height: bottomPadding)),
            ]),
          ),
        ],
      ),
    );
  }
}
