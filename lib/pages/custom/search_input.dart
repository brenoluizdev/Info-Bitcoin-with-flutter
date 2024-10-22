import 'package:flutter/material.dart';
import 'package:info_bitcoin/pages/custom/colors.dart';

class CustomSearchInput extends StatelessWidget {
  final TextEditingController controller;
  final String? labelText;
  final String? hintText;
  final Icon? prefixIcon;

  const CustomSearchInput({
    super.key,
    required this.controller,
    this.hintText,
    this.prefixIcon,
    this.labelText,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Row(
            children: [
              Expanded(
                child: Container(
                  margin: const EdgeInsets.all(10.0),
                  child: TextFormField(
                    decoration: InputDecoration(
                      focusColor: CustomColors.white,
                      fillColor: CustomColors.inputBackground,
                      filled: true,
                      contentPadding: const EdgeInsets.all(15.0),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30.0),
                        borderSide: const BorderSide(
                          color: CustomColors.grey,
                          width: 2.0,
                        ),
                      ),
                      prefixIcon: prefixIcon,
                      iconColor: CustomColors.inputIconColor,
                      labelText: labelText,
                      hintStyle: const TextStyle(color: CustomColors.inputTextColor, fontSize: 16.0, fontWeight: FontWeight.w500),
                      hintText: hintText,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30.0),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
