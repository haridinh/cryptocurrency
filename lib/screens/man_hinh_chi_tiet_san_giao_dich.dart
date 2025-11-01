// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'dart:async';

import 'package:nb_utils/nb_utils.dart';

/// ============================
///        MOCK DATA MODELS
/// ============================

class ExchangeData {
  final String id;
  final String name;

  const ExchangeData({required this.id, required this.name});
}

class ExchangeDetailResponse {
  final int yearEstablished;
  final int trustScoreRank;
  final int trustScore;
  final String country;
  final double tradeVolume24hBtc;
  final String url;
  final String facebookUrl;
  final String telegramUrl;
  final String slackUrl;
  final String twitterHandle;
  final String redditUrl;
  final String otherUrl1;
  final String otherUrl2;

  const ExchangeDetailResponse({
    this.yearEstablished = 2018,
    this.trustScoreRank = 5,
    this.trustScore = 10,
    this.country = 'Vietnam',
    this.tradeVolume24hBtc = 120.5,
    this.url = 'https://mock.exchange.com',
    this.facebookUrl = 'https://facebook.com/mock',
    this.telegramUrl = 'https://t.me/mock',
    this.slackUrl = 'https://slack.com/mock',
    this.twitterHandle = 'mock_exchange',
    this.redditUrl = 'https://reddit.com/r/mock',
    this.otherUrl1 = 'https://other1.com',
    this.otherUrl2 = 'https://other2.com',
  });
}

/// ============================
///      EXTENSIONS & UTILS
/// ============================

extension NumExtension on num {
  Widget get height => SizedBox(height: toDouble());
  String get amountPrefix => 'B\$ $this';
}

extension StringExtension on String? {
  String validate({String value = ''}) => this ?? value;
  String get translate => this ?? '';
}

extension ContextExtension on BuildContext {
  Color get cardColor => Theme.of(this).cardColor;
}

TextStyle boldTextStyle({int size = 14}) =>
    TextStyle(fontWeight: FontWeight.bold, fontSize: size.toDouble());

BoxDecoration boxDecorationDefault({Color? color}) => BoxDecoration(
  color: color ?? Colors.white,
  borderRadius: BorderRadius.circular(8),
  boxShadow: [
    BoxShadow(
      color: Colors.black.withOpacity(0.05),
      blurRadius: 4,
      offset: const Offset(0, 2),
    ),
  ],
);

class AppCommon {
  static void commonLaunchUrl(String url, {dynamic launchMode}) {
    debugPrint('Mock Launching URL: $url');
  }
}

class SocialMediaBaseUrl {
  static const String twitterBaseUrl = 'https://twitter.com/';
}

const Color themePrimaryColor = Colors.blue;

/// ============================
///         MOCK WIDGETS
/// ============================

Future<ExchangeDetailResponse> getExchangesDetail(String id) async {
  await Future.delayed(const Duration(seconds: 1));
  return const ExchangeDetailResponse();
}

class LoaderWidget extends StatelessWidget {
  const LoaderWidget({super.key});
  @override
  Widget build(BuildContext context) =>
      const Center(child: CircularProgressIndicator());
}

class CommonErrorBuilder extends StatelessWidget {
  final String text;
  const CommonErrorBuilder({super.key, required this.text});

  @override
  Widget build(BuildContext context) => Center(
    child: Padding(
      padding: const EdgeInsets.all(16.0),
      child: Text(
        'Mock Error: $text',
        textAlign: TextAlign.center,
        style: const TextStyle(color: Colors.red),
      ),
    ),
  );
}

class ExchangeChartComponent extends StatelessWidget {
  final ExchangeData data;
  const ExchangeChartComponent({super.key, required this.data});

  @override
  Widget build(BuildContext context) => Container(
    height: 200,
    margin: const EdgeInsets.symmetric(horizontal: 16),
    decoration: boxDecorationDefault(
      color: ContextExtension(context).cardColor,
    ),
    child: Center(
      child: Text(
        'Mock Chart for ${data.name}',
        style: const TextStyle(fontStyle: FontStyle.italic),
      ),
    ),
  );
}

