import 'package:flutter/material.dart';
import 'package:minews/services/data.dart';

class Categories extends StatefulWidget {
  final getHeadlines;
  const Categories({super.key, required this.getHeadlines});

  @override
  State<Categories> createState() => _CategoriesState();
}

class _CategoriesState extends State<Categories> {
  Data data_obj = Data();
  int current_category = 0;

  String capitalize(String str) => str[0].toUpperCase() + str.substring(1);

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 30,
        child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: data_obj.categoriesList.length,
            itemBuilder: (BuildContext context, int index) {
              return InkWell(
                onTap: () {
                  setState(() {
                    current_category = index;
                    data_obj.category =
                        data_obj.categoriesList[current_category];
                    // print(category);
                  });
                  widget.getHeadlines(data_obj.category);
                },
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(5, 0, 5, 0),
                  child: Container(
                    decoration: BoxDecoration(
                        border: index == current_category
                            ? const Border(
                                bottom:
                                    BorderSide(color: Colors.black, width: 2))
                            : const Border(bottom: BorderSide.none)),
                    child: Text(
                      capitalize(data_obj.categoriesList[index]),
                      style: TextStyle(
                        color: index == current_category
                            ? Colors.black
                            : Colors.grey.shade400,
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                  ),
                ),
              );
            }));
  }
}
