import 'package:flutter/material.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'common/dropdown_multiple_select.dart';

class ReactiveDropdownMultipleField<T>
    extends ReactiveFormField<List<T>, List<T>> {
  ReactiveDropdownMultipleField({
    Key? key,
    Key? dropdownKey,
    FormControl<List<T>>? control,
    String? formControlName,
    Map<String, String Function(Object)>? validationMessages,
    ControlValueAccessor<List<T>, List<T>>? valueAccessor,
    bool Function(FormControl<List<T>>)? showErrors,
    FocusNode? focusNode,
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
  }) : super(
          key: key,
          formControl: control,
          formControlName: formControlName,
          validationMessages: validationMessages,
          valueAccessor: valueAccessor,
          showErrors: showErrors,
          focusNode: focusNode,
          builder: (ReactiveFormFieldState<List<T>, List<T>> field) {
            final effectiveDecoration = inputDecoration
                .applyDefaults(Theme.of(field.context).inputDecorationTheme);
            return DropDownMultiSelect<T>(
              key: dropdownKey,
              decoration: effectiveDecoration,
              childBuilder: childBuilder,
              onChanged: (List<T> selectedValues) {
                field.didChange(selectedValues);
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
            );
          },
        );
}
