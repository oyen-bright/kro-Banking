import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kro_banking/extentions/on_context.dart';
import 'package:kro_banking/mixins/validation.dart';
import 'package:responsive_builder/responsive_builder.dart';

class AppTextInput extends StatefulWidget {
  const AppTextInput(
      {super.key,
      required this.controller,
      required this.title,
      this.focusNode,
      this.titleAction,
      this.onChanged,
      this.validate = true,
      this.nextFocusNode,
      this.textCapitalization = TextCapitalization.none,
      this.keyboardType,
      this.validator,
      this.helperText,
      this.obscureText = false,
      this.autofillHints,
      this.maxLength,
      this.inputFormatters,
      this.isPasswordField = false,
      this.onFieldSubmitted});

  final TextEditingController controller;
  final String title;
  final Widget? titleAction;
  final bool obscureText;
  final FocusNode? focusNode;
  final FocusNode? nextFocusNode;
  final TextCapitalization textCapitalization;
  final TextInputType? keyboardType;
  final String? helperText;
  final bool validate;
  final Iterable<String>? autofillHints;
  final void Function(String)? onChanged;
  final int? maxLength;
  final List<TextInputFormatter>? inputFormatters;
  final String? Function(String?)? validator;
  final bool isPasswordField;
  final void Function(String)? onFieldSubmitted;

  @override
  State<AppTextInput> createState() => _AppTextInputState();
}

class _AppTextInputState extends State<AppTextInput> with ValidationMixin {
  bool obscureText = true;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              widget.title,
              style: context.theme.textTheme.titleSmall,
            ),
            if (widget.titleAction != null) widget.titleAction!
          ],
        ),
        SizedBox(
          height: 0.5.sh,
        ),
        TextFormField(
          onChanged: widget.onChanged,
          inputFormatters: widget.inputFormatters,
          autofillHints: widget.autofillHints,
          onFieldSubmitted: widget.onFieldSubmitted,
          obscureText:
              widget.isPasswordField ? obscureText : widget.obscureText,
          validator:
              widget.validate ? widget.validator ?? requiredValidation : null,
          focusNode: widget.focusNode,
          onEditingComplete: widget.nextFocusNode != null
              ? () => FocusScope.of(context).requestFocus(widget.nextFocusNode)
              : null,
          textCapitalization: widget.textCapitalization,
          keyboardType: widget.keyboardType,
          controller: widget.controller,
          maxLength: widget.maxLength,
          decoration: InputDecoration(
            // focusedBorder: InputBorder.none,
            border: const OutlineInputBorder(),
            suffixIcon: widget.isPasswordField
                ? Builder(builder: (context) {
                    return IconButton(
                      icon: Icon(
                          !obscureText
                              ? Icons.visibility
                              : Icons.visibility_off,
                          color: Colors.grey),
                      onPressed: () {
                        setState(() {
                          obscureText = !obscureText;
                        });
                      },
                    );
                  })
                : null,
            filled: true,
            helperText: widget.helperText,
          ),
        )
      ],
    );
  }
}
