import 'package:business_menagament/core/consts/dimensions.dart';
import 'package:business_menagament/core/consts/utils.dart';
import 'package:business_menagament/core/strings/languages.dart';
import 'package:business_menagament/features/presentation/providers/current_user.dart';
import 'package:business_menagament/features/presentation/providers/notification_provider.dart';
import 'package:business_menagament/features/presentation/screens/business_admin/branches_screen.dart';
import 'package:business_menagament/features/presentation/screens/business_admin/new_employee.dart';
import 'package:business_menagament/features/presentation/screens/business_admin/notifications_screen.dart';
import 'package:business_menagament/features/presentation/screens/business_admin/profile_screen.dart';
import 'package:business_menagament/features/presentation/screens/business_admin/statistics_screen.dart';
import 'package:business_menagament/features/presentation/screens/business_admin/transactions_screen.dart';
import 'package:business_menagament/features/presentation/widgets/error_widgets.dart';
import 'package:business_menagament/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:business_menagament/l10n/app_localizations.dart';
import 'package:provider/provider.dart';

class BusinessDrawerWidget extends StatefulWidget {
  final CurrentUser? currentUser;
  const BusinessDrawerWidget({Key? key, this.currentUser}) : super(key: key);

  @override
  State<BusinessDrawerWidget> createState() => _BusinessDrawerWidgetState();
}

