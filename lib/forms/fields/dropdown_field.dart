import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';

class DropDownField extends StatelessWidget {
  final List<String> items;
  final validator;
  final String labelTextOne;
  final String labelTextTwo;

  final onChanged;
  final icon;
  final selectedItem;

  const DropDownField(
      {Key? key,
      required this.items,
      required this.validator,
      required this.labelTextOne,
      required this.labelTextTwo,
      required this.onChanged,
      required this.icon,
      this.selectedItem})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 25, bottom: 5),
      child: DropdownSearch<String>(
        showAsSuffixIcons: true,
        items: items,
        selectedItem: selectedItem,
        validator: validator,
        mode: Mode.DIALOG,
        dropdownSearchDecoration: InputDecoration(
          labelText: labelTextOne,
          labelStyle: TextStyle(color: Colors.black, fontSize: 20),
          contentPadding: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
          border: OutlineInputBorder(),
        ),
        onChanged: onChanged,
        showSearchBox: true,
        searchFieldProps: TextFieldProps(
          decoration: InputDecoration(
            prefixIcon: Icon(Icons.search),
            border: OutlineInputBorder(),
            contentPadding: EdgeInsets.fromLTRB(12, 12, 8, 0),
            labelText: labelTextTwo,
          ),
        ),
        popupTitle: Container(
          height: 60,
          decoration: BoxDecoration(
            color: Colors.purple,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10),
              topRight: Radius.circular(10),
            ),
          ),
          child: Center(
            child: FittedBox(
              fit: BoxFit.fitWidth,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "${labelTextOne} ",
                    style: TextStyle(
                      fontSize: 23,
                      fontWeight: FontWeight.w800,
                      color: Colors.white,
                    ),
                  ),
                  icon
                ],
              ),
            ),
          ),
        ),
        popupShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(10),
          ),
        ),
      ),
    );
  }
}
