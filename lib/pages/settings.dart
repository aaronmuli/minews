import 'package:flutter/material.dart';
import 'package:minews/services/data.dart';

class Settings extends StatefulWidget {
  const Settings({super.key});

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  Data data_obj = Data();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.0),
            child: Text(
              "Sort by",
              style: TextStyle(
                fontSize: 16,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              children: [
                Container(
                  width: 170,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      border:
                          Border.all(width: 1, color: Colors.grey.shade200)),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton(
                      style: const TextStyle(
                        fontSize: 14,
                        color: Colors.black,
                      ),
                      focusColor: Colors.grey.shade200,
                      isExpanded: true,
                      value: data_obj.sortbyList[data_obj.sortValue],
                      onChanged: (String? val) {
                        setState(() {
                          data_obj.sortValue =
                              data_obj.sortbyList.indexOf(val!);
                        });
                      },
                      items: data_obj.sortbyList
                          .map<DropdownMenuItem<String>>((String val) {
                        return DropdownMenuItem<String>(
                          value: val,
                          child: Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 8.0),
                            child: Text(val),
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.0),
            child: Text(
              "Language",
              style: TextStyle(
                fontSize: 16,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              children: [
                Container(
                  // padding: EdgeInsets.symmetric(horizontal: 3),
                  width: 170,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      border:
                          Border.all(width: 1, color: Colors.grey.shade200)),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton(
                      focusColor: Colors.grey.shade200,
                      isExpanded: true,
                      style: const TextStyle(
                        fontSize: 14,
                        color: Colors.black,
                      ),
                      value: data_obj.language ?? "English",
                      onChanged: (String? val) {
                        setState(() {
                          data_obj.language = val;
                          // data_obj.languageCode = data_obj.langs[val]!;
                          // print(data_obj.languageCode);
                        });
                      },
                      items: data_obj.languagesList
                          .map<DropdownMenuItem<String>>((String val) {
                        return DropdownMenuItem<String>(
                          value: val,
                          child: Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 8.0),
                            child: Text(val),
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.0),
            child: Text(
              "Sources",
              style: TextStyle(
                fontSize: 16,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Container(
              width: 170,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  border: Border.all(width: 1, color: Colors.grey.shade200)),
              child: DropdownButtonHideUnderline(
                child: DropdownButton(
                  focusColor: Colors.grey.shade200,
                  isExpanded: true,
                  style: const TextStyle(
                    fontSize: 14,
                    color: Colors.black,
                  ),
                  value: data_obj.source ?? "Any",
                  onChanged: (String? val) {
                    setState(() {
                      data_obj.source = val;
                    });
                  },
                  items: data_obj.news_sourcesList
                      .map<DropdownMenuItem<String>>((String val) {
                    return DropdownMenuItem<String>(
                      value: val,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Text(val),
                      ),
                    );
                  }).toList(),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
