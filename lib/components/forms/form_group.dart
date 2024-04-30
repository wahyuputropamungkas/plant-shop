import 'package:flutter/material.dart';
import 'package:plantshop/components/forms/form_label.dart';

class FormGroup extends StatelessWidget {

  const FormGroup({
    super.key,
    required this.label,
    required this.form
  });

  final String label;
  final Widget form;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        FormLabel(
          label: label,
        ),
        const SizedBox(
          height: 12,
        ),
        form
      ],
    );
  }

}