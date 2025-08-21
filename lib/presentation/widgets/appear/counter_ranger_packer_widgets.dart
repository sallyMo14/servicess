import 'package:flutter/material.dart';

class CounterRangePicker extends StatefulWidget {
  const CounterRangePicker({super.key});

  @override
  _CounterRangePickerState createState() =>
      _CounterRangePickerState();
}

class _CounterRangePickerState extends State<CounterRangePicker> {
  int from = 0;
  int to = 0;

  Widget buildCounter({
    required String label,
    required int value,
    required VoidCallback onIncrement,
    required VoidCallback onDecrement,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: const Color(0xFFF8F9FA),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          _circleIcon(Icons.add, onIncrement),
          const SizedBox(width: 12),
          Text(
            "$label\n$value",
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.grey[700]),
          ),
          const SizedBox(width: 12),
          _circleIcon(Icons.remove, onDecrement),
        ],
      ),
    );
  }

  Widget _circleIcon(IconData icon, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(6),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(color: Colors.grey),
        ),
        child: Icon(icon, size: 16, color: Colors.grey[700]),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        buildCounter(
          label: "From",
          value: from,
          onIncrement: () {
            setState(() {
              from++;
            });
          },
          onDecrement: () {
            setState(() {
              if (from > 0) from--;
            });
          },
        ),
        buildCounter(
          label: "To",
          value: to,
          onIncrement: () {
            setState(() {
              to++;
            });
          },
          onDecrement: () {
            setState(() {
              if (to > 0) to--;
            });
          },
        ),
      ],
    );
  }
}
