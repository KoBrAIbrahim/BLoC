import 'package:app/ui/info_screen.dart';
import 'package:app/ui/api_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../blocs/calculator_bloc.dart';
import '../cubits/theme_cubit.dart';

class CalculatorScreen extends StatelessWidget {
  const CalculatorScreen({super.key});

  Widget button(String label, VoidCallback onTap, {Color? color}) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(backgroundColor: color),
          onPressed: onTap,
          child: Text(label, style: const TextStyle(fontSize: 24)),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Calculator'),
        actions: [
          IconButton(
            icon: const Icon(Icons.brightness_6),
            onPressed: () {
              final isDark = Theme.of(context).brightness == Brightness.light;
              context.read<ThemeCubit>().toggleTheme(isDark);
            },
          ),
          IconButton(
            icon: const Icon(Icons.format_quote),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const QuoteScreen()),
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.info_outline),
            onPressed: () {
              Navigator.of(
                context,
              ).push(MaterialPageRoute(builder: (_) => const InfoScreen()));
            },
          ),
        ],
      ),
      body: Column(
        children: [
          BlocBuilder<CalculatorBloc, CalculatorState>(
            builder:
                (context, state) => Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        state.expression,
                        style: const TextStyle(fontSize: 28),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        state.result,
                        style: const TextStyle(
                          fontSize: 20,
                          color: Colors.green,
                        ),
                      ),
                    ],
                  ),
                ),
          ),
          const Divider(),
          Expanded(
            child: Column(
              children: [
                Row(
                  children: [
                    button(
                      '7',
                      () => context.read<CalculatorBloc>().add(
                        NumberPressed('7'),
                      ),
                    ),
                    button(
                      '8',
                      () => context.read<CalculatorBloc>().add(
                        NumberPressed('8'),
                      ),
                    ),
                    button(
                      '9',
                      () => context.read<CalculatorBloc>().add(
                        NumberPressed('9'),
                      ),
                    ),
                    button(
                      '/',
                      () => context.read<CalculatorBloc>().add(
                        OperatorPressed('/'),
                      ),
                      color: Colors.orange,
                    ),
                  ],
                ),
                Row(
                  children: [
                    button(
                      '4',
                      () => context.read<CalculatorBloc>().add(
                        NumberPressed('4'),
                      ),
                    ),
                    button(
                      '5',
                      () => context.read<CalculatorBloc>().add(
                        NumberPressed('5'),
                      ),
                    ),
                    button(
                      '6',
                      () => context.read<CalculatorBloc>().add(
                        NumberPressed('6'),
                      ),
                    ),
                    button(
                      '*',
                      () => context.read<CalculatorBloc>().add(
                        OperatorPressed('*'),
                      ),
                      color: Colors.orange,
                    ),
                  ],
                ),
                Row(
                  children: [
                    button(
                      '1',
                      () => context.read<CalculatorBloc>().add(
                        NumberPressed('1'),
                      ),
                    ),
                    button(
                      '2',
                      () => context.read<CalculatorBloc>().add(
                        NumberPressed('2'),
                      ),
                    ),
                    button(
                      '3',
                      () => context.read<CalculatorBloc>().add(
                        NumberPressed('3'),
                      ),
                    ),
                    button(
                      '-',
                      () => context.read<CalculatorBloc>().add(
                        OperatorPressed('-'),
                      ),
                      color: Colors.orange,
                    ),
                  ],
                ),
                Row(
                  children: [
                    button(
                      '0',
                      () => context.read<CalculatorBloc>().add(
                        NumberPressed('0'),
                      ),
                    ),
                    button(
                      '.',
                      () => context.read<CalculatorBloc>().add(
                        NumberPressed('.'),
                      ),
                    ),
                    button(
                      'C',
                      () => context.read<CalculatorBloc>().add(ClearPressed()),
                      color: Colors.red,
                    ),
                    button(
                      '+',
                      () => context.read<CalculatorBloc>().add(
                        OperatorPressed('+'),
                      ),
                      color: Colors.orange,
                    ),
                  ],
                ),
                Row(
                  children: [
                    button(
                      'DEL',
                      () => context.read<CalculatorBloc>().add(DeletePressed()),
                      color: Colors.grey,
                    ),
                    button(
                      '=',
                      () =>
                          context.read<CalculatorBloc>().add(EvaluatePressed()),
                      color: Colors.green,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
