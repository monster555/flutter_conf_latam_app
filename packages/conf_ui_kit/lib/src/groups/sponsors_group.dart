import 'package:conf_shared_models/conf_shared_models.dart' show Sponsor;
import 'package:conf_ui_kit/src/images/sponsor_logo.dart';
import 'package:conf_ui_kit/src/theme/ui_constants.dart';
import 'package:conf_ui_kit/src/typography/section_title.dart';
import 'package:flutter/material.dart';

class SponsorsGroup extends StatelessWidget {
  const SponsorsGroup({required this.title, required this.sponsors, super.key});

  final String title;
  final List<Sponsor> sponsors;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: UiConstants.spacing16,
        vertical: UiConstants.spacing8,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SectionTitle(title: title),
          SizedBox(
            width: double.infinity,
            child: Card(
              child: Padding(
                padding: const EdgeInsets.all(UiConstants.spacing8),
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    // Calculate logo width based on screen size
                    // Aim for 2 logos per row on phones, 3-4 on larger devices
                    final width = constraints.maxWidth;
                    final itemWidth =
                        width < 600 ? width / 2 - 24 : width / 3 - 32;

                    return Wrap(
                      spacing: UiConstants.spacing16,
                      runSpacing: UiConstants.spacing16,
                      alignment: WrapAlignment.center,
                      children:
                          sponsors.map((sponsor) {
                            return SizedBox(
                              width: itemWidth,
                              height: 80,
                              child: Center(
                                child: SponsorLogo(
                                  imageUrl: sponsor.logo,
                                  sponsorName: sponsor.name,
                                  height: 60,
                                  fit: BoxFit.contain,
                                ),
                              ),
                            );
                          }).toList(),
                    );
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
