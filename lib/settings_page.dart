import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:provider/provider.dart';

import 'providers/settings_provider.dart';
import 'services/ad_service.dart';
import 'utils/popup_dialog.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  late BannerAd _bannerAd;

  bool isBannerAdLoaded = false;

  late InterstitialAd _interstitialAd;

  void _loadInterstitialAd() async {
    log('InterstitialadAd Init');
    await InterstitialAd.load(
      adUnitId: AdHelperService.interstitialAdUnitId,
      request: const AdRequest(),
      adLoadCallback: InterstitialAdLoadCallback(
        onAdLoaded: (ad) {
          // ad.fullScreenContentCallback = FullScreenContentCallback(
          //   onAdDismissedFullScreenContent: (ad) {
          //     // _moveToHome();
          //   },
          // );

          // setState(() {
          _interstitialAd = ad;
          _interstitialAd.show();
          // });
        },
        onAdFailedToLoad: (err) async {
          log('Failed to load an interstitial ad: ${err.message}');
          await Future.delayed(const Duration(seconds: 5));
          _loadInterstitialAd();
        },
      ),
    );
  }

  _initBannerAd() {
    _bannerAd = BannerAd(
      size: AdSize.banner,
      adUnitId: AdHelperService.bannerAdUnitId,
      listener: BannerAdListener(
        onAdLoaded: (ad) {
          setState(() {
            isBannerAdLoaded = true;
          });
        },
        onAdFailedToLoad: (ad, error) async {
          ad.dispose();
          log(error.message);
          await Future.delayed(const Duration(seconds: 15));
          _initBannerAd();
        },
      ),
      request: const AdRequest(),
    );

    _bannerAd.load();
  }

  @override
  void dispose() {
    super.dispose();
    _bannerAd.dispose();
    _interstitialAd.dispose();
  }

  @override
  void initState() {
    super.initState();
    _loadInterstitialAd();
    _initBannerAd();
  }

  @override
  Widget build(BuildContext context) {
    final settings = context.watch<SettingsProvider>();
    return Scaffold(
      appBar: AppBar(
        backgroundColor:
            settings.appTheme == AppTheme.dark ? Colors.black : Colors.pink,
        title: const Text(
          'Settings',
          style: TextStyle(fontSize: 30),
        ),
      ),
      body: ListView(
        children: [
          isBannerAdLoaded
              ? SizedBox(
                  height: _bannerAd.size.height.toDouble(),
                  width: _bannerAd.size.width.toDouble(),
                  child: AdWidget(
                    ad: _bannerAd,
                  ),
                )
              : const SizedBox(),
          ListTile(
            leading: const Icon(Icons.surround_sound),
            title: const Text('Auto Read Message'),
            trailing: Switch(
              activeColor: Colors.pink,
              value: settings.isAutoReadAloud,
              onChanged: (value) async {
                if (value == true) {
                  settings.setAutoRead(true);
                } else {
                  settings.setAutoRead(false);
                }
              },
            ),
          ),
          ListTile(
            leading: const Icon(Icons.dark_mode),
            title: const Text('Dark Theme'),
            trailing: Switch(
              activeColor: Colors.pink,
              value: settings.appTheme == AppTheme.dark,
              onChanged: (value) {
                if (value == true) {
                  settings.setAppTheme(AppTheme.dark);
                } else {
                  settings.setAppTheme(AppTheme.light);
                }
              },
            ),
          ),
          GestureDetector(
            onTap: () {
              showPopup(
                context,
                child: const Text('Do you want to delete your conversation?'),
                buttonName: 'Delete',
                onPressed: () async {
                  await settings.deleteConversation();
                  // ignore: use_build_context_synchronously
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      backgroundColor: Colors.red,
                      content: SizedBox(
                        height: 40,
                        child: Text(
                          'Deleted!',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 30,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  );

                  // ignore: use_build_context_synchronously
                  Navigator.pop(context);
                },
              );
            },
            child: const ListTile(
              leading: Icon(
                Icons.delete_forever,
                color: Colors.red,
              ),
              title: Text(
                'Delete Conversation',
                style: TextStyle(color: Colors.red),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
