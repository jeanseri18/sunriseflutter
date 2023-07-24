import 'package:sunrise_hosting/gen/colors.gen.dart';
import 'package:sunrise_hosting/features/home/home_parent_page.dart';
import 'package:flutter/material.dart';

class TextFieldWidget extends StatelessWidget {
  const TextFieldWidget(
      {Key? key,
      required this.title,
      required this.controller,
      required this.hint,
      required this.icon,
      required this.keyboardType,
      required this.isObscure,
      this.sufficon,
      this.isBold,
      this.iscircular})
      : super(key: key);

  final String title;
  final TextEditingController? controller;
  final String hint;
  final Widget icon;
  final TextInputType? keyboardType;
  final bool isObscure;
  final Widget? sufficon;
  final bool? isBold;
  final bool? iscircular;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        const SizedBox(
          height: 20,
        ),
        isBold == true
            ? Text(title,
                style: const TextStyle(
                    fontSize: 15,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.bold))
            : Text(
                title,
                style: const TextStyle(
                  fontSize: 15,
                  fontFamily: 'Poppins',
                ),
                textAlign: TextAlign.start,
              ),
        const SizedBox(
          height: 5,
        ),
        TextFormField(
          keyboardType: keyboardType,
          obscureText: isObscure,
          decoration: InputDecoration(
            suffix: sufficon,
            prefixIcon: icon,
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
              borderSide:
                  const BorderSide(width: 1, color: ColorName.orangeTwins),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
              borderSide: const BorderSide(width: 1, color: ColorName.btnGray),
            ),
            hintText: hint,
          ),
          validator: (value) {
            if (value!.isEmpty) {
              return 'Ce champ ne peut etre vide';
            }

            return null;
          },
          controller: controller,
        ),
      ],
    );
  }
}
