import 'package:flutter/material.dart';

class Formulario {
  static Widget campoTexto({
    required TextEditingController controller,
    required String label,
    required IconData icone,
    String? Function(String?)? validator,
  }) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        border: const OutlineInputBorder(),
        prefixIcon: Icon(icone),
      ),

      validator: validator,
    );
  }

  static Widget campoCheckbox({
    required bool valor,
    required String texto,
    required ValueChanged<bool?> onChanged,
  }) {
    return CheckboxListTile(
      value: valor,
      onChanged: onChanged,
      title: Text(texto)
    );
  }
}