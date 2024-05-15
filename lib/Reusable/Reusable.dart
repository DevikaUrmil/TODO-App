import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:todo/Global/Constant.dart';

class Reusable {
  static appBar(Widget title,
      {Widget? leading,
      SystemUiOverlayStyle? britness,
      List<Widget>? action,
      bool centerTitle = true,
      Color? bgColor,
      bool? elevation1}) {
    return AppBar(
      title: title,
      elevation: elevation1 == true ? 0.0 : 3,
      centerTitle: centerTitle,
      leading: leading,
      systemOverlayStyle: britness,
      actions: action,
      backgroundColor: bgColor ?? Colors.white,
      iconTheme: IconThemeData(color: Palette.appColor),
    );
  }

  static topLabel(String title, {Color? txtColor}) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Text(
        title,
        style: TextStyle(
          fontSize: 17,
          fontWeight: FontWeight.w600,
          color: txtColor ?? Colors.black,
        ),
      ),
    );
  }

  static noDataView() {
    return SizedBox(
      height: 220,
      child: Column(
        children: [
          Image.asset(
            "assets/noData.jpg",
            height: 100,
            fit: BoxFit.cover,
          ),
          const SizedBox(height: 5),
          const Text(
            "No results found",
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}

class TxtFieldWidget extends StatelessWidget {
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final bool? obsecure;
  final bool? readOnly;
  final TextInputType? keyboardType;
  final Widget? suffix;
  final Widget? prefix;
  final Function? onTap;
  final int? minLine;
  final int? maxLine;
  final String? hintTxt;
  final Color? bgColor;
  final bool? enable;
  final bool? enableInteractive;
  final int? maxLength;
  final bool? autofocus;

  TxtFieldWidget({
    Key? key,
    this.controller,
    this.focusNode,
    this.obsecure,
    this.readOnly,
    this.keyboardType,
    this.suffix,
    this.prefix,
    this.onTap,
    this.minLine,
    this.maxLine,
    this.hintTxt,
    this.bgColor,
    this.enable,
    this.enableInteractive,
    this.maxLength,
    this.autofocus,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: bgColor ?? Colors.white,
        borderRadius: BorderRadius.circular(5.0),
      ),
      child: TextFormField(
        //onChanged: onChanged,
        //onEditingComplete: onEditingCompleted,
        //autofocus: autofocus,
        maxLength: maxLength,
        minLines: minLine ?? 1,
        maxLines: maxLine ?? 1,
        onTap: () {
          onTap;
        },

        enabled: enable ?? true,
        enableInteractiveSelection: enableInteractive ?? true,
        readOnly: readOnly ?? false,
        obscureText: obsecure ?? false,
        obscuringCharacter: "*",
        keyboardType: keyboardType,
        controller: controller,
        focusNode: focusNode,
        autofocus: autofocus ?? true,

        decoration: InputDecoration(
          //errorText: errorText,
          prefixIcon: prefix,
          suffixIcon: suffix,
          labelStyle: const TextStyle(fontSize: 15),
          //labelText: label,
          hintStyle: const TextStyle(color: Colors.blueGrey, fontSize: 15),
          hintText: hintTxt,
          contentPadding:
              const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5.0),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5.0),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5.0),
          ),
          // errorBorder: errorrTextFieldBorder(),
          // focusedErrorBorder: errorrTextFieldBorder(),
        ),
      ),
    );
  }
}

class AppButton extends StatelessWidget {
  final String? title;
  final double? width;
  final BuildContext? context;
  final Color? bgColor;
  final Color? txtColor;
  final Function()? onTap;
  final double? height;
  final double? txtSize;
  AppButton({
    Key? key,
    @required this.title,
    this.width,
    @required this.context,
    this.bgColor,
    this.onTap,
    this.txtColor,
    this.height,
    this.txtSize,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: width ?? 150,
        height: height ?? 45,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: bgColor ?? Palette.appColor,
        ),
        child: Center(
          child: Text(
            title ?? "",
            style: TextStyle(
              fontSize: txtSize ?? 18,
              fontWeight: FontWeight.w900,
              color: txtColor ?? Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
