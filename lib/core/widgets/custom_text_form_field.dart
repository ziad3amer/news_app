import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField({
    super.key,
    required this.controller,
    required this.hintText,
    required this.title,
    this.validator,
    this.maxLine,
    this.suffix,
  });

  final TextEditingController controller;
  final String title;
  final String hintText;
  final int? maxLine;
  final Function(String?)? validator;
  final Widget? suffix;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: Theme.of(context).textTheme.titleMedium),
        SizedBox(height: 8),
        TextFormField(
          controller: controller,
          maxLines: maxLine,
          style: Theme.of(context).textTheme.labelMedium,
          decoration: InputDecoration(
              hintText: hintText,
            suffix: suffix,


          ),
          validator: validator != null
              ? (String? value) => validator!(value)
              : null,
        ),
      ],
    );
  }
}
