import 'package:demo/constants.dart';
import 'package:demo/models/list_item.dart';
import 'package:flutter/material.dart';

class DropDownMenu extends StatefulWidget {
  final List<ListItem> dropdownItems;
  final Function onChanged;
  DropDownMenu({this.dropdownItems, this.onChanged});

  @override
  _DropDownMenuState createState() => _DropDownMenuState();
}

class _DropDownMenuState extends State<DropDownMenu> {
  List<DropdownMenuItem<ListItem>> _dropdownMenuItems;
  ListItem _selectedItem;

  List<DropdownMenuItem<ListItem>> buildDropDownMenuItems(List listItems) {
    List<DropdownMenuItem<ListItem>> items = List();
    for (ListItem listItem in listItems) {
      items.add(
        DropdownMenuItem(
          child: Text(listItem.name),
          value: listItem,
        ),
      );
    }
    return items;
  }

  void initState() {
    super.initState();
    _dropdownMenuItems = buildDropDownMenuItems(widget.dropdownItems);
    _selectedItem = _dropdownMenuItems[0].value;
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 10.0),
        child: Container(
          width: size.width * 0.8,
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 5.0),
          decoration: BoxDecoration(
            color: kSecondaryColor,
            borderRadius: BorderRadius.circular(29),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton(
              style: TextStyle(color: Colors.grey[700], fontSize: 15.0),
              dropdownColor: kSecondaryColor,
                value: _selectedItem,
                items: _dropdownMenuItems,
                onChanged: (value) {
                  setState(() {
                    _selectedItem = value;
                    widget.onChanged(value);
                  });
              }
              ),
          ),
        ),
    );
  }
}
