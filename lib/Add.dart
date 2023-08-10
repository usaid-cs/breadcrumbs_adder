import 'package:breadcrumbs/BreadCrumbs.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddBreadCrumb extends StatefulWidget {
  const AddBreadCrumb({super.key});

  @override
  State<AddBreadCrumb> createState() => _AddBreadCrumbState();
}

class _AddBreadCrumbState extends State<AddBreadCrumb> {
  TextEditingController textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Add Breadcrump")),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: MediaQuery.of(context).size.width * 0.70,
                child: TextField(
                  controller: textController,
                  decoration: const InputDecoration(
                    hintText: "Device, Country, etc.",
                    label: Text("Enter Text"),
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              ElevatedButton(
                  onPressed: () {
                    final BreadCrumbs breadcrumb =
                        BreadCrumbs(name: textController.text, isActive: false);
                    context
                        .read<BreadCrumbsProvider>()
                        .addBreadCrumb(breadcrumb);
                    Navigator.pop(context);
                  },
                  child: Text("Add"))
            ],
          ),
        ),
      ),
    );
  }
}
