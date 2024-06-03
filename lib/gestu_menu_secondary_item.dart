import 'package:flutter/material.dart';

class GestuMenuSecondaryItemWidget<G> extends StatelessWidget {
  final String title;
  final G index;
  final bool isSelected;
  final IconData? prefixIconData;
  final IconData? suffixIconData;
  final ValueChanged<G>? onTap;
  final bool isPrimary;
  final TextStyle? textStyle;
  final Color? selectedColor;
  final Color? selectedTextColor;
  final BoxDecoration? decoration;
  final num? counter;
  const GestuMenuSecondaryItemWidget({
    super.key,
    required this.title,
    required this.index,
    this.isSelected = false,
    this.prefixIconData,
    this.suffixIconData,
    this.onTap,
    this.isPrimary = false,
    this.textStyle,
    this.selectedColor,
    this.selectedTextColor,
    this.decoration,
    this.counter,
  });

  GestuMenuSecondaryItemWidget<G> copyWith({
    TextStyle? textStyle,
    Color? selectedColor,
    Color? selectedTextColor,
    BoxDecoration? decoration,
    ValueChanged<G>? onTap,
  }) {
    return GestuMenuSecondaryItemWidget<G>(
      title: title,
      index: index,
      isSelected: isSelected,
      prefixIconData: prefixIconData,
      suffixIconData: suffixIconData,
      onTap: onTap ?? this.onTap,
      isPrimary: isPrimary,
      textStyle: this.textStyle ?? textStyle,
      selectedColor: this.selectedColor ?? selectedColor,
      selectedTextColor: this.selectedTextColor ?? selectedTextColor,
      decoration: this.decoration ?? decoration,
      counter: counter,
    );
  }

  @override
  Widget build(BuildContext context) {
    TextStyle? effectiveTextStyle = textStyle ??
        (isPrimary
            ? Theme.of(context).textTheme.labelLarge
            : Theme.of(context).textTheme.labelSmall);
    BoxDecoration effectiveDecoration = decoration ??
        BoxDecoration(
          borderRadius: BorderRadius.circular(8),
        );
    return AnimatedContainer(
      duration: const Duration(milliseconds: 250),
      margin: const EdgeInsets.symmetric(horizontal: 8),
      clipBehavior: Clip.hardEdge,
      decoration: effectiveDecoration.copyWith(
        color: isSelected
            ? (selectedColor ?? Theme.of(context).colorScheme.primary)
            : null,
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap != null ? () => onTap!(index) : null,
          child: Container(
            padding: const EdgeInsets.all(8),
            child: Row(
              children: [
                if (prefixIconData != null) ...[
                  Icon(
                    prefixIconData,
                    size: 17,
                    color: isSelected
                        ? (selectedTextColor ?? Colors.white)
                        : effectiveTextStyle?.color,
                  ),
                  const SizedBox(width: 8),
                ],
                Expanded(
                  child: Text(
                    title,
                    style: effectiveTextStyle?.copyWith(
                      color: isSelected
                          ? (selectedTextColor ?? Colors.white)
                          : effectiveTextStyle.color,
                    ),
                  ),
                ),
                if (suffixIconData != null)
                  Icon(
                    suffixIconData,
                    size: 17,
                    color: isSelected
                        ? (selectedTextColor ?? Colors.white)
                        : effectiveTextStyle?.color,
                  ),
                if (counter != null && counter! > 0)
                  Opacity(
                    opacity: 1,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      decoration: BoxDecoration(
                        color: (isSelected
                                ? (selectedTextColor ?? Colors.white)
                                : effectiveTextStyle!.color!)
                            .withOpacity(isSelected ? 0.2 : 0.08),
                        borderRadius: BorderRadius.circular(8),
                        // border: Border.all(
                        //   width: 0.5,
                        //   color: isSelected
                        //       ? (selectedTextColor ?? Colors.white)
                        //       : effectiveTextStyle!.color!,
                        // ),
                      ),
                      child: Text(
                        counter! > 99 ? '+99' : '$counter',
                        style: effectiveTextStyle?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: (isSelected
                                  ? (selectedTextColor ?? Colors.white)
                                  : effectiveTextStyle.color)
                              ?.withOpacity(isSelected ? 1 : 0.5),
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
