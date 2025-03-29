import 'package:conf_shared_models/conf_shared_models.dart';
import 'package:conf_ui_kit/conf_ui_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_conf_latam/extensions/navigator_extensions.dart';
import 'package:flutter_conf_latam/l10n/l10n.dart';
import 'package:flutter_conf_latam/mock/mock_data.dart';
import 'package:flutter_conf_latam/speaker_details/speaker_details.dart';

class SpeakersPage extends StatefulWidget {
  const SpeakersPage({super.key});

  @override
  State<SpeakersPage> createState() => _SpeakersPageState();
}

class _SpeakersPageState extends State<SpeakersPage> {
  List<Speaker> _speakers = [];
  bool _isLoading = true;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    _fetchSpeakers();
  }

  Future<void> _fetchSpeakers() async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      // Simulate API delay
      await Future<void>.delayed(const Duration(milliseconds: 800));

      // Get speakers (replace with real API call later)
      final speakers = ConferenceMockData.getSpeakers();

      setState(() {
        _speakers = speakers;
        _isLoading = false;
      });
      // This just simulates an API call which won't be here in the future
      // ignore: avoid_catches_without_on_clauses
    } catch (e) {
      setState(() {
        _errorMessage = 'Failed to load speakers';
        _isLoading = false;
      });
    }
  }

  Widget _buildSpeakerCard(Speaker speaker) {
    return Padding(
      padding: const EdgeInsets.only(bottom: UiConstants.spacing16),
      child: SpeakerCard(
        speaker: speaker,
        onTap: () => context.push<void>(SpeakerDetailsPage(speaker)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final padding = context.padding;
    final topPadding = padding.top;
    final bottomPadding = padding.bottom;

    if (_isLoading) {
      return Center(
        child: Semantics(
          liveRegion: true,
          label: l10n.stateLoadingSpeakers,
          child: Padding(
            padding: EdgeInsets.only(top: padding.top),
            child: const CircularProgressIndicator(),
          ),
        ),
      );
    }

    if (_errorMessage != null) {
      return Center(
        child: Semantics(
          liveRegion: true,
          label: _errorMessage,
          child: Padding(
            padding: EdgeInsets.only(top: topPadding),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(_errorMessage!),
                const ExcludeSemantics(
                  child: SizedBox(height: UiConstants.spacing16),
                ),
                ElevatedButton(
                  onPressed: _fetchSpeakers,
                  child: Text(context.l10n.actionRetry),
                ),
              ],
            ),
          ),
        ),
      );
    }

    if (_speakers.isEmpty) {
      return Semantics(
        label: l10n.errorSpeakersNone,
        child: FeedbackWidget(
          fullScreen: true,
          icon: Icons.person_off_outlined,
          message: l10n.errorSpeakersNone,
        ),
      );
    }

    return Semantics(
      container: true,
      label: l10n.speakersTabLabel,
      explicitChildNodes: true,
      child: CustomScrollView(
        slivers: [
          SliverPadding(
            padding: EdgeInsets.fromLTRB(
              UiConstants.spacing16,
              topPadding + UiConstants.spacing16,
              UiConstants.spacing16,
              bottomPadding,
            ),
            sliver: SliverList(
              delegate: SliverChildBuilderDelegate(
                childCount: _speakers.length,
                (context, index) {
                  final speaker = _speakers[index];

                  return _buildSpeakerCard(speaker);
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
