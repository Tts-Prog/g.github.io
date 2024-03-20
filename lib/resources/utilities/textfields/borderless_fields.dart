import 'package:ame/resources/theme_utilities/app_colors.dart';
import 'package:ame/resources/theme_utilities/theme_extensions.dart';
import 'package:ame/resources/utilities/app_assets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class BorderlessSearchFields extends StatefulWidget {
  final Color iconColor;
  final String icon;
  final bool iconPresent;
  final TextEditingController? controller;
  final String? labelText;
  final TextInputType keyboardType;
  final int? inputLimit;
  final InputFormatter? formatter;
  final bool autocorrect;
  final Function? validate;
  final Function? onSave;
  final Function? onchange;
  final Function? onTap;
  final Function? onEditingComplete;
  final FocusNode? node;
  final bool showSuffixBusy;
  final bool readOnly;
  final int? maxLines;
  final String hintText;
  final AutovalidateMode? autovalidateMode;
  final int? maxText;
  final Widget? suffix;
  final Widget? prefix;
  final void Function(String)? onFieldSubmitted;
  final bool animate;
  final TextInputAction? textInputAction;
  final bool addPrefixText;
  final bool disableAllBorders;
  final Color? hintColor;

  const BorderlessSearchFields(
      {Key? key,
      this.iconColor = AppColors.ameSplashScreenBgColor,
      this.controller,
      this.labelText = "Enter value",
      required this.keyboardType,
      this.inputLimit,
      this.formatter,
      this.autocorrect = false,
      this.validate,
      this.onSave,
      this.onchange,
      this.onTap,
      this.onEditingComplete,
      this.node,
      this.showSuffixBusy = false,
      this.readOnly = false,
      this.maxLines,
      this.iconPresent = false,
      this.animate = false,
      this.icon = AppAssets.emailTextFdIcon,
      this.hintText = "",
      this.autovalidateMode = AutovalidateMode.disabled,
      this.maxText,
      this.suffix,
      this.prefix,
      this.onFieldSubmitted,
      this.textInputAction,
      this.addPrefixText = true,
      this.disableAllBorders = false,
      this.hintColor = AppColors.typographySubColor})
      : super(key: key);

  @override
  State<BorderlessSearchFields> createState() => _CustomInputfieldsFieldState();
}

class _CustomInputfieldsFieldState extends State<BorderlessSearchFields> {
  @override
  Widget build(BuildContext context) {
    return widget.animate
        ? AnimatedContainer(
            duration: const Duration(milliseconds: 500),
            curve: Curves.easeInOut,
            child: formField)
        : formField;
  }

  Widget get formField {
    Widget? prefixIcon;
    if (widget.prefix != null) {
      prefixIcon = widget.prefix;
    } else if (widget.icon.isNotEmpty) {
      prefixIcon = Transform.scale(
        scale: 0.5,
        child: ImageIcon(
          AssetImage(widget.icon),
          // color: Colors.white,
          size: 10,
        ),
      );
    }
    return TextFormField(
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.transparent,
        hintText: widget.showSuffixBusy ? "|   Search" : " Search",
        //hintStyle: TextStyle(color: Colors.grey[400]),
        //prefixText: widget.showSuffixBusy ? null : "|   ",
        prefixStyle: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 16,

          // height: 1.2,
          color: widget.hintColor,
        ),
        // contentPadding: EdgeInsets.all(10),
        prefixIcon: widget.iconPresent ? prefixIcon : null,

        // labelText: "Search",
        hintStyle: const TextStyle()
            .titleMedium
            .merge(TextStyle(color: widget.hintColor)),
        floatingLabelStyle: const TextStyle(color: Colors.transparent),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(width: 1, color: Colors.transparent),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(width: 1, color: Colors.transparent),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(width: 1, color: Colors.transparent),
        ),
      ),
      style: const TextStyle(
          fontWeight: FontWeight.w400, fontSize: 14, color: Colors.black),
      controller: widget.controller,
      readOnly: widget.readOnly,
      autocorrect: widget.autocorrect,
      focusNode: widget.node,
      maxLength: widget.maxText,
      textInputAction: widget.textInputAction,
      autovalidateMode: widget.autovalidateMode,
      textCapitalization: widget.keyboardType != TextInputType.emailAddress
          ? TextCapitalization.sentences
          : TextCapitalization.none,
      inputFormatters: [
        LengthLimitingTextInputFormatter(widget.inputLimit),
        if (widget.formatter == InputFormatter.stringOnly)
          FilteringTextInputFormatter.allow(RegExp("[a-zA-Z-]")),
        if (widget.formatter == InputFormatter.digitOnly)
          FilteringTextInputFormatter.allow(RegExp("[0-9]")),
        if (widget.formatter == InputFormatter.alphaNumericOnly)
          FilteringTextInputFormatter.allow(RegExp("[0-9a-zA-Z]")),
      ],
      keyboardType: widget.keyboardType,
      maxLines: widget.maxLines,
      validator: (value) =>
          widget.validate != null ? widget.validate!(value) : null,
      onSaved: (value) => widget.onSave != null ? widget.onSave!(value) : null,
      onFieldSubmitted: widget.onFieldSubmitted ?? (_) => dismissKeyboard(),
      onChanged: (value) =>
          widget.onchange != null ? widget.onchange!(value) : null,
      onTap: () => widget.onTap != null ? widget.onTap!() : null,
      onEditingComplete: () =>
          widget.onEditingComplete != null ? widget.onEditingComplete!() : null,
    );
  }

  void dismissKeyboard() {
    SystemChannels.textInput.invokeMethod('TextInput.hide');
    FocusManager.instance.primaryFocus?.unfocus();
  }
}

enum InputFormatter { stringOnly, digitOnly, alphaNumericOnly }
