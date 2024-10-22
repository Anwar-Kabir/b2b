part of '../create_attribute_page.dart';

class _LabelWithRequirement extends StatelessWidget {
 const _LabelWithRequirement({
    required this.labelText,
    this.isRequired = false,
  });

  final String labelText;
  final bool isRequired;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(labelText,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        if (isRequired) const Text('*', style: TextStyle(color: Colors.red)),
      ],
    );
  }
}
