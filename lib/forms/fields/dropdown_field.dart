import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';

class DropDownField extends StatelessWidget {
  final List<String> items;
  final validator;
  final String labelTextOne;
  final String labelTextTwo;
  final String labelTextThree;
  final onChanged;
  final selectedItem;

  const DropDownField(
      {Key? key,
      required this.items,
      required this.validator,
      required this.labelTextOne,
      required this.labelTextTwo,
      required this.labelTextThree,
      required this.onChanged,
      this.selectedItem})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 25, bottom: 5),
      child: DropdownSearch<String>(
        items: items,
        selectedItem: selectedItem,
        validator: validator,
        mode: Mode.DIALOG,
        dropdownSearchDecoration: InputDecoration(
          labelText: labelTextOne,
          labelStyle: TextStyle(color: Colors.black, fontSize: 18),
          contentPadding: EdgeInsets.fromLTRB(10, 10, 0, 0),
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
            color: Colors.green,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10),
              topRight: Radius.circular(10),
            ),
          ),
          child: Center(
            child: Text(
              labelTextThree,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.white,
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
