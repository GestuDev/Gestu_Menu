import 'package:flutter/material.dart';

/// Widget for a secondary menu item.
class GestuMenuSecondaryItemWidget<G> extends StatelessWidget {
  /// Title of the item.
  final String title;

  /// Index of the item.
  final G index;

  /// Indicates if the item is selected.
  final bool isSelected;

  /// Optional icon to display before the title.
  final IconData? prefixIconData;

  /// Optional icon to display after the title.
  final IconData? suffixIconData;

  /// Callback that is called when the item is tapped.
  final ValueChanged<G>? onTap;

  /// Indicates if the item is a primary item.
  final bool isPrimary;

  /// Style for the text of the item.
  final TextStyle? textStyle;

  /// Color for the background of a selected item.
  final Color? selectedColor;

  /// Color for the text of a selected item.
  final Color? selectedTextColor;

  /// Decoration for the item's container.
  final BoxDecoration? decoration;

  /// Optional counter to display next to the item.
  final num? counter;

  /// Constructor for GestuMenuSecondaryItemWidget.
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
