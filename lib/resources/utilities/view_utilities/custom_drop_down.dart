import 'package:ame/resources/theme_utilities/theme_extensions.dart';
import 'package:ame/resources/utilities/view_utilities/view_util.dart';
import 'package:flutter/material.dart';

class CustomDropdown<T> extends StatelessWidget {
  final List<T> items;
  final T value;
  final ValueChanged<T?> onChanged;
  final Widget Function(T) itemBuilder;
  final double itemSpacing;
  final Color? textColor;
  final Color? arrowColor;
  final VoidCallback? onTap;

  CustomDropdown(
      {required this.items,
      required this.value,
      required this.onChanged,
      required this.itemBuilder,
      this.itemSpacing = 8.0,
      this.textColor,
      this.arrowColor,
      this.onTap});

  @override
  Widget build(BuildContext context) {
    return DropdownButtonHideUnderline(
      child: DropdownButton<T>(
        value: value,
        isDense: false, isExpanded: true,
        onTap: () {},
        onChanged: onChanged,
        focusColor: Colors.blue,
        items: List.generate(
          items.length,
          (index) => DropdownMenuItem<T>(
            value: items[index],
            child: itemBuilder(items[index]),
            //  padding: EdgeInsets.symmetric(vertical: 8.0),
          ),
        ),
        selectedItemBuilder: (_) =>
            items.map((item) => itemBuilder(item)).toList(),
        style: TextStyle(
          color: textColor, // Set text color
        ),
        icon: Icon(Icons.arrow_drop_down,
            color: Colors.transparent), // Set arrow color
        dropdownColor: Colors.transparent,
        elevation: 0,
      ),
    );
  }
}

class AppCustomDropDown extends StatefulWidget {
  const AppCustomDropDown({super.key});

  @override
  State<AppCustomDropDown> createState() => _AppCustomDropDownState();
}

class _AppCustomDropDownState extends State<AppCustomDropDown> {
  late String selectedValue;

  @override
  void initState() {
    super.initState();
    selectedValue = 'Option 1';
  }

  @override
  Widget build(BuildContext context) {
    return CustomDropdown<String>(
      value: selectedValue,
      onChanged: (newValue) {
        setState(() {
          selectedValue = newValue ?? selectedValue;
        });
      },
      items: ['Option 1', 'Option 2', 'Option 3'],
      itemBuilder: (item) => ViewUtil.customOutlineContainer(
        // margin: EdgeInsets.only(bottom: 12.0),
        width: 100,
        borderRadius: 20,
        backgroundColor: Colors.red,
        child: Center(
          child: Text(
            item,
            style: TextStyle().bodySmall.makeWhite,
          ),
        ),
      ),
      itemSpacing: 26.0,
      textColor: Colors.blue, // Set text color
      arrowColor: Colors.red, // Set arrow color
    );
  }
}
