// ignore_for_file: invalid_use_of_visible_for_testing_member

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubits/history_cubit.dart';

class HistoryScreen extends StatelessWidget {
  const HistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HistoryCubit, List<String>>(
      builder: (context, history) {
        return Scaffold(
          appBar: AppBar(
            title: const Text("History"),
            actions: [
              if (history.isNotEmpty)
                IconButton(
                  icon: const Icon(Icons.delete_forever),
                  tooltip: "Clear All",
                  onPressed: () =>
                      context.read<HistoryCubit>().clearHistory(),
                ),
            ],
          ),
          body: history.isEmpty
              ? const Center(child: Text("No history yet"))
              : ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: history.length,
                  itemBuilder: (context, index) => GestureDetector(
                    onDoubleTap: () {
                      final removedItem = history[index];
                      final updatedHistory = List<String>.from(history)
                        ..removeAt(index);

                      // ignore: invalid_use_of_protected_member
                      context.read<HistoryCubit>().emit(updatedHistory);
                      context.read<HistoryCubit>().saveHistory(updatedHistory);

                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Deleted: $removedItem')),
                      );
                    },
                    child: Card(
                      child: ListTile(
                        title: Text(history[index]),
                      ),
                    ),
                  ),
                ),
        );
      },
    );
  }
}
