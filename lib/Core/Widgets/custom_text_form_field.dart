import 'package:flutter/material.dart';
import 'package:taxi/Core/Utils/Constants/color_constants.dart';

import 'custom_text.dart';

// ignore: must_be_immutable
class CustomTextFormField extends StatelessWidget {
  final String? text;
  final TextEditingController controller;
  final String? hint;
  final bool isPasswordField;
  bool isPasswordVisible = false;
  final Function onSave;
  final Function validator;
  final Function? toggelPasswordFunction;
  final FocusNode? focusNode;

  CustomTextFormField(
      {super.key,
      this.text,
      this.hint,
      required this.controller,
      required this.isPasswordField,
      this.isPasswordVisible = false,
      required this.onSave,
      required this.validator,
      this.toggelPasswordFunction,
      this.focusNode});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomText(
          text: text!,
          fontSize: 14,
          color: ColorConstants.logoColor2,
        ),
        TextFormField(
          controller: controller,
          obscureText: (isPasswordField) ? !isPasswordVisible : false,
          validator: (value) => validator(value),
          focusNode: focusNode,
          onEditingComplete: () {
            // Move focus to next TextFormField widget
            FocusScope.of(context).nextFocus();
          },
          decoration: InputDecoration(
            focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: ColorConstants.buttonColor2)),
            suffix: (isPasswordField)
                ? InkWell(
                    onTap: () => toggelPasswordFunction!(),
                    child: (isPasswordVisible)
                        ? Icon(
                            Icons.visibility,
                            color: ColorConstants.buttonColor2,
                          )
                        : Icon(
                            Icons.visibility_off,
                            color: Colors.grey.withOpacity(0.5),
                          ),
                  )
                : null,
            hintText: hint,
            hintStyle: const TextStyle(
              color: Colors.black54,
            ),
            fillColor: Colors.white,
          ),
        )
      ],
    );
  }
}

class CustomTextFormFieldForPhone extends StatelessWidget {
  final String? text;

  final String? hint;

  final Function onSave;
  final Function validator;
  final TextInputType textInputType;

  const CustomTextFormFieldForPhone({
    super.key,
    this.text,
    this.hint,
    this.textInputType = TextInputType.phone,
    required this.onSave,
    required this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomText(
          text: text!,
          fontSize: 14,
          color: Colors.grey.shade800,
        ),
        TextFormField(
          onSaved: (value) => onSave(value),
          validator: (value) => validator(value),
          keyboardType: textInputType,
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: const TextStyle(
              color: Colors.black54,
            ),
            fillColor: Colors.white,
          ),
        )
      ],
    );
  }
}
