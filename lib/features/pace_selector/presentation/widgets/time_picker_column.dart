import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:easy_localization/easy_localization.dart';

class TimePickerColumn extends StatefulWidget {
  final int value;
  final VoidCallback onIncrement;
  final VoidCallback onDecrement;
  final ValueChanged<int> onChanged;
  final int? maxValue;
  final bool padWithZero;
  final Color? activeBackgroundColor;

  const TimePickerColumn({
    super.key,
    required this.value,
    required this.onIncrement,
    required this.onDecrement,
    required this.onChanged,
    this.maxValue,
    this.padWithZero = true,
    this.activeBackgroundColor,
  });

  @override
  State<TimePickerColumn> createState() => _TimePickerColumnState();
}

class _TimePickerColumnState extends State<TimePickerColumn> {
  late TextEditingController _controller;
  bool _isEditing = false;
  final FocusNode _focusNode = FocusNode();

  String get _formattedValue => widget.padWithZero ? widget.value.toString().padLeft(2, '0') : widget.value.toString();

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: _formattedValue);
    _focusNode.addListener(() {
      if (!_focusNode.hasFocus) {
        setState(() => _isEditing = false);
        _updateValue(_controller.text);
      }
    });
  }

  @override
  void didUpdateWidget(covariant TimePickerColumn oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (!_isEditing && oldWidget.value != widget.value) {
      _controller.text = _formattedValue;
    }
  }

  void _updateValue(String text) {
    int? parsed = int.tryParse(text);
    if (parsed != null) {
      if (widget.maxValue != null && parsed > widget.maxValue!) {
        parsed = widget.maxValue;
      }
      widget.onChanged(parsed!);
    } else {
      _controller.text = _formattedValue;
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        IconButton(
          icon: const Icon(Icons.keyboard_arrow_up, size: 36, color: Colors.white),
          onPressed: () {
            if (_isEditing) {
              setState(() => _isEditing = false);
              _focusNode.unfocus();
            }
            widget.onIncrement();
          },
        ),
        GestureDetector(
          onTap: () {
            setState(() => _isEditing = true);
            _focusNode.requestFocus();
          },
          child: Container(
            width: 110,
            height: 100,
            decoration: BoxDecoration(
              color: _isEditing && widget.activeBackgroundColor != null 
                  ? widget.activeBackgroundColor 
                  : Colors.transparent,
              borderRadius: BorderRadius.circular(16),
            ),
            alignment: Alignment.center,
            child: _isEditing
                ? TextField(
                    controller: _controller,
                    focusNode: _focusNode,
                    keyboardType: TextInputType.number,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 80, 
                      fontWeight: FontWeight.w400, 
                      color: Colors.white,
                      height: 1.0,
                    ),
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                      LengthLimitingTextInputFormatter(2),
                    ],
                    onChanged: (val) {
                      int? parsed = int.tryParse(val);
                      if (parsed != null) {
                        if (widget.maxValue != null && parsed > widget.maxValue!) {
                          parsed = widget.maxValue;
                          _controller.text = parsed.toString();
                          _controller.selection = TextSelection.fromPosition(TextPosition(offset: _controller.text.length));
                        }
                        widget.onChanged(parsed!);
                      }
                    },
                    onSubmitted: (val) {
                      setState(() => _isEditing = false);
                      _updateValue(val);
                    },
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      isDense: true,
                      contentPadding: EdgeInsets.zero,
                    ),
                  )
                : Text(
                    _formattedValue,
                    style: const TextStyle(
                      fontSize: 80,
                      fontWeight: FontWeight.w400,
                      color: Colors.white,
                      height: 1.0,
                    ),
                  ),
          ),
        ),
        IconButton(
          icon: const Icon(Icons.keyboard_arrow_down, size: 36, color: Colors.white),
          onPressed: () {
            if (_isEditing) {
              setState(() => _isEditing = false);
              _focusNode.unfocus();
            }
            widget.onDecrement();
          },
        ),
        Text(
          'pace_selector.tap_to_edit'.tr(),
          style: TextStyle(
            fontSize: 10,
            fontWeight: FontWeight.bold,
            color: Colors.white.withValues(alpha: 0.3),
            letterSpacing: 1.0,
          ),
        ),
      ],
    );
  }
}
