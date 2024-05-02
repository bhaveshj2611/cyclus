import 'package:flutter/material.dart';

class DateContainer extends StatefulWidget {
  final TextInputType? keyboardType;
  final String hitText;
  final String icon;
  Color color;
  final Widget? rigtIcon;
  final bool obscureText;
  final EdgeInsets? margin;
  final Function(String) onDateSelected;
  DateContainer({
    Key? key,
    required this.hitText,
    required this.icon,
    required this.onDateSelected,
    required this.color,
    this.margin,
    this.keyboardType,
    this.obscureText = false,
    this.rigtIcon,
  }) : super(key: key);

  @override
  State<DateContainer> createState() => _DateContainerState();
}

class _DateContainerState extends State<DateContainer> {
  TextEditingController txtDate = TextEditingController();
  var dob = 'Date of Birth';
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: widget.margin,
      decoration: BoxDecoration(
        color: Colors.grey.shade200,
        borderRadius: BorderRadius.circular(15),
      ),
      child: InkWell(
        onTap: () async {
          final selectedDate = await showDatePicker(
              context: context,
              initialDate: DateTime(2000),
              firstDate: DateTime(1999),
              lastDate: DateTime(2026));

          if (selectedDate != null) {
            setState(() {
              final formattedDate =
                  "${selectedDate.year}-${selectedDate.month.toString().padLeft(2, '0')}-${selectedDate.day.toString().padLeft(2, '0')}";
              widget.onDateSelected(formattedDate);
              print(formattedDate);
              dob = formattedDate;
              txtDate.text =
                  "${selectedDate.day.toString().padLeft(2, '0')}/${selectedDate.month.toString().padLeft(2, '0')}/${selectedDate.year}";
              print(txtDate.text);
            });
          }
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
          child: Row(
            children: [
              Container(
                alignment: Alignment.center,
                width: 20,
                height: 20,
                child: Image.asset(
                  widget.icon,
                  width: 20,
                  height: 20,
                  fit: BoxFit.contain,
                  color: widget.color,
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Text(txtDate.text == '' ? dob : txtDate.text,
                    style: txtDate.text == ''
                        ? const TextStyle(color: Colors.grey, fontSize: 12)
                        : const TextStyle(color: Colors.black, fontSize: 14)),
              ),
              widget.rigtIcon ?? const SizedBox(),
            ],
          ),
        ),
      ),
    );
  }
}
