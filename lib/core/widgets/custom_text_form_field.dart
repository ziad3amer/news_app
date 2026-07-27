import 'package:flutter/material.dart';
import 'package:news_app/core/constans/app_size.dart';

class CustomTextFormField extends StatefulWidget {
  const CustomTextFormField({
    super.key,
    required this.controller,
    required this.hintText,
    required this.title,
    this.validator,
    this.maxLine = 1,
    this.suffix,
    this.obscureText = false,
  });

  final TextEditingController controller;
  final String title;
  final String hintText;
  final int? maxLine;
  final Function(String?)? validator;
  final Widget? suffix;
  final bool obscureText;

  @override
  State<CustomTextFormField> createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
  bool _isVisible = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(widget.title, style: Theme.of(context).textTheme.titleMedium),
        SizedBox(height: AppSize.ph8),
        TextFormField(
          controller: widget.controller,
          maxLines: widget.maxLine,
          style: Theme.of(context).textTheme.labelMedium,
          minLines: widget.maxLine,
          validator: widget.validator != null
              ? (String? value) => widget.validator!(value)
              : null,
          //true , true ,
          obscureText: widget.obscureText && !_isVisible,
          decoration: InputDecoration(
            hintText: widget.hintText,
            suffixIcon: widget.obscureText
                ? IconButton(
                    onPressed: () {
                      setState(() {
                        _isVisible = !_isVisible;
                      });
                    },
                    icon: _isVisible
                        ? Icon(Icons.visibility)
                        : Icon(Icons.visibility_off),
                  )
                : null,
          ),
        ),
      ],
    );
  }
}
