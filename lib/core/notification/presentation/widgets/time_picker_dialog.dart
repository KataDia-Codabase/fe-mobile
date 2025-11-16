import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../notification_types.dart';

/// Time picker dialog untuk preferensi notifikasi
class TimePickerDialog extends StatefulWidget {
  final Time initialTime;
  final TimePickerType type;
  final String title;
  
  const TimePickerDialog({
    super.key,
    required this.initialTime,
    required this.type,
    this.title = 'Pilih Waktu',
  });

  @override
  State<TimePickerDialog> createState() => _TimePickerDialogState();
}

class _TimePickerDialogState extends State<TimePickerDialog> {
  late Time _selectedTime;

  @override
  void initState() {
    super.initState();
    _selectedTime = widget.initialTime;
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(widget.title),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Pilih ${_getTimePickerTypeTitle(widget.type)}',
            style: const TextStyle(
              fontSize: 14,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 16),
          // Time picker untuk jam
          SizedBox(
            height: 200,
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 6,
                childAspectRatio: 1.0,
              ),
              itemCount: 24, // 0-23 jam
              itemBuilder: (context, index) {
                final hour = index;
                final isSelected = _selectedTime.hour == hour;

                return GestureDetector(
                  onTap: () {
                    setState(() {
                      _selectedTime = Time(hour, _selectedTime.minute);
                    });
                  },
                  child: Container(
                    margin: const EdgeInsets.all(2),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: isSelected ? Theme.of(context).primaryColor : Colors.grey.shade300,
                      ),
                      borderRadius: BorderRadius.circular(8),
                      color: isSelected ? Theme.of(context).primaryColor.withOpacity(0.1) : null,
                    ),
                    child: Center(
                      child: Text(
                        hour.toString().padLeft(2, '0'),
                        style: TextStyle(
                          fontSize: 16,
                          color: isSelected ? Theme.of(context).primaryColor : Colors.black87,
                          fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 16),
          // Time picker untuk menit
          SizedBox(
            height: 120,
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4,
                childAspectRatio: 2.0,
              ),
              itemCount: 4, // 0, 15, 30, 45 menit
              itemBuilder: (context, index) {
                final minute = index * 15;
                final isSelected = _selectedTime.minute == minute;

                return GestureDetector(
                  onTap: () {
                    setState(() {
                      _selectedTime = Time(_selectedTime.hour, minute);
                    });
                  },
                  child: Container(
                    margin: const EdgeInsets.all(2),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: isSelected ? Theme.of(context).primaryColor : Colors.grey.shade300,
                      ),
                      borderRadius: BorderRadius.circular(8),
                      color: isSelected ? Theme.of(context).primaryColor.withOpacity(0.1) : null,
                    ),
                    child: Center(
                      child: Text(
                        minute.toString().padLeft(2, '0'),
                        style: TextStyle(
                          fontSize: 14,
                          color: isSelected ? Theme.of(context).primaryColor : Colors.black87,
                          fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                        ),
                      ),
                    ),
                  ),
                );
              },
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
            Navigator.of(context).pop(_selectedTime);
          },
          child: const Text('Pilih'),
        ),
      ],
    );
  }

  /// Mendapatkan judul berdasarkan tipe time picker
  String _getTimePickerTypeTitle(TimePickerType type) {
    switch (type) {
      case TimePickerType.daily:
        return 'Waktu Harian';
      case TimePickerType.weekly:
        return 'Waktu Mingguan';
      case TimePickerType.custom:
        return 'Waktu Kustom';
    }
  }
}

/// Tipe time picker
enum TimePickerType {
  daily,
  weekly,
  custom,
}

/// Mapping untuk tipe time picker
const Map<TimePickerType, String> timePickerTypeMap = {
  TimePickerType.daily: 'Harian',
  TimePickerType.weekly: 'Mingguan',
  TimePickerType.custom: 'Kustom',
};

/// Fungsi utility untuk menampilkan time picker dialog
Future<Time?> showTimePickerDialog({
  required BuildContext context,
  required Time initialTime,
  TimePickerType type = TimePickerType.daily,
  String title = 'Pilih Waktu',
}) async {
  return await showDialog<Time>(
    context: context,
    builder: (context) => TimePickerDialog(
      initialTime: initialTime,
      type: type,
      title: title,
    ),
  );
}
