import 'dart:io';

import 'package:business_menagament/core/consts/dimensions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';

showErroModal(context, String errorTitle,
    {double? size, bool options = false, function}) {
  bool isAndroid = Platform.isAndroid;
  showModalBottomSheet(
      backgroundColor: Colors.transparent,
      context: context,
      builder: (context) {
        return Padding(
          padding: EdgeInsets.only(
              left: isAndroid ? 20 : 0,
              right: isAndroid ? 20 : 0,
              bottom: isAndroid ? 20 : 0),
          child: Container(
            width: getPhoneWidth(context),
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(20)),
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Text(
                    errorTitle,
                    textAlign: TextAlign.center,
                    style: GoogleFonts.poppins(
                        fontSize: size ?? 20, color: Colors.black),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  options
                      ? const SizedBox()
                      : TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Text(AppLocalizations.of(context)!.leave)),
                  !options
                      ? const SizedBox()
                      : Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Container(
                              width: getPhoneWidth(context) / 3,
                              child: TextButton(
                                  style: ButtonStyle(),
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child:
                                      Text(AppLocalizations.of(context)!.no)),
                            ),
                            Container(
                              width: getPhoneWidth(context) / 3,
                              child: TextButton(
                                  onPressed: function,
                                  child:
                                      Text(AppLocalizations.of(context)!.yes)),
                            ),
                          ],
                        )
                ],
              ),
            ),
          ),
        );
      });
  // }
}