class SettingSection extends StatelessWidget {
  final Widget title;
  final BoxDecoration headingDecoration;
  final Widget divider;
  final List<Widget> items;

  const SettingSection({
    super.key,
    required this.title,
    required this.headingDecoration,
    required this.divider,
    required this.items,
  });

  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.all(16.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: headingDecoration,
          child: title,
        ),
        ...items,
      ],
    ),
  );
}

class MetricsWidget extends StatelessWidget {
  final String value;
  final String name;
  final bool isCurrencyAllowed;
  final bool isBorder;

  const MetricsWidget({
    super.key,
    required this.value,
    required this.name,
    this.isCurrencyAllowed = false,
    this.isBorder = true,
  });

  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
    decoration: isBorder
        ? const BoxDecoration(
            border: Border(bottom: BorderSide(color: Colors.grey, width: 0.5)),
          )
        : null,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(name, style: const TextStyle(fontSize: 14)),
        Text(value, style: boldTextStyle(size: 14)),
      ],
    ),
  );
}

class TextIcon extends StatelessWidget {
  final EdgeInsets edgeInsets;
  final double spacing;
  final Widget prefix;
  final String text;
  final bool expandedText;
  final Widget suffix;
  final VoidCallback onTap;

  const TextIcon({
    super.key,
    required this.edgeInsets,
    required this.spacing,
    required this.prefix,
    required this.text,
    this.expandedText = false,
    required this.suffix,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) => InkWell(
    onTap: onTap,
    child: Padding(
      padding: edgeInsets,
      child: Row(
        children: [
          prefix,
          SizedBox(width: spacing),
          Expanded(child: Text(text, style: const TextStyle(fontSize: 16))),
          suffix,
        ],
      ),
    ),
  );
}

class AppImages {
  static Widget get facebookImg =>
      const Icon(Icons.facebook, size: 24, color: Colors.blue);
  static Widget get telegramImg =>
      const Icon(Icons.send, size: 24, color: Colors.blue);
  static Widget get slackImg =>
      const Icon(Icons.chat_bubble, size: 24, color: Colors.blue);
  static Widget get twitterImg =>
      const Icon(Icons.public, size: 24, color: Colors.blue);
  static Widget get redditImg =>
      const Icon(Icons.reddit, size: 24, color: Colors.blue);
}

class ExchangesMarketComponent extends StatelessWidget {
  final String name;
  final String id;

  const ExchangesMarketComponent({
    super.key,
    required this.name,
    required this.id,
  });

  void launch(BuildContext context, {dynamic pageRouteAnimation}) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Mock Navigation'),
        content: Text('Navigating to Markets for $name (ID: $id)'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) => const SizedBox.shrink();
}

/// ============================
///       MAIN UI SCREEN
/// ============================

class ExchangesDetailScreen extends StatefulWidget {
  final ExchangeData data;
  const ExchangesDetailScreen({super.key, required this.data});

  @override
  State<ExchangesDetailScreen> createState() => _ExchangesDetailScreenState();
}

class _ExchangesDetailScreenState extends State<ExchangesDetailScreen> {
  late Future<ExchangeDetailResponse> _detailFuture;

