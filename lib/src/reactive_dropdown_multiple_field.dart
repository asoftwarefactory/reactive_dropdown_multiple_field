import 'package:flutter/material.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'common/models/label_builder_data.dart';
import 'common/widgets/dropdown_multiple_select.dart';

class ReactiveDropdownMultipleField<T>
    extends ReactiveFormField<List<T>, List<T>> {
  ReactiveDropdownMultipleField({
    super.key,
    Key? dropdownKey,
    FormControl<List<T>>? control,
    super.formControlName,
    super.validationMessages,
    super.valueAccessor,
    super.showErrors,
    super.focusNode,
    // ---------------------- //
    Widget Function(List<T>)? childBuilder,
    required List<T> options,
    String? whenEmpty,
    InputDecoration inputDecoration = const InputDecoration(),
    bool enabled = true,
    Widget? hint,
    TextStyle? hintStyle,
    Widget? icon,
    bool isDense = true,
    Widget Function(T)? menuItembuilder,
    bool readOnly = false,
    TextStyle? selectedValuesStyle,
    String Function(T?)? validator,
    LabelBuilderData Function(T)? labelBuilder,
  }) : super(
          formControl: control,
          builder: (ReactiveFormFieldState<List<T>, List<T>> field) {
            final effectiveDecoration = inputDecoration
                .applyDefaults(Theme.of(field.context).inputDecorationTheme);
            return DropDownMultiSelect<T>(
              key: dropdownKey,
              decoration: effectiveDecoration,
              childBuilder: childBuilder,
              onChanged: (List<T> selectedValues) {
                field.didChange(selectedValues);
                field.control.updateValue(selectedValues);
              },
              options: options,
              selectedValues: field.value ?? [],
              whenEmpty: whenEmpty,
              enabled: enabled,
              hint: hint,
              hintStyle: hintStyle,
              icon: icon,
              isDense: isDense,
              menuItembuilder: menuItembuilder,
              readOnly: readOnly,
              selectedValuesStyle: selectedValuesStyle,
              validator: validator,
              labelBuilder: labelBuilder,
            );
          },
        );
}
