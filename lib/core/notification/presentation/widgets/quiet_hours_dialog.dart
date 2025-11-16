import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// Dialog untuk mengatur jam quiet hours
class QuietHoursDialog extends StatefulWidget {
  final int initialStart;
  final int initialEnd;

  const QuietHoursDialog({
    super.key,
    required this.initialStart,
    required this.initialEnd,
  });

  @override
  State<QuietHoursDialog> createState() => _QuietHoursDialogState();
}

class _QuietHoursDialogState extends State<QuietHoursDialog> {
  int _startHour = 22;
  int _endHour = 8;

  @override
  void initState() {
    super.initState();
    _startHour = widget.initialStart;
    _endHour = widget.initialEnd;
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Atur Jam Quiet Hours'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Pilih jam mulai dan selesai untuk periode quiet hours',
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey[600],
            ),
          ),
          const SizedBox(height: 20),
          
          // Start Time
          Row(
            children: [
              const Text('Dari: ', style: TextStyle(fontWeight: FontWeight.w500)),
              Expanded(
                child: DropdownButton<int>(
                  value: _startHour,
                  onChanged: (value) {
                    if (value != null) {
                      setState(() {
                        _startHour = value;
                      });
                    }
                  },
                  items: List.generate(24, (hour) {
                    return DropdownMenuItem<int>(
                      value: hour,
                      child: Text('$hour:00'),
                    );
                  }),
                ),
              ),
            ],
          ),
          
          const SizedBox(height: 16),
          
          // End Time
          Row(
            children: [
              const Text('Hingga: ', style: TextStyle(fontWeight: FontWeight.w500)),
              Expanded(
                child: DropdownButton<int>(
                  value: _endHour,
                  onChanged: (value) {
                    if (value != null) {
                      setState(() {
                        _endHour = value;
                      });
                    }
                  },
                  items: List.generate(24, (hour) {
                    return DropdownMenuItem<int>(
                      value: hour,
                      child: Text('$hour:00'),
                    );
                  }),
                ),
              ),
            ],
          ),
          
          const SizedBox(height: 16),
          
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.blue.shade50,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Colors.blue.shade200),
            ),
            child: Row(
              children: [
                Icon(Icons.info_outline, color: Colors.blue.shade600, size: 20),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    'Notifikasi akan dibisukan selama $_startHour:00 - $_endHour:00',
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.blue.shade600,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Batal'),
        ),
        ElevatedButton(
          onPressed: () {
            Navigator.of(context).pop([_startHour, _endHour]);
          },
          child: const Text('Simpan'),
        ),
      ],
    );
  }
}
