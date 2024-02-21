import 'package:ame/resources/theme_utilities/app_colors.dart';
import 'package:ame/resources/theme_utilities/theme_extensions.dart';
import 'package:ame/resources/utilities/widget_extensions.dart';
import 'package:flutter/material.dart';

class DropdownExpansionTile extends StatefulWidget {
  final IdentityDocument? value;
  final String? labelText;
  final ValueChanged<String?>? onChanged;
  final InputDecoration decoration;
  final FormFieldValidator<String>? validator;
  final ValueChanged<IdentityDocument?>? onSaved;

  final Function(IdentityDocument) onDocSelected;

  DropdownExpansionTile({
    super.key,
    required this.value,
    required this.labelText,
    required this.decoration,
    required this.onDocSelected,
    this.validator,
    this.onChanged,
    this.onSaved,
  });

  @override
  DropdownExpansionTileState createState() => DropdownExpansionTileState();
}

class DropdownExpansionTileState extends State<DropdownExpansionTile> {
  bool isExpanded = false;
  IdentityDocument? selectedValue;

  @override
  void initState() {
    super.initState();
    selectedValue = widget.value;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        InkWell(
          onTap: () {
            setState(() {
              isExpanded = !isExpanded;
            });
          },
          child: InputDecorator(
            decoration: widget.decoration.copyWith(
              suffixIcon: Icon(
                isExpanded ? Icons.expand_less : Icons.expand_more,
              ),
            ),
            child: Text(
              selectedValue?.text ?? widget.labelText ?? "",
              style: selectedValue != null
                  ? TextStyle().bodyMedium.makeDefault
                  : TextStyle().bodyMedium.makeGrey,
            ),
          ),
        ),
        if (isExpanded)
          Column(
            children: IdentityDocument.values.map((item) {
              return GestureDetector(
                onTap: () {
                  selectedValue = item;
                  widget.onDocSelected(item);
                  isExpanded = !isExpanded;
                  setState(() {});
                },
                child: Container(
                  width: double.infinity,
                  margin: EdgeInsets.only(top: 16),
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                      border: Border.all(color: AppColors.typographySubColor),
                      borderRadius: BorderRadius.circular(8)),
                  child: Text(
                    item.text,
                    style: TextStyle().bodyMedium,
                  ),
                ),
              );
            }).toList(),
          ).spaceTo(top: 8),
      ],
    );
  }
}

enum IdentityDocument { votersCard, intPassword, driversLicence }

extension IdentityDocExt on IdentityDocument {
  String get value {
    switch (this) {
      case IdentityDocument.votersCard:
        return "VOTERS_CARD";
      case IdentityDocument.intPassword:
        return "INT_PASSPORT";
      case IdentityDocument.driversLicence:
        return "DRIVERS_LICENCE";
    }
  }

  String get text {
    switch (this) {
      case IdentityDocument.votersCard:
        return "National Voter's Card";
      case IdentityDocument.intPassword:
        return "International Passport";
      case IdentityDocument.driversLicence:
        return "Drivers Licence";
    }
  }
}
