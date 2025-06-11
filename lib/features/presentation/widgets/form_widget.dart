import 'package:flutter/material.dart';

class FormWidget extends StatelessWidget {
  final TextEditingController? textEditingController;
  final bool? isPassword;
  final String? hintText;
  final bool? hasPrefix;
  final bool? hasSufix;
  final Widget? suffixIcon;
  final Widget? preffixIcon;
  final bool? isReadOnly;
  final bool? enabled;
  final  onTap;
  final  onChange;
  const FormWidget(
      {Key? key,
      this.textEditingController,
      this.isPassword,
      this.hintText,
      this.hasPrefix,
      this.hasSufix,
        this.isReadOnly,
        this.enabled,
        this.onTap,
        this.onChange,
        this.preffixIcon,this.suffixIcon
      })
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: textEditingController,
      obscureText: isPassword!,
      enabled: enabled ?? true,
      readOnly: isReadOnly ?? false,
      onTap: onTap,
      onChanged: onChange,
      decoration: InputDecoration(
        border: InputBorder.none,
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(25),
            borderSide: BorderSide(color: Colors.blueGrey[700]!)),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(25),
            borderSide: BorderSide(color: Colors.blueGrey[700]!, width: 1.5)),
        hintText: hintText,
        suffixIcon: hasSufix == true ? suffixIcon: null,
        prefixIcon: hasPrefix == true ? preffixIcon: null,
        fillColor: Colors.blueGrey[500],

        hintStyle: TextStyle(
            color: Colors.black.withOpacity(0.3), fontWeight: FontWeight.w400),

        contentPadding: const EdgeInsets.only(left: 20,top: 10,bottom: 10),isDense: true
      ),
    );
  }
}
