import 'package:flutter/material.dart';

class CustomDropdownButtonFormField extends StatelessWidget {
  final String hintText;
  final String? labelText;
  final String? topLabelText;
  final IconData? prefixIcon;
  final bool? isRequired;
  final ValueChanged<String?>? onChanged;
  final String? errorText;
  final List<String> items;
  final String? initialValue;
  final bool? enabled;
  final bool? isLogin;
  final String? Function(String?)? validator;

  const CustomDropdownButtonFormField({
    super.key,
    required this.hintText,
    required this.items,
    this.initialValue,
    this.labelText,
    this.topLabelText,
    this.prefixIcon,
    this.isRequired,
    this.onChanged,
    this.errorText,
    this.enabled,
    this.isLogin,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        topLabelText == null
            ? const SizedBox()
            : Text(
                topLabelText!,
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.black.withOpacity(0.5),
                ),
              ),
        const SizedBox(
          height: 5,
        ),
        DropdownButtonFormField<String>(
          value: initialValue ?? (items.isNotEmpty ? items[0] : null),
          onChanged: enabled ?? true ? onChanged : null,
          items: items.map((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
          decoration: InputDecoration(
            labelText: labelText,
            hintText: hintText,
            prefixIcon: prefixIcon != null
                ? Icon(prefixIcon, color: Colors.black.withOpacity(0.5))
                : null,
            filled: true,
            fillColor: Colors.white,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: const BorderSide(
                color: Colors.transparent,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: BorderSide(
                color: Colors.black.withOpacity(0.2),
              ),
            ),
          ),
          validator: isRequired == true
              ? (value) {
                  if (value == null || value.isEmpty) {
                    return 'This field is required';
                  }
                  return null;
                }
              : validator,
          hint: Text(
            hintText,
            style: TextStyle(color: Colors.black.withOpacity(0.5)),
          ),
        ),
        if (errorText != null) ...[
          const SizedBox(height: 5),
          Text(
            errorText!,
            style: TextStyle(color: Colors.red, fontSize: 12),
          ),
        ],
      ],
    );
  }
}
