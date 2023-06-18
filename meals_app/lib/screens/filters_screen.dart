import 'package:flutter/material.dart';
import '../widgets/main_drawer.dart';

class FiltersScreen extends StatefulWidget {
  static const routeName = "/filters";

  final Map<String, bool> currentSelectedFilter;
  final Function saveFilters;
  FiltersScreen(this.currentSelectedFilter, this.saveFilters);

  @override
  State<FiltersScreen> createState() => _FiltersScreenState();
}

class _FiltersScreenState extends State<FiltersScreen> {
  bool _glutenFree = false;
  bool _vegetarian = false;
  bool _vegan = false;
  bool _lactoseFree = false;

  @override
  void initState() {
    _glutenFree = widget.currentSelectedFilter["gluten"] as bool;
    _lactoseFree = widget.currentSelectedFilter["lactose"] as bool;
    _vegetarian = widget.currentSelectedFilter["vegetarian"] as bool;
    _vegan = widget.currentSelectedFilter["vegan"] as bool;
    super.initState();
  }

  Widget _buildSwitchListTile(
      String title, String description, bool currentVal, Function updateValue) {
    return SwitchListTile(
      title: Text(title),
      value: currentVal,
      subtitle: Text(description),
      onChanged: (bool val) => updateValue(val),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Your Filters"),
          actions: [
            IconButton(
              onPressed: () {
                final selectedFilters = {
                  "gluten": _glutenFree,
                  "lactose": _lactoseFree,
                  "vegan": _vegan,
                  "vegetarian": _vegetarian,
                };
                widget.saveFilters(selectedFilters);
              },
              icon: Icon(Icons.save),
            )
          ],
        ),
        drawer: MainDrawer(),
        body: Column(
          children: [
            Container(
              padding: EdgeInsets.all(20),
              child: Text(
                "Adjust your meal selection.",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Expanded(
                child: ListView(
              children: [
                _buildSwitchListTile(
                  "Gluten-free",
                  "Only include gluten-free meals.",
                  _glutenFree,
                  (newValue) {
                    setState(() {
                      _glutenFree = newValue;
                    });
                  },
                ),
                _buildSwitchListTile(
                  "Lactose-free",
                  "Only include lactose-free meals.",
                  _lactoseFree,
                  (newValue) {
                    setState(() {
                      _lactoseFree = newValue;
                    });
                  },
                ),
                _buildSwitchListTile(
                  "Vegetarian",
                  "Only include vegetarian meals.",
                  _vegetarian,
                  (newValue) {
                    setState(() {
                      _vegetarian = newValue;
                    });
                  },
                ),
                _buildSwitchListTile(
                  "Vegan",
                  "Only include vegan meals.",
                  _vegan,
                  (newValue) {
                    setState(() {
                      _vegan = newValue;
                    });
                  },
                ),
              ],
            ))
          ],
        ));
  }
}
