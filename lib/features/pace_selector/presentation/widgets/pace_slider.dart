
import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';

class PaceSlider extends StatelessWidget {
  final int totalSeconds;
  final ValueChanged<int> onChanged;
  final Color activeColor;

  const PaceSlider({
    super.key,
    required this.totalSeconds,
    required this.onChanged,
    required this.activeColor,
  });

  double _secondsToSliderValue(int seconds) {
    if (seconds <= 70) return 0.0 + 25.0 * (seconds / 70);
    if (seconds <= 90) return 25.0 + 25.0 * ((seconds - 70) / (90 - 70));
    if (seconds <= 150) return 50.0 + 25.0 * ((seconds - 90) / (150 - 90));
    if (seconds <= 240) return 75.0 + 25.0 * ((seconds - 150) / (240 - 150));
    return 100.0;
  }

  int _sliderValueToSeconds(double v) {
    if (v <= 25) return ((v - 0) / 25.0 * 70).round();
    if (v <= 50) return 70 + ((v - 25) / 25.0 * (90 - 70)).round();
    if (v <= 75) return 90 + ((v - 50) / 25.0 * (150 - 90)).round();
    if (v <= 100) return 150 + ((v - 75) / 25.0 * (240 - 150)).round();
    return 240;
  }

  @override
  Widget build(BuildContext context) {
    final sliderVal = _secondsToSliderValue(totalSeconds).clamp(0.0, 100.0);
    
    return Column(
      children: [
        SliderTheme(
          data: SliderTheme.of(context).copyWith(
            trackHeight: 4,
            activeTrackColor: activeColor,
            inactiveTrackColor: AppColors.divider,
            thumbColor: AppColors.textPrimary,
            overlayColor: activeColor.withValues(alpha: 0.2),
            thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 10, elevation: 4),
            overlayShape: const RoundSliderOverlayShape(overlayRadius: 20),
            trackShape: SegmentedSliderTrackShape(currentFraction: sliderVal / 100.0),
          ),
          child: Slider(
            value: sliderVal,
            min: 0,
            max: 100,
            onChanged: (val) => onChanged(_sliderValueToSeconds(val)),
          ),
        ),
        
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: SizedBox(
            height: 20,
            child: Row(
              children: [
                const Expanded(child: SizedBox()),
                SizedBox(
                  width: 0,
                  child: OverflowBox(
                    maxWidth: 100,
                    child: _buildTickLabel('1:10'),
                  ),
                ),
                const Expanded(child: SizedBox()),
                SizedBox(
                  width: 0,
                  child: OverflowBox(
                    maxWidth: 100,
                    child: _buildTickLabel('1:30'),
                  ),
                ),
                const Expanded(child: SizedBox()),
                SizedBox(
                  width: 0,
                  child: OverflowBox(
                    maxWidth: 100,
                    child: _buildTickLabel('2:30'),
                  ),
                ),
                const Expanded(child: SizedBox()),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildTickLabel(String label) {
    return SizedBox(
      width: 40,
      child: Text(
        label,
        textAlign: TextAlign.center,
        style: const TextStyle(
          fontSize: 10,
          color: AppColors.textMuted,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}

class SegmentedSliderTrackShape extends SliderTrackShape with BaseSliderTrackShape {
  final double currentFraction;

  SegmentedSliderTrackShape({required this.currentFraction});

  @override
  void paint(
    PaintingContext context,
    Offset offset, {
    required RenderBox parentBox,
    required SliderThemeData sliderTheme,
    required Animation<double> enableAnimation,
    required TextDirection textDirection,
    required Offset thumbCenter,
    Offset? secondaryOffset,
    bool isDiscrete = false,
    bool isEnabled = false,
    double additionalActiveTrackHeight = 2,
  }) {
    if (sliderTheme.trackHeight == null || sliderTheme.trackHeight! <= 0) return;

    final Rect trackRect = getPreferredRect(
      parentBox: parentBox,
      offset: offset,
      sliderTheme: sliderTheme,
      isEnabled: isEnabled,
      isDiscrete: isDiscrete,
    );

    final Paint activePaint = Paint()..color = sliderTheme.activeTrackColor!;
    final Paint inactivePaint = Paint()..color = sliderTheme.inactiveTrackColor!;

    double segmentStartFraction = 0.0;
    double segmentEndFraction = 0.0;
    if (currentFraction <= 0.25) {
      segmentStartFraction = 0.0;
      segmentEndFraction = 0.25;
    } else if (currentFraction <= 0.50) {
      segmentStartFraction = 0.25;
      segmentEndFraction = 0.50;
    } else if (currentFraction <= 0.75) {
      segmentStartFraction = 0.50;
      segmentEndFraction = 0.75;
    } else {
      segmentStartFraction = 0.75;
      segmentEndFraction = 1.0;
    }

    final double trackWidth = trackRect.width;
    final double segmentStartX = trackRect.left + (trackWidth * segmentStartFraction);
    final double segmentEndX = trackRect.left + (trackWidth * segmentEndFraction);

    final RRect trackRRect = RRect.fromRectAndRadius(
      trackRect,
      Radius.circular(sliderTheme.trackHeight! / 2),
    );

    context.canvas.save();
    context.canvas.clipRRect(trackRRect);

    context.canvas.drawRect(trackRect, inactivePaint);

    context.canvas.drawRect(
      Rect.fromLTRB(segmentStartX, trackRect.top, segmentEndX, trackRect.bottom),
      activePaint,
    );

    context.canvas.restore();
  }
}