class _BusinessDrawerWidgetState extends State<BusinessDrawerWidget> {
  bool isNight = false;
  @override
  Widget build(BuildContext context) {
    var notifications = Provider.of<NotificationProvider>(context);
    const textSize = 17.0;
    return Drawer(
      child: Container(
        color: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          children: [
            Container(
              height: getPhoneHeight(context) - 100,
              child: ListView(
                children: [
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(100),
                            image: const DecorationImage(
                                fit: BoxFit.cover,
                                image: AssetImage(
                                    "assets/images/background.jpeg"))),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.currentUser!.getBusinessAdmin() == null
                                ? ""
                                : widget.currentUser!.getBusinessAdmin()?.business?.name ?? "",
                            style: const TextStyle(
                                fontWeight: FontWeight.w600, fontSize: 19),
                          ),
                          Text(
                            widget.currentUser!.getBusinessAdmin() == null
                                ? ""
                                : widget.currentUser?.getBusinessAdmin()?.user?.fullName ?? "",
                            style: const TextStyle(
                                fontSize: 14, fontWeight: FontWeight.w400),
                          ),
                        ],
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 32,
                  ),
                  GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (_) => const NotificationsScreen()));
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        color: Colors.transparent,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(left: 2),
                                  child: Image.asset(
                                    "assets/icons/bell-icon.png",
                                    width: 17,
                                  ),
                                ),
                                const SizedBox(
                                  width: 11,
                                ),
                                Text(
                                  AppLocalizations.of(context)!.notifications,
                                  style: const TextStyle(fontSize: textSize),
                                ),
                              ],
                            ),
                            notifications.getUnreadNotifications() == 0
                                ? const SizedBox()
                                : Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10, vertical: 2),
                                    decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(100),
                                        color: const Color(0xff1a2836)),
                                    child: Center(
                                      child: Text(
                                        notifications
                                            .getUnreadNotifications()
                                            .toString(),
                                        style: GoogleFonts.inter(
                                            color: Colors.white, fontSize: 13),
                                      ),
                                    ),
                                  )
                          ],
                        ),
                      )),
                  GestureDetector(
                      onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const NewEmployee(
                                    newPage: true,
                                  ))),
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        color: Colors.transparent,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            SvgPicture.asset(
                              "assets/icons/add-square.svg",
                              width: 20,
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Text(
                              AppLocalizations.of(context)!.addEmployee,
                              style: const TextStyle(fontSize: textSize),
                            ),
                          ],
                        ),
                      )),
                  GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (_) => const TransactionsScreen()));
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        color: Colors.transparent,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            SvgPicture.asset(
                              "assets/icons/chart-icon.svg",
                              width: 20,
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Text(
                              AppLocalizations.of(context)!.transactions,
                              style: const TextStyle(fontSize: textSize),
                            ),
                          ],
                        ),
                      )),
                  GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (_) => const BranchesScreen()));
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        color: Colors.transparent,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            SvgPicture.asset(
                              "assets/icons/git-branch.svg",
                              width: 20,
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Text(
                              AppLocalizations.of(context)!.branches,
                              style: const TextStyle(fontSize: textSize),
                            ),
                          ],
                        ),
                      )),
                  GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (_) => StatisticsScreen()));
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        color: Colors.transparent,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            SvgPicture.asset(
                              "assets/icons/analytics.svg",
                              width: 20,
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Text(
                              AppLocalizations.of(context)!.statistics,
                              style: const TextStyle(fontSize: textSize),
                            ),
                          ],
                        ),
                      )),
                  GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                        showModalBottomSheet(
                            backgroundColor: Colors.transparent,
                            context: context,
                            builder: (context) {
                              return Padding(
                                padding: const EdgeInsets.only(
                                    left: 20, right: 20, bottom: 20),
                                child: Container(
                                  width: getPhoneWidth(context),
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(20)),
                                  padding: const EdgeInsets.symmetric(
                                      horizontal:  0, vertical: 15),
                                  child: SingleChildScrollView(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: List.generate(
                                          languages.length,
                                          (index) => GestureDetector(
                                                onTap: () {
                                                  MyApp.of(context)!.setLocale(
                                                      Locale.fromSubtags(
                                                          languageCode:
                                                              languages[index]
                                                                  ['id']!));
                                                  Navigator.pop(context);
                                                },
                                                child: Container(
                                                  color: Colors.transparent,
                                                  padding: const EdgeInsets
                                                      .symmetric(
                                                      horizontal: 20,
                                                      vertical: 10),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Row(
                                                        children: [
                                                          Text(
                                                            languages[index]
                                                                ['name']!,
                                                            style: GoogleFonts
                                                                .nunito(
                                                                    fontSize:
                                                                        20),
                                                          ),
                                                          const SizedBox(
                                                            width: 10,
                                                          ),
                                                          Text(convertToFlag(
                                                              languages[index]
                                                                  ['country'])),
                                                        ],
                                                      ),
                                                      Container(
                                                        width: 20,
                                                        height: 20,
                                                        decoration: BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        100),
                                                            border: Border.all(
                                                                color: const Color(
                                                                    0xff324a60))),
                                                        padding:
                                                            const EdgeInsets
                                                                .all(2),
                                                        child: MyApp.of(context)!
                                                                    .getLocale()!
                                                                    .languageCode !=
                                                                languages[index]
                                                                    ['id']
                                                            ? const SizedBox()
                                                            : Container(
                                                                width: 20,
                                                                height: 20,
                                                                decoration: BoxDecoration(
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            100),
                                                                    color: const Color(
                                                                        0xff324a60)),
                                                              ),
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              )),
                                    ),
                                  ),
                                ),
                              );
                            });

                        // Navigator.push(context,
                        //     MaterialPageRoute(builder: (context) => const ChartTwo())),
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        color: Colors.transparent,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            SvgPicture.asset(
                              "assets/icons/translate.svg",
                              width: 20,
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Text(
                              AppLocalizations.of(context)!.languages,
                              style: const TextStyle(
                                fontSize: textSize,
                              ),
                            ),
                          ],
                        ),
                      )),
                  GestureDetector(
                      onTap: () {
                        showErroModal(context,
                            AppLocalizations.of(context)!.nextVersionMessage,
                            size: 17);
                        // Navigator.push(context,
                        //     MaterialPageRoute(builder: (context) => const ChartTwo())),
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        color: Colors.transparent,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            SvgPicture.asset(
                              "assets/icons/activity.svg",
                              width: 20,
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Text(
                              AppLocalizations.of(context)!.employeeActivity,
                              style: const TextStyle(
                                  fontSize: textSize, color: Colors.grey),
                            ),
                          ],
                        ),
                      )),
                  GestureDetector(
                      onTap: () {
                        showErroModal(context,
                            AppLocalizations.of(context)!.nextVersionMessage,
                            size: 17);
                        // Navigator.push(context,
                        //     MaterialPageRoute(builder: (context) => const ChartTwo())),
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        color: Colors.transparent,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            SvgPicture.asset(
                              "assets/icons/tag-alt.svg",
                              width: 20,
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Text(
                              AppLocalizations.of(context)!.packets,
                              style: const TextStyle(
                                  fontSize: textSize, color: Colors.grey),
                            ),
                          ],
                        ),
                      )),
                  GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const ProfileScreen()));
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        color: Colors.transparent,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            SvgPicture.asset(
                              "assets/icons/user.svg",
                              width: 20,
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Text(
                              AppLocalizations.of(context)!.profile,
                              style: const TextStyle(fontSize: textSize),
                            ),
                          ],
                        ),
                      )),
                  GestureDetector(
                      onTap: () async {
                        await widget.currentUser!.removeBusinessAdmin(context);
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        color: Colors.transparent,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            SvgPicture.asset(
                              "assets/icons/logout.svg",
                              width: 20,
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Text(
                              AppLocalizations.of(context)!.logout,
                              style: const TextStyle(fontSize: textSize),
                            ),
                          ],
                        ),
                      )),
                ],
              ),
            ),
            GestureDetector(
                onTap: () {
                  showErroModal(context,
                      AppLocalizations.of(context)!.nextVersionMessage,
                      size: 17);
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  color: Colors.transparent,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 2),
                            child: SvgPicture.asset(
                              "assets/icons/${isNight ? "moon-full" : "moon-empty"}.svg",
                              width: 17,
                            ),
                          ),
                          const SizedBox(
                            width: 11,
                          ),
                          Text(
                            AppLocalizations.of(context)!.theme,
                            style: const TextStyle(fontSize: textSize),
                          ),
                        ],
                      ),
                      Stack(
                        children: [
                          Container(
                            width: 45,
                            height: 22,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(100),
                                border: Border.all(
                                    color:
                                        !isNight ? Colors.grey : Colors.black)),
                          ),
                          AnimatedPositioned(
                              top: 2,
                              left: !isNight ? 2 : 24,
                              duration: const Duration(milliseconds: 100),
                              child: Container(
                                width: 18,
                                height: 18,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(100),
                                    color:
                                        !isNight ? Colors.grey : Colors.black),
                              ))
                        ],
                      ),
                    ],
                  ),
                )),
          ],
        ),
      ),
    );
  }
}
