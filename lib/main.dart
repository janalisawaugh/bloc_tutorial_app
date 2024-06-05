import 'package:bloc_tutorial_app/bloc/counter_bloc.dart';
import 'package:bloc_tutorial_app/bloc/counter_event.dart';
import 'package:bloc_tutorial_app/bloc/counter_state.dart';
import 'package:bloc_tutorial_app/visibility_bloc/visibility_bloc.dart';
import 'package:bloc_tutorial_app/visibility_bloc/visibility_event.dart';
import 'package:bloc_tutorial_app/visibility_bloc/visibility_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      //how to use BlocProvider
      // home: BlocProvider<CounterBloc>(
      //   lazy: true,
      //   create: (context) => CounterBloc(),
      //   child: const MyHomePage(title: 'Flutter Demo Home Page'),
      // ),
      // home: BlocProvider.value(
      //   value: context.read<BlocA>(),
      //     child: const MyHomePage(title: 'Flutter Demo Home Page'),
      // ),
      //how to use MultiBlocProvider
      home: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => CounterBloc(),
          ),
          BlocProvider(
            create: (context) => VisibilityBloc(),
          ),
        ],
        child: const MyHomePage(title: 'Flutter Demo Home Page'),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  //final counterBloc = CounterBloc(); no longer needed with bloc provider
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            BlocBuilder<CounterBloc, CounterState>(
                buildWhen: (previous, current) {
              print(' Previous ${previous.count}');
              print(' Current ${current.count}');
              return current.count >= 2;
            },
                // bloc: counterBloc, no longer needed because of bloc provider
                builder: (context, state) {
              return Text(
                state.count.toString(),
                style: Theme.of(context).textTheme.headlineMedium,
              );
            }),
            BlocBuilder<VisibilityBloc, VisibilityState>(
                builder: (context, state) {
              return Visibility(
                  visible: state.show,
                  child: Container(
                    color: Colors.purple,
                    width: 200,
                    height: 200,
                  ));
            })
          ],
        ),
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          FloatingActionButton(
            onPressed: () {
              context.read<CounterBloc>().add(CounterIncrementEvent());
            },
            tooltip: 'Increment',
            child: const Icon(Icons.add),
          ),
          FloatingActionButton(
            onPressed: () {
              context.read<CounterBloc>().add(CounterDecrementEvent());
            },
            tooltip: 'Decrement',
            child: const Icon(Icons.minimize),
          ),
          FloatingActionButton(
            onPressed: () {
              context.read<VisibilityBloc>().add(VisibilityShowEvent());
            },
            child: const Text("Show"),
          ),
          FloatingActionButton(
            onPressed: () {
              context.read<VisibilityBloc>().add(VisibilityHideEvent());
            },
            child: const Text("Hide"),
          ),
        ],
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
