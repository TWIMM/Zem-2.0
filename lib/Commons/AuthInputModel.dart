import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomInputField extends StatelessWidget {
  final TextEditingController controller;
  final onChanged;
  final String labelText;
  final bool isError;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final bool? obscureText;
  final InputBorder? border;
  final TextStyle? labelStyle;
  final bool? enabled;
  final TextInputType? keyboardType;
  final List<TextInputFormatter>? inputFormatters;
  final FocusNode? focusNode; // Added focusNode parameter

  const CustomInputField({
    Key? key,
    required this.controller,
    required this.labelText,
    required this.isError,
    this.suffixIcon,
    this.prefixIcon,
    this.onChanged,
    this.obscureText,
    this.border,
    this.labelStyle,
    this.enabled,
    this.keyboardType,
    this.inputFormatters,
    this.focusNode, // Added focusNode parameter
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      onChanged: onChanged,
      enabled: enabled,
      style: TextStyle(color: Colors.white),
      obscureText: obscureText ?? false,
      decoration: InputDecoration(
        labelText: labelText,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15.0),
          borderSide: BorderSide(
            color: isError ? Colors.red : Colors.white,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15.0),
          borderSide: BorderSide(
            color: isError ? Colors.red : Colors.white,
          ),
        ),
        suffixIcon: suffixIcon,
        prefixIcon: prefixIcon,
        errorStyle: TextStyle(color: Colors.white),
        fillColor: const Color.fromARGB(255, 184, 180, 180).withOpacity(0.2),
        filled: true,
        labelStyle: labelStyle,
        border: InputBorder.none,
      ),
      inputFormatters: inputFormatters,
      keyboardType: keyboardType,
      focusNode: focusNode, // Set the provided focusNode
    );
  }
}

class CustomBuyerSellerField extends StatelessWidget {
  final bool isError;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final String labelText;

  const CustomBuyerSellerField({
    Key? key,
    required this.isError,
    required this.labelText,
    this.suffixIcon,
    this.prefixIcon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15.0),
        border: Border.all(
          color: isError ? Colors.red : Colors.white,
        ),
        color: const Color.fromARGB(255, 184, 180, 180).withOpacity(0.2),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          if (prefixIcon != null)
            Padding(padding: EdgeInsets.all(8.0), child: prefixIcon),
          Expanded(
            child: TextField(
              decoration: InputDecoration(
                labelText: labelText, // Use labelText for the label
                border: InputBorder.none,
                labelStyle: TextStyle(color: Colors.white),
              ),
              enabled: false,
            ),
          ),
          if (suffixIcon != null)
            Padding(padding: EdgeInsets.all(8.0), child: suffixIcon),
        ],
      ),
    );
  }
}

// ignore: must_be_immutable
class CustomSearch extends StatefulWidget {
  final TextEditingController controller;
  final String labelText;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final bool? obscureText;
  final InputBorder? border;
  final TextStyle? labelStyle;
  final bool? enabled;
  final int? maxLength;
  final TextInputType? keyboardType;
  final TextStyle? textStyle;
  final OutlineInputBorder? customEnabledBorder;
  final OutlineInputBorder? customFocusedBorder;
  final Color? fillColor;
  final BoxShadow? boxShadow;
  final double? width;
  final double? height;
  final String? Function(String?)? validator;
  bool isError;
  final List<DropdownMenuItem<String>>? dropdownItems;
  final String? dropdownValue;
  final Function(String)? onChanged;
  final Function(String?)? dropdownOnChanged;

  CustomSearch({
    Key? key,
    required this.controller,
    required this.labelText,
    this.suffixIcon,
    this.prefixIcon,
    this.obscureText,
    this.border,
    this.labelStyle,
    this.enabled,
    this.maxLength,
    this.keyboardType,
    this.textStyle,
    this.customEnabledBorder,
    this.customFocusedBorder,
    this.fillColor,
    this.boxShadow,
    this.width,
    this.height,
    this.validator,
    this.dropdownItems,
    this.dropdownValue,
    this.dropdownOnChanged,
    this.onChanged,
    this.isError = false,
  }) : super(key: key);

  @override
  _CustomInputFieldState createState() => _CustomInputFieldState();
}

class _CustomInputFieldState extends State<CustomSearch> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.width,
      height: widget.height,
      decoration: BoxDecoration(
        boxShadow: widget.boxShadow != null
            ? [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 2,
                  blurRadius: 4,
                  offset: Offset(0, 2),
                ),
              ]
            : [],
      ),
      child: Stack(
        alignment: Alignment.centerRight,
        children: [
          if (widget.dropdownItems != null)
            DropdownButtonHideUnderline(
              child: DropdownButtonFormField<String>(
                value: widget.dropdownValue,
                items: widget.dropdownItems!,
                onChanged: widget.dropdownOnChanged,
              ),
            ),
          TextFormField(
            controller: widget.controller,
            onChanged: widget.onChanged!(widget.controller.text),

            enabled: widget.enabled,
            style: widget.textStyle ?? TextStyle(color: Colors.black),
            obscureText: widget.obscureText ?? false,
            decoration: InputDecoration(
              labelText: widget.labelText,
              enabledBorder: widget.customEnabledBorder ??
                  OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15.0),
                    borderSide: BorderSide(
                      color: widget.isError ? Colors.red : Colors.white,
                    ),
                  ),
              floatingLabelBehavior: FloatingLabelBehavior.never,
              focusedBorder: widget.customFocusedBorder ??
                  OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15.0),
                    borderSide: BorderSide(
                      color: widget.isError ? Colors.red : Colors.white,
                    ),
                  ),
              suffixIcon: widget.suffixIcon,
              prefixIcon: widget.prefixIcon,
              errorStyle: TextStyle(color: Colors.white),
              fillColor: widget.fillColor ??
                  Color.fromARGB(255, 57, 57, 57).withOpacity(0.9),
              filled: true,
              labelStyle: widget.labelStyle,
              border: InputBorder.none,
            ),
            maxLength: widget.maxLength,
            // keyboardType: widget.keyboardType,
          ),
        ],
      ),
    );
  }
}
