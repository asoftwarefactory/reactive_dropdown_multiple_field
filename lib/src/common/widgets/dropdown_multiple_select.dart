import 'package:flutter/material.dart';
import 'package:states_rebuilder/states_rebuilder.dart';
import '../models/label_builder_data.dart';

///
/// A Dropdown multiselect menu
///
///
class DropDownMultiSelect<T> extends StatefulWidget {
  /// The options form which a user can select
  final List<T> options;

  /// Selected Values
  final List<T> selectedValues;

  /// This function is called whenever a value changes
  final Function(List<T>) onChanged;

  /// defines whether the field is dense
  final bool isDense;

  /// defines whether the widget is enabled;
  final bool enabled;

  /// Input decoration
  final InputDecoration? decoration;

  /// this text is shown when there is no selection
  final String? whenEmpty;

  /// a function to build custom childern
  final Widget Function(List<T> selectedValues)? childBuilder;

  /// a function to build custom menu items
  final Widget Function(T option)? menuItembuilder;

  /// a function to validate
  final String Function(T? selectedOptions)? validator;

  /// defines whether the widget is read-only
  final bool readOnly;

  /// icon shown on the right side of the field
  final Widget? icon;

  /// Textstyle for the hint
  final TextStyle? hintStyle;

  /// hint to be shown when there's nothing else to be shown
  final Widget? hint;

  /// style for the selected values
  final TextStyle? selectedValuesStyle;

  // if you want to insert a custom label, in the possible options, and in the selected options
  final LabelBuilderData Function(T)? labelBuilder;

  const DropDownMultiSelect({
    Key? key,
    required this.options,
    required this.selectedValues,
    required this.onChanged,
    this.whenEmpty,
    this.icon,
    this.hint,
    this.hintStyle,
    this.childBuilder,
    this.selectedValuesStyle,
    this.menuItembuilder,
    this.isDense = true,
    this.enabled = true,
    this.decoration,
    this.validator,
    this.readOnly = false,
    this.labelBuilder,
  }) : super(key: key);

  @override
  DropDownMultiSelectState createState() => DropDownMultiSelectState<T>();
}

class DropDownMultiSelectState<TState>
    extends State<DropDownMultiSelect<TState>> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.centerLeft,
      children: [
        DropdownButtonFormField<TState>(
          hint: widget.hint,
          style: widget.hintStyle,
          icon: widget.icon,
          validator: widget.validator,
          decoration: widget.decoration ??
              const InputDecoration(
                border: OutlineInputBorder(),
                isDense: true,
                contentPadding: EdgeInsets.symmetric(
                  vertical: 15,
                  horizontal: 10,
                ),
              ),
          isDense: widget.isDense,
          onChanged: widget.enabled ? (x) {} : null,
          isExpanded: false,
          value: widget.selectedValues.isNotEmpty
              ? widget.selectedValues[0]
              : null,
          selectedItemBuilder: (context) {
            return widget.options
                .map((e) => DropdownMenuItem(
                      child: Container(),
                    ))
                .toList();
          },
          // options to select
          items: widget.options
              .map(
                (x) => DropdownMenuItem<TState>(
                  value: x,
                  onTap: !widget.readOnly
                      ? () {
                          if (widget.selectedValues.contains(x)) {
                            var ns = widget.selectedValues;
                            ns.remove(x);
                            widget.onChanged(ns);
                          } else {
                            var ns = widget.selectedValues;
                            ns.add(x);
                            widget.onChanged(ns);
                          }
                        }
                      : null,
                  child: _theState.rebuild(() {
                    return widget.menuItembuilder != null
                        ? widget.menuItembuilder!(x)
                        : Builder(builder: (context) {
                            String? label;
                            final labelInput = widget.labelBuilder?.call(x);
                            if (labelInput != null &&
                                labelInput.enableIntoOptions) {
                              label = labelInput.label;
                            } else {
                              label = x.toString();
                            }
                            return _SelectRow(
                              selected: widget.selectedValues.contains(x),
                              text: label,
                              onChange: (isSelected) {
                                if (isSelected) {
                                  var ns = widget.selectedValues;
                                  ns.add(x);
                                  widget.onChanged(ns);
                                } else {
                                  var ns = widget.selectedValues;
                                  ns.remove(x);
                                  widget.onChanged(ns);
                                }
                              },
                            );
                          });
                  }),
                ),
              )
              .toList(),
        ),
        _theState.rebuild(() => widget.childBuilder != null
            ? widget.childBuilder!(widget.selectedValues)
            : Padding(
                padding: widget.decoration != null
                    ? widget.decoration!.contentPadding != null
                        ? widget.decoration!.contentPadding!
                        : const EdgeInsets.symmetric(horizontal: 10)
                    : const EdgeInsets.symmetric(horizontal: 20),
                child: Padding(
                  padding: const EdgeInsets.only(right: 20),
                  child: Text(
                    widget.selectedValues.isNotEmpty
                        ? widget.selectedValues.map((e) {
                            final labelInput = widget.labelBuilder?.call(e);
                            if (labelInput != null &&
                                labelInput.enableIntoSelectedOptions) {
                              return labelInput.label;
                            } else {
                              return e.toString();
                            }
                          }).reduce((a, b) => '$a, $b')
                        : widget.whenEmpty ?? '',
                    style: widget.selectedValuesStyle,
                  ),
                ))),
      ],
    );
  }
}

class _TheState {}

final _theState = RM.inject(() => _TheState());

class _SelectRow extends StatelessWidget {
  final Function(bool) onChange;
  final bool selected;
  final String text;

  const _SelectRow({
    Key? key,
    required this.onChange,
    required this.selected,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onChange(!selected);
        _theState.notify();
      },
      child: SizedBox(
        height: kMinInteractiveDimension,
        child: Row(
          children: [
            Checkbox(
                value: selected,
                onChanged: (x) {
                  onChange(x!);
                  _theState.notify();
                }),
            Text(text)
          ],
        ),
      ),
    );
  }
}

/* class RowWrapper extends InheritedWidget {
  final dynamic data;
  final bool Function() shouldNotify;
  const RowWrapper({
    super.key,
    required Widget child,
    this.data,
    required this.shouldNotify,
  }) : super(child: child);

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) {
    return true;
  }
} */