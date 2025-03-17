import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:math_expressions/math_expressions.dart';


abstract class CalculatorEvent {}

class NumberPressed extends CalculatorEvent {
  final String number;
  NumberPressed(this.number);
}

class OperatorPressed extends CalculatorEvent {
  final String operator;
  OperatorPressed(this.operator);
}

class ClearPressed extends CalculatorEvent {}

class DeletePressed extends CalculatorEvent {}

class EvaluatePressed extends CalculatorEvent {}

class CalculatorState {
  final String expression;
  final String result;
  CalculatorState({this.expression = '', this.result = ''});
}

class CalculatorBloc extends Bloc<CalculatorEvent, CalculatorState> {
  CalculatorBloc() : super(CalculatorState()) {
    on<NumberPressed>((event, emit) {
      emit(CalculatorState(expression: state.expression + event.number));
    });

    on<OperatorPressed>((event, emit) {
      emit(CalculatorState(expression: state.expression + event.operator));
    });

    on<ClearPressed>((event, emit) {
      emit(CalculatorState());
    });

    on<DeletePressed>((event, emit) {
      if (state.expression.isNotEmpty) {
        emit(CalculatorState(
          expression: state.expression.substring(0, state.expression.length - 1),
        ));
      }
    });

    on<EvaluatePressed>((event, emit) {
      try {
        final result = _evaluate(state.expression);
        emit(CalculatorState(expression: state.expression, result: result));
      } catch (_) {
        emit(CalculatorState(expression: state.expression, result: 'Error'));
      }
    });
  }


String _evaluate(String exp) {
  try {
    final cleaned = exp.replaceAll('×', '*').replaceAll('÷', '/');
    // ignore: deprecated_member_use
    Parser p = Parser();
    Expression expression = p.parse(cleaned);
    ContextModel cm = ContextModel();
    double eval = expression.evaluate(EvaluationType.REAL, cm);
    return eval.toString();
  } catch (e) {
    return 'Error';
  }
}

}
