import 'package:flutter/material.dart';

class CustomDropDown<T> extends StatelessWidget {
  final T? value;
  final List<DropdownMenuItem<T>> itemsList;
  final Color? dropdownColor;
  final Function(dynamic value) onChanged;
  const CustomDropDown({
    super.key,
    this.value,
    required this.itemsList,
    this.dropdownColor,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20, top: 3, bottom: 3, right: 20),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.white,
        ),
        child: DropdownButtonHideUnderline(
          child: Padding(
            padding: const EdgeInsets.only(left: 14.0, right: 14),
            child: DropdownButton(
              isExpanded: true,
              dropdownColor: dropdownColor,
              value: value,
              items: itemsList,
              onChanged: (value) => onChanged(value),
            ),
          ),
        ),
      ),
    );
  }
}
