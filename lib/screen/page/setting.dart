import 'dart:io';

import 'package:bruno/bruno.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:in_app_review/in_app_review.dart';
import 'package:settings_ui/settings_ui.dart';
import 'package:sp_util/sp_util.dart';

import '../../main.dart';
import '../../service/clash_service.dart';
import '../../service/dialog_service.dart';
import '../../service/v2board_service.dart';
import '../../tools/customlaunch.dart';
import 'clash_log.dart';
import 'connection.dart';

class Setting extends StatefulWidget {
  const Setting({Key? key}) : super(key: key);

  @override
  State<Setting> createState() => _SettingState();
}

class _SettingState extends State<Setting> {
  @override
  Widget build(BuildContext context) {
    final cs = Get.find<ClashService>();
    final vs = Get.find<V2boardService>();
    const textStyle = TextStyle(fontFamily: 'nssc');

    return Scaffold(
      appBar: AppBar(
        shadowColor: Colors.transparent,
        title: Text("Setting".tr),
      ),
      body: Obx(
        () => cs.configEntity.value == null
            ? BrnLoadingDialog(
                content: 'Loading'.tr,
              )
            : SettingsList(platform: DevicePlatform.iOS, sections: [
                // SettingsSection(
                //   title: Text(
                //     "Proxy".tr,
                //     style: textStyle,
                //   ),
                //   tiles: [
                //     SettingsTile.navigation(
                //       title: Text(
                //         "Proxy mode".tr,
                //         style: textStyle,
                //       ),
                //       value: Text(cs.configEntity.value!.mode!.tr),
                //       onPressed: (cxt) {
                //         handleProxyMode();
                //       },
                //     ),
                //     SettingsTile.navigation(
                //       title: Text(
                //         "Socks5 proxy port".tr,
                //         style: textStyle,
                //       ),
                //       value: Text(
                //         cs.configEntity.value!.socksPort.toString(),
                //         style: textStyle,
                //       ),
                //       onPressed: (cxt) {
                //         Get.find<DialogService>().inputDialog(
                //             title: 'Enter custom port for Socks5 proxy port'.tr,
                //             onText: (text) {
                //               final port = int.tryParse(text);
                //               if (port == null) {
                //                 // BrnToast.show('no a valid port', context)
                //                 EasyLoading.showError('no a valid port');
                //               } else {
                //                 Get.find<ClashService>()
                //                     .changeConfigField('socks-port', port);
                //                 SpUtil.putInt('socks-port', port);
                //               }
                //             });
                //       },
                //     ),
                //     SettingsTile.navigation(
                //       title: Text(
                //         "HTTP proxy port".tr,
                //         style: textStyle,
                //       ),
                //       value: Text(
                //         cs.configEntity.value!.port.toString(),
                //         style: textStyle,
                //       ),
                //       onPressed: (cxt) {
                //         Get.find<DialogService>().inputDialog(
                //             title: 'Enter custom port for HTTP proxy port'.tr,
                //             onText: (text) {
                //               final port = int.tryParse(text);
                //               if (port == null) {
                //                 // BrnToast.show('no a valid port'.tr, context);
                //                 EasyLoading.showError('no a valid port');
                //               } else {
                //                 Get.find<ClashService>()
                //                     .changeConfigField('port', port);
                //                 SpUtil.putInt('http-port', port);
                //               }
                //             });
                //       },
                //     ),
                //     SettingsTile.navigation(
                //       title: Text(
                //         "Redir proxy port".tr,
                //         style: textStyle,
                //       ),
                //       value: Text(
                //         cs.configEntity.value!.redirPort.toString(),
                //         style: textStyle,
                //       ),
                //       onPressed: (cxt) {
                //         Get.find<DialogService>().inputDialog(
                //             title: 'Enter custom port for redir proxy port'.tr,
                //             onText: (text) {
                //               final port = int.tryParse(text);
                //               if (port == null) {
                //                 // BrnToast.show('no a valid port'.tr, context);
                //                 EasyLoading.showError('no a valid port'.tr);
                //               } else {
                //                 Get.find<ClashService>()
                //                     .changeConfigField('redir-port', port);
                //                 SpUtil.putInt('redir-port', port);
                //               }
                //             });
                //       },
                //     ),
                //     SettingsTile.navigation(
                //       title: Text(
                //         "Mixed proxy port".tr,
                //         style: textStyle,
                //       ),
                //       value: Text(
                //         cs.configEntity.value!.mixedPort.toString(),
                //         style: textStyle,
                //       ),
                //       onPressed: (cxt) {
                //         Get.find<DialogService>().inputDialog(
                //             title: 'Enter custom port for mixed proxy port'.tr,
                //             onText: (text) {
                //               final port = int.tryParse(text);
                //               if (port == null) {
                //                 // BrnToast.show('no a valid port'.tr, context);
                //                 EasyLoading.showError('no a valid port'.tr);
                //               } else {
                //                 Get.find<ClashService>()
                //                     .changeConfigField('mixed-port', port);
                //                 SpUtil.putInt('mixed-port', port);
                //               }
                //             });
                //       },
                //     ),
                //     SettingsTile.switchTile(
                //         title: Text(
                //           "allow_lan".tr,
                //           style: textStyle,
                //         ),
                //         initialValue: cs.configEntity.value?.allowLan,
                //         onToggle: (e) {
                //           Get.find<ClashService>()
                //               .changeConfigField('allow-lan', e);
                //         }),
                //     SettingsTile.switchTile(
                //         title: Text(
                //           "Enable IPv6".tr,
                //           style: textStyle,
                //         ),
                //         initialValue: cs.configEntity.value?.ipv6,
                //         onToggle: (e) {
                //           Get.find<ClashService>().changeConfigField('ipv6', e);
                //         }),
                //     // SettingsTile.navigation(
                //     //   title: Text(
                //     //     'Profile'.tr,
                //     //     style: textStyle,
                //     //   ),
                //     //   onPressed: (cxt) {
                //     //     Get.to(const Profile());
                //     //   },
                //     // ),
                //     // SettingsTile.navigation(
                //     //   title: Text(
                //     //     'Connections'.tr,
                //     //     style: textStyle,
                //     //   ),
                //     //   onPressed: (cxt) {
                //     //     Get.to(const Connections());
                //     //   },
                //     // ),
                //     // SettingsTile.navigation(
                //     //   title: Text(
                //     //     'Log'.tr,
                //     //     style: textStyle,
                //     //   ),
                //     //   onPressed: (cxt) {
                //     //     Get.to(const ClashLog());
                //     //   },
                //     // ),
                //   ],
                // ),
                SettingsSection(
                    title: Text(
                      "System".tr,
                      style: textStyle,
                    ),
                    tiles: [
                      SettingsTile.navigation(
                        value: Text(SpUtil.getString('lan', defValue: "zh_CN")!),
                        title: Text(
                          'Language'.tr,
                          style: textStyle,
                        ),
                        onPressed: (cxt) {
                          Get.dialog(BrnSingleSelectDialog(
                            title: 'Language'.tr,
                            conditions: const ["中文", "English"],
                            onSubmitClick: (s) {
                              if (s != null) {
                                if (s == "English") {
                                  Get.updateLocale(const Locale('en', 'US'));
                                  SpUtil.putString('lan', 'en_US');
                                } else {
                                  Get.updateLocale(const Locale('zh', 'CN'));
                                  SpUtil.putString('lan', 'zh_CN');
                                }
                              }
                              Get.find<ClashService>().updateTray();
                            },
                          ));
                        },
                      ),
                      SettingsTile.switchTile(
                          initialValue:
                              SpUtil.getBool("is_dark", defValue: false),
                          // onPressed: (content) {
                          //   Get.changeThemeMode(Get.isDarkMode
                          //       ? ThemeMode.light
                          //       : ThemeMode.dark);
                          //   SpUtil.setData("is_dark", Get.isDarkMode);
                          // },
                          onToggle: (e) async {
                            if (e) {
                              await SpUtil.putBool("is_dark", true);
                              Get.changeThemeMode(ThemeMode.dark);
                            } else {
                              await SpUtil.putBool("is_dark", false);
                              Get.changeThemeMode(ThemeMode.light);
                            }

                            setState(() {});
                          },
                          title: Text(
                            'Dark Theme'.tr,
                            style: textStyle,
                          )),

                      // SettingsTile.navigation(
                      //   title: Text(
                      //     'Dark Theme'.tr,
                      //     style: textStyle,
                      //   ),
                      //   value: Text(cs.configEntity.value!.mode!.tr),
                      //   onPressed: (cxt) {
                      //     handleTheme();
                      //   },
                      // ),

                      // SettingsTile.switchTile(
                      //     title: Text(
                      //       "Set as system proxy".tr,
                      //       style: textStyle,
                      //     ),
                      //     initialValue:
                      //         SpUtil.getBool("system_proxy", defValue: false),
                      //     onToggle: (e) async {
                      //       if (e) {
                      //         await Get.find<ClashService>().setSystemProxy();
                      //         await SpUtil.putBool("system_proxy", true);
                      //       } else {
                      //         await Get.find<ClashService>().clearSystemProxy();
                      //         await SpUtil.putBool("system_proxy", false);
                      //       }
                      //       setState(() {
                      //         EasyLoading.showSuccess("成功",duration: Duration(seconds: 2));
                      //       });
                      //     }),
                      // SettingsTile.navigation(
                      //   title: Text(
                      //     "Testing rule".tr,
                      //     style: textStyle,
                      //   ),
                      //   value: Text(
                      //     cs.customTestUrl,
                      //     style: textStyle,
                      //   ),
                      //   onPressed: (cxt) {
                      //     Get.find<DialogService>().inputDialog(
                      //         title: 'Enter custom host or domian for Test'.tr,
                      //         onText: (text) {
                      //           if (isValidIPorDomain(text)) {
                      //             cs.changeCustomTestUrl(text);
                      //           } else {
                      //             EasyLoading.showError(
                      //                 "not host or domain,Please Retry".tr);
                      //           }
                      //         });
                      //   },
                      // ),
                      // if (isDesktop)
                      //   SettingsTile.switchTile(
                      //       title: Text(
                      //         "Start with system".tr,
                      //         style: textStyle,
                      //       ),
                      //       initialValue:
                      //           Get.find<AutostartService>().isEnabled.value,
                      //       onToggle: (e) async {
                      //         if (e) {
                      //           Get.find<AutostartService>().enableAutostart();
                      //         } else {
                      //           Get.find<AutostartService>().disableAutostart();
                      //         }
                      //       }),
                      // if (isDesktop)
                      //   SettingsTile.switchTile(
                      //       title: Text(
                      //         "Hide window when start".tr,
                      //         style: textStyle,
                      //       ),
                      //       initialValue: Get.find<ClashService>()
                      //           .isHideWindowWhenStart(),
                      //       onToggle: (e) async {
                      //         setState(() {
                      //           Get.find<ClashService>()
                      //               .setHideWindowWhenStart(e);
                      //         });
                      //       }),
                      SettingsTile.navigation(
                        title: Text(
                          'Rate App'.tr,
                          style: textStyle,
                        ),
                        onPressed: (cxt) {
                          final InAppReview inAppReview = InAppReview.instance;
                          inAppReview.openStoreListing(
                              appStoreId: '6450592965',
                              microsoftStoreId: '...');
                        },
                      ),
                      SettingsTile.navigation(
                        title: Text(
                          "Logout".tr,
                          style: textStyle,
                        ),
                        onPressed: (cxt) {
                          SpUtil.remove("Authorization");
                          if (isDesktop) {
                            exit(0);
                            // cs.clearSystemProxy().then((value) => exit(0));
                          } else {
                            vs.setIslogin(false);
                            Get.to(const MyHomePage());
                          }
                        },
                      )
                      // SettingsTile.navigation(
                      //   title: Text(
                      //     'Telegram Group'.tr,
                      //     style: textStyle,
                      //   ),
                      //   onPressed: (cxt) {
                      //     customLaunch(Uri.parse("https://t.me/clashcross"));
                      //   },
                      // ),
                      // SettingsTile.navigation(
                      //   title: Text(
                      //     'Telegram Channel'.tr,
                      //     style: textStyle,
                      //   ),
                      //   onPressed: (cxt) {
                      //     customLaunch(
                      //         Uri.parse("https://t.me/clashcrosschannel"));
                      //   },
                      // ),
                      // SettingsTile.navigation(
                      //   title: Text(
                      //     'Help'.tr,
                      //     style: textStyle,
                      //   ),
                      //   onPressed: (cxt) {
                      //     Get.to(const HelpPage());
                      //   },
                      // ),
                      // SettingsTile.navigation(
                      //   title: Text(
                      //     'About'.tr,
                      //     style: textStyle,
                      //   ),
                      //   onPressed: (cxt) {
                      //     Get.to(const AboutPage());
                      //   },
                      // ),
                    ])
              ]),
      ),
    );
  }

  void handleTheme() {
    Get.bottomSheet(BrnCommonActionSheet(
      actions: [
        BrnCommonActionSheetItem('Dark Theme'.tr),
        BrnCommonActionSheetItem('Light Theme'.tr),
        BrnCommonActionSheetItem('System Theme'.tr),
      ],
      onItemClickInterceptor: (index, s) {
        switch (index) {
          case 0:
            SpUtil.putBool("is_dark", true);
            Get.changeThemeMode(ThemeMode.dark);
            break;
          case 1:
            SpUtil.putBool("is_dark", false);
            Get.changeThemeMode(ThemeMode.light);
            break;
          case 2:
            // SpUtil.setData("is_dark", true);
            Get.changeThemeMode(ThemeMode.system);
            break;
        }
        return false;
      },
    ));
  }

  // void handleProxyMode() {
  //   Get.bottomSheet(BrnCommonActionSheet(
  //     actions: [
  //       // BrnCommonActionSheetItem('direct'.tr),
  //       BrnCommonActionSheetItem('rule'.tr),
  //       BrnCommonActionSheetItem('global'.tr),
  //     ],
  //     onItemClickInterceptor: (index, s) {
  //       switch (index) {
  //         // case 0:
  //         //   Get.find<ClashService>().changeConfigField('mode', 'Direct');
  //         //   break;
  //         case 1:
  //           Get.find<ClashService>().changeConfigField('mode', 'Rule');
  //           break;
  //         case 2:
  //           Get.find<ClashService>().changeConfigField('mode', 'Global');
  //           break;
  //       }
  //       return false;
  //     },
  //   ));
  // }

  listTileSet(String title, String description, bool value,
          Function(bool)? onChanged) =>
      Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        const Divider(color: Colors.grey, thickness: 1),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Text(title,
              style: Theme.of(context)
                  .primaryTextTheme
                  .titleMedium!
                  .copyWith(color: Colors.grey)),
        ),
        SwitchListTile(
            activeColor: Theme.of(context).colorScheme.secondary,
            inactiveTrackColor: SpUtil.getBool("is_dark", defValue: false)!
                ? const Color(0xff38323F)
                : const Color(0xffD7D6D9),
            contentPadding: EdgeInsets.zero,
            title: Text(
              description,
              style: Theme.of(context).primaryTextTheme.titleMedium,
            ),
            value: value,
            onChanged: onChanged)
      ]);
}