  @override
  void initState() {
    super.initState();
    _detailFuture = getExchangesDetail(
      StringExtension(widget.data.id).validate(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final Color cardBackgroundColor = ContextExtension(context).cardColor;

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            StringExtension(widget.data.name).validate(),
            style: boldTextStyle(size: 24),
          ),
        ),
        body: FutureBuilder<ExchangeDetailResponse>(
          future: _detailFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const LoaderWidget();
            } else if (snapshot.hasError) {
              return CommonErrorBuilder(text: snapshot.error.toString());
            } else if (snapshot.hasData) {
              final snap = snapshot.data!;
              return SingleChildScrollView(
                padding: const EdgeInsets.only(bottom: 60),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    NumExtension(16).height,
                    ExchangeChartComponent(data: widget.data),
                    NumExtension(16).height,

                    /// --- ABOUT SECTION ---
                    SettingSection(
                      title: Text(
                        '${'lbl_about'.translate} ${StringExtension(widget.data.name).validate()}',
                        style: boldTextStyle(),
                      ),
                      headingDecoration: boxDecorationDefault(
                        color: cardBackgroundColor,
                      ),
                      divider: const Offstage(),
                      items: [
                        MetricsWidget(
                          value: '${snap.yearEstablished.validate()}',
                          name: "lbl_year_established".translate,
                          isBorder: false,
                        ),
                        MetricsWidget(
                          value: '${snap.trustScoreRank.validate()}',
                          name: "lbl_trust_score_rank".translate,
                          isBorder: false,
                        ),
                        MetricsWidget(
                          value: '${snap.trustScore.validate()}',
                          name: "lbl_trust_score".translate,
                          isBorder: false,
                        ),
                        MetricsWidget(
                          value: StringExtension(snap.country).validate(),
                          name: "lbl_country".translate,
                          isBorder: false,
                        ),
                        MetricsWidget(
                          value: snap.tradeVolume24hBtc
                              .toString()
                              .amountPrefix
                              .validate(),
                          name: "lbl_24h__btc_volume".translate,
                          isBorder: false,
                        ),
                      ],
                    ),

                    /// --- FOLLOW SECTION ---
                    SettingSection(
                      title: Text(
                        'lbl_follow_them_on'.translate,
                        style: boldTextStyle(),
                      ),
                      headingDecoration: boxDecorationDefault(
                        color: cardBackgroundColor,
                      ),
                      divider: const Offstage(),
                      items: [
                        NumExtension(16).height,
                        _socialItem(Icons.link, "lbl_home_page", snap.url),
                        _socialItem(
                          AppImages.facebookImg,
                          "lbl_faceBook",
                          snap.facebookUrl,
                        ),
                        _socialItem(
                          AppImages.telegramImg,
                          "lbl_telegram",
                          snap.telegramUrl,
                        ),
                        _socialItem(
                          AppImages.slackImg,
                          "lbl_slack",
                          snap.slackUrl,
                        ),
                        _socialItem(
                          AppImages.twitterImg,
                          "lbl_twitter",
                          "${SocialMediaBaseUrl.twitterBaseUrl}${StringExtension(snap.twitterHandle).validate()}",
                        ),
                        _socialItem(
                          AppImages.redditImg,
                          "lbl_reddit",
                          snap.redditUrl,
                        ),
                        _socialItem(
                          Icons.link,
                          "lbl_other_url_1",
                          snap.otherUrl1,
                        ),
                        _socialItem(
                          Icons.link,
                          "lbl_other_url_2",
                          snap.otherUrl2,
                        ),
                      ],
                    ),
                  ],
                ),
              );
            }
            return const SizedBox.shrink();
          },
        ),
        floatingActionButton: FloatingActionButton.extended(
          backgroundColor: themePrimaryColor,
          onPressed: () {
            ExchangesMarketComponent(
              name: StringExtension(widget.data.name).validate(),
              id: StringExtension(widget.data.id).validate(),
            ).launch(context);
          },
          label: Text('lbl_market'.translate, style: boldTextStyle()),
        ),
      ),
    );
  }

  Widget _socialItem(dynamic icon, String label, String url) {
    final Widget prefix = icon is IconData ? Icon(icon, size: 24) : icon;
    return TextIcon(
      edgeInsets: const EdgeInsets.all(16),
      spacing: 16,
      prefix: prefix,
      text: label.translate,
      expandedText: true,
      suffix: const Icon(Icons.arrow_forward_ios_sharp, size: 16),
      onTap: () => AppCommon.commonLaunchUrl(StringExtension(url).validate()),
    );
  }
}

extension on String {
  get amountPrefix => null;
}
