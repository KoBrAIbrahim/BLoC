import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HistoryCubit extends Cubit<List<String>> {
  HistoryCubit() : super([]) {
    loadHistory();
  }

  Future<void> loadHistory() async {
    final prefs = await SharedPreferences.getInstance();
    final data = prefs.getStringList('calc_history') ?? [];
    emit(data);
  }

  Future<void> addToHistory(String expression, String result) async {
    final prefs = await SharedPreferences.getInstance();
    final updated = List<String>.from(state)
      ..add('$expression = $result');
    await prefs.setStringList('calc_history', updated);
    emit(updated);
  }

  Future<void> clearHistory() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('calc_history');
    emit([]);
  }

  Future<void> saveHistory(List<String> history) async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.setStringList('calc_history', history);
}

}
