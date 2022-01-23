// ignore_for_file: public_member_api_docs, lines_longer_than_80_chars
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'models/counter.dart';

/// This is a reimplementation of the default Flutter application using provider + [ChangeNotifier].

void main() {
  runApp(
    /// Providers are above [MyApp] instead of inside it, so that tests
    /// can use [MyApp] while mocking the providers
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => CountersModel()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      themeMode: ThemeMode.dark,
      theme: ThemeData(brightness: Brightness.dark),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var countersId = context.select<CountersModel, List<String>>((model) {
      var counters = model.countersMap.values.toList();
      counters.sort((a, b) => a.count.compareTo(b.count));
      return counters.map((counter) => counter.id).toList();
    });
    var countersModel = context.read<CountersModel>();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Example'),
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: countersId
              .map((id) => Selector<CountersModel, Counter>(
                  selector: (context, countersModel) =>
                      countersModel.countersMap[id]!,
                  builder: (context, counter, child) {
                    print('build ${counter.id}');
                    return ElevatedButton(
                      onPressed: () =>
                          context.read<CountersModel>().increment(counter),
                      onLongPress: () =>
                          context.read<CountersModel>().decrement(counter),
                      child: Column(
                        children: [Text(counter.id), Text('${counter.count}')],
                      ),
                    );
                  }))
              .toList(),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        key: const Key('increment_floatingActionButton'),

        /// Calls `context.read` instead of `context.watch` so that it does not rebuild
        /// when [Counter] changes.
        onPressed: countersModel.createCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
