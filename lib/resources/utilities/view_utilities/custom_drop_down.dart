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
  final Widget widget;

  const CustomDropdown(
      {super.key,
      required this.items,
      required this.value,
      required this.onChanged,
      required this.itemBuilder,
      this.itemSpacing = 8.0,
      this.textColor,
      this.arrowColor,
      required this.widget,
      this.onTap});

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<T>(
      padding: EdgeInsets.zero,
      onSelected: onChanged,
      surfaceTintColor: Colors.transparent,
      color: Colors.transparent,
      itemBuilder: (_) => List<PopupMenuEntry<T>>.generate(
        items.length,
        (index) => PopupMenuItem<T>(
          padding: EdgeInsets.only(left: 12),
          value: items[index],
          child: itemBuilder(items[index]),
          //  padding: EdgeInsets.symmetric(vertical: 8.0),
        ),
      ),

      // icon: Icon(Icons.arrow_drop_down,
      //     color: Colors.transparent), // Set arrow color
      //  dropdownColor: Colors.transparent,
      elevation: 0,
      position: PopupMenuPosition.under,
      child: widget,
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
      widget: Container(),
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
