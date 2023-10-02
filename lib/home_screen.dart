import 'package:flutter/material.dart';
import 'package:value_listenable_builder/value_notifier.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AppValueNotifier appValueNotifier = AppValueNotifier();
    return Scaffold(
      appBar: AppBar(title: const Text("ValueListenableBuilder Example")),
      body: ValueListenableBuilder<List<String>>(
        builder: (context, items, child) {
          if (items.isNotEmpty) {
            return ListView.builder(
              itemCount: items.length,
              itemBuilder: (BuildContext context, int index) {
                return Card(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    child: Align(
                        alignment: Alignment.center, child: Text(items[index])),
                  ),
                );
              },
            );
          }
          return const Center(child: Text("No Items"));
        },
        valueListenable: appValueNotifier.valueNotifier,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showAlertDialog(context, appValueNotifier);
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  showAlertDialog(BuildContext context, AppValueNotifier appValueNotifier) {
    TextEditingController controller = TextEditingController();
    Widget okButton = TextButton(
      child: const Text("OK"),
      onPressed: () {
        if (controller.text != "") {
          appValueNotifier.addItem(controller.text);
          appValueNotifier.valueNotifier.value =
              List<String>.from(appValueNotifier.valueNotifier.value);
          Navigator.pop(context);
        }
      },
    );

    AlertDialog alert = AlertDialog(
      title: const Text("Add Item"),
      content: TextField(
        controller: controller,
      ),
      actions: [
        okButton,
      ],
    );

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
