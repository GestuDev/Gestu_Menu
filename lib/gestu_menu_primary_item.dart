import 'package:flutter/material.dart';

import 'gestu_menu_secondary_item.dart';

class GestuMenuPrimaryItem<T> extends StatefulWidget {
  final IconData? prefixIconData;
  final String title;
  final List<Widget> items;
  final TextStyle? titleStyle;
  final bool isSecondary;
  final bool initialExpanded;
  final BoxDecoration? decoration;
  final TextStyle? itemTextStyle;
  final Color? itemSelectedColor;
  final Color? itemSelectedTextColor;
  final BoxDecoration? itemDecoration;
  final bool expandedIndicatorRight;
  final ValueChanged<T>? onTap;

  const GestuMenuPrimaryItem({
    super.key,
    this.prefixIconData,
    required this.title,
    this.titleStyle,
    required this.items,
    this.isSecondary = false,
    this.initialExpanded = false,
    this.decoration,
    this.itemTextStyle,
    this.itemSelectedColor,
    this.itemSelectedTextColor,
    this.itemDecoration,
    this.expandedIndicatorRight = false,
    this.onTap,
  });

  @override
  State<GestuMenuPrimaryItem> createState() => _GestuMenuPrimaryItemState<T>();

  GestuMenuPrimaryItem<T> _copyWith({
    BoxDecoration? decoration,
    TextStyle? itemTextStyle,
    Color? itemSelectedColor,
    Color? itemSelectedTextColor,
    BoxDecoration? itemDecoration,
  }) {
    return GestuMenuPrimaryItem(
      prefixIconData: prefixIconData,
      title: title,
      items: items,
      titleStyle: this.titleStyle ?? itemTextStyle,
      isSecondary: isSecondary,
      initialExpanded: initialExpanded,
      decoration: this.decoration ?? decoration,
      itemTextStyle: this.itemTextStyle ?? itemTextStyle,
      itemSelectedColor: this.itemSelectedColor ?? itemSelectedColor,
      itemSelectedTextColor:
          this.itemSelectedTextColor ?? itemSelectedTextColor,
      itemDecoration: this.itemDecoration ?? itemDecoration,
      expandedIndicatorRight: expandedIndicatorRight,
      onTap: this.onTap,
    );
  }
}

class _GestuMenuPrimaryItemState<T> extends State<GestuMenuPrimaryItem<T>> {
  late bool isExpanded;

  @override
  void initState() {
    isExpanded = widget.initialExpanded;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    bool isActive = hasActiveItem(widget.items);
    BoxDecoration effectiveDecoration = widget.decoration ??
        BoxDecoration(
          borderRadius: BorderRadius.circular(8),
        );
    TextStyle? effectiveTextStyle = widget.titleStyle ??
        (widget.isSecondary
            ? Theme.of(context).textTheme.labelSmall
            : Theme.of(context).textTheme.labelLarge);
    return AnimatedSize(
      alignment: Alignment.topCenter,
      duration: const Duration(milliseconds: 250),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 250),
              clipBehavior: Clip.hardEdge,
              decoration: effectiveDecoration,
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  borderRadius: BorderRadius.circular(8),
                  onTap: () {
                    setState(() {
                      isExpanded = !isExpanded;
                    });
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Row(
                      children: [
                        if (!widget.expandedIndicatorRight) ...[
                          AnimatedRotation(
                            turns: isExpanded ? 0 : -0.25,
                            duration: const Duration(milliseconds: 250),
                            child: Icon(
                              Icons.arrow_drop_down,
                              color: effectiveTextStyle?.color,
                            ),
                          ),
                        ],
                        const SizedBox(width: 8),
                        Expanded(
                          child: Row(
                            children: [
                              if (widget.prefixIconData != null) ...[
                                Icon(
                                  widget.prefixIconData,
                                  size: 17,
                                  color: effectiveTextStyle?.color,
                                ),
                                const SizedBox(width: 8),
                              ],
                              Text(
                                widget.title,
                                style: effectiveTextStyle,
                              ),
                            ],
                          ),
                        ),
                        if (!isExpanded && isActive)
                          Icon(
                            Icons.circle,
                            color: Theme.of(context).colorScheme.primary,
                            size: 8,
                          ),
                        const SizedBox(width: 8),
                        if (widget.expandedIndicatorRight)
                          AnimatedRotation(
                            turns: !isExpanded ? 0 : -0.5,
                            duration: const Duration(milliseconds: 250),
                            child: Icon(
                              Icons.arrow_drop_down,
                              color: effectiveTextStyle?.color,
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
          if (isExpanded) const SizedBox(height: 8),
          if (isExpanded)
            ...widget.items.map(
              (e) => Padding(
                padding: const EdgeInsets.only(left: 16),
                child: (e is GestuMenuSecondaryItemWidget<T>)
                    ? e.copyWith(
                        textStyle: widget.itemTextStyle,
                        selectedColor: widget.itemSelectedColor,
                        selectedTextColor: widget.itemSelectedTextColor,
                        decoration: widget.itemDecoration,
                        onTap: widget.onTap,
                      )
                    : (e is GestuMenuPrimaryItem<T>)
                        ? e._copyWith(
                            decoration: widget.itemDecoration,
                            itemTextStyle: widget.itemTextStyle,
                            itemSelectedColor: widget.itemSelectedColor,
                            itemSelectedTextColor: widget.itemSelectedTextColor,
                            itemDecoration: widget.itemDecoration,
                          )
                        : e,
              ),
            ),
          if (isExpanded && !widget.isSecondary) const SizedBox(height: 8),
        ],
      ),
    );
  }

  bool hasActiveItem(List<Widget> items) {
    for (var element in items) {
      if (element is GestuMenuSecondaryItemWidget<T> && element.isSelected) {
        return true;
      } else if (element is GestuMenuPrimaryItem<T> &&
          hasActiveItem(element.items)) {
        return true;
      }
    }
    return false;
  }
}
