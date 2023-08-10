import 'package:flutter/material.dart';
import 'BreadCrumbs.dart';
import 'Add.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(ChangeNotifierProvider(
      create: (context) => BreadCrumbsProvider(),
      child: const BreadCrumbsApp()));
}

class BreadCrumbsApp extends StatelessWidget {
  const BreadCrumbsApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
      routes: {
        '/add': (context) => const AddBreadCrumb(),
      },
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("BreadCrumbs"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
          Card(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Consumer<BreadCrumbsProvider>(
                builder: ((context, value, child) {
                  return value.items.isEmpty
                      ? Text("Click Add to insert Breadcrumbs")
                      : BreadCrumbsWidget(
                          BreadCrumbsList: value.items,
                        );
                }),
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          ButtonBar(
            children: [
              ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pushNamed('/add');
                  },
                  child: const Text("Add BreadCrumb")),
              ElevatedButton(
                  onPressed: () {
                    context.read<BreadCrumbsProvider>().undoBreadCrumb();
                  },
                  child: const Text("Undo")),
              ElevatedButton(
                  onPressed: () {
                    context.read<BreadCrumbsProvider>().resetBradCrumbList();
                  },
                  child: const Text("Reset")),
            ],
          ),
        ]),
      ),
    );
  }
}
