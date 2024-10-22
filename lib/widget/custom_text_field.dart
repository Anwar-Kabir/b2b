// import 'package:flutter/material.dart';

// class CustomTextField extends StatelessWidget {
//   final String? labelText;
//   final TextEditingController controller;
//   final TextInputType keyboardType;
//   final FormFieldValidator<String>? validator;
//   final ValueChanged<String>? onChanged;
//   final bool isObscure;
//   final IconData? suffixIcon;
//   final IconData? prefixIcon;
//   final VoidCallback? onSuffixTap;
//   final int? maxLength;
//   final String? hintText;
//   final int? maxLines;

//   const CustomTextField(
//       {super.key,
//       this.labelText,
//       required this.controller,
//       this.keyboardType = TextInputType.text,
//       this.validator,
//       this.onChanged,
//       this.isObscure = false,
//       this.suffixIcon,
//       this.prefixIcon,
//       this.onSuffixTap,
//       this.maxLength,
//       this.hintText,
//       this.maxLines});

//   @override
//   Widget build(BuildContext context) {
//     return TextFormField(
//       controller: controller,
//       obscureText: isObscure,
//       keyboardType: keyboardType,
//       onChanged: onChanged,
//       validator: validator,
//       maxLength: maxLength,
//       maxLines: maxLines,
//       decoration: InputDecoration(
//         //labelText: labelText,
//         hintText: hintText,
//         border: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(10),
//         ),
//         suffixIcon: suffixIcon != null
//             ? IconButton(
//                 icon: Icon(suffixIcon),
//                 onPressed: onSuffixTap,
//               )
//             : null,
//         prefixIcon: prefixIcon != null ? Icon(prefixIcon) : null,
//       ),
//     );
//   }
// }




import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final String? labelText;
  final TextEditingController controller;
  final TextInputType keyboardType;
  final FormFieldValidator<String>? validator;
  final ValueChanged<String>? onChanged;
  final bool isObscure;
  final IconData? suffixIcon;
  final IconData? prefixIcon;
  final VoidCallback? onSuffixTap;
  final int? maxLength;
  final String? hintText;
  final int? maxLines;
  final List<DropdownMenuItem<String>>?
      dropdownItems; // Optional dropdown items
  final String? selectedDropdownValue; // Selected value for the dropdown
  final ValueChanged<String?>?
      onDropdownChanged; // Dropdown value change handler

  const CustomTextField({
    super.key,
    this.labelText,
    required this.controller,
    this.keyboardType = TextInputType.text,
    this.validator,
    this.onChanged,
    this.isObscure = false,
    this.suffixIcon,
    this.prefixIcon,
    this.onSuffixTap,
    this.maxLength,
    this.hintText,
    this.maxLines,
    this.dropdownItems, // Initialize dropdown items
    this.selectedDropdownValue, // Current selected value
    this.onDropdownChanged, // Handle dropdown value changes
  });

  @override
  Widget build(BuildContext context) {
    return dropdownItems != null && dropdownItems!.isNotEmpty
        ? DropdownButtonFormField<String>(
            value: selectedDropdownValue,
            items: dropdownItems,
            onChanged: onDropdownChanged,
            decoration: InputDecoration(
              hintText: hintText,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              prefixIcon: prefixIcon != null ? Icon(prefixIcon) : null,
            ),
          )
        : TextFormField(
            controller: controller,
            obscureText: isObscure,
            keyboardType: keyboardType,
            onChanged: onChanged,
            validator: validator,
            maxLength: maxLength,
            maxLines: maxLines,
            decoration: InputDecoration(
              hintText: hintText,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              suffixIcon: suffixIcon != null
                  ? IconButton(
                      icon: Icon(suffixIcon),
                      onPressed: onSuffixTap,
                    )
                  : null,
              prefixIcon: prefixIcon != null ? Icon(prefixIcon) : null,
            ),
          );
  }
}
