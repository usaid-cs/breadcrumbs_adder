import 'dart:collection';

import 'package:flutter/material.dart';

class BreadCrumbs {
  final String name;
  bool isActive = false;

  BreadCrumbs({required this.name, required this.isActive});

  void activate() {
    isActive = true;
  }

  void unActivate() {
    isActive = false;
  }

  String get title => name + (isActive ? '>' : '');
}

class BreadCrumbsProvider extends ChangeNotifier {
  final List<BreadCrumbs> BreadCrumbsList = [];
  UnmodifiableListView<BreadCrumbs> get items =>
      UnmodifiableListView(BreadCrumbsList);

  void addBreadCrumb(BreadCrumbs breadCrumb) {
    for (var item in items) {
      item.activate();
    }

    BreadCrumbsList.add(breadCrumb);
    notifyListeners();
  }

  void undoBreadCrumb() {
    if (BreadCrumbsList.isNotEmpty) {
      BreadCrumbsList.remove(BreadCrumbsList.last);
      items.last.unActivate();
      notifyListeners();
    }
  }

  void resetBradCrumbList() {
    if (BreadCrumbsList.isNotEmpty) {
      BreadCrumbsList.clear();
      notifyListeners();
    }
  }
}

class BreadCrumbsWidget extends StatelessWidget {
  final UnmodifiableListView<BreadCrumbs> BreadCrumbsList;
  BreadCrumbsWidget({required this.BreadCrumbsList, super.key});

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: BreadCrumbsList.map((breadCrumb) {
        return GestureDetector(
          onTap: () {
            showModalBottomSheet(
              context: context,
              builder: (context) {
                return Center(
                  heightFactor: 5,
                  child: Container(
                    padding: EdgeInsets.all(10),
                    child: Text(breadCrumb.title),
                  ),
                );
              },
            );
          },
          child: Text(
            breadCrumb.title,
            style: TextStyle(
              color: breadCrumb.isActive ? Colors.blue : Colors.black,
            ),
          ),
        );
      }).toList(),
    );
  }
}
