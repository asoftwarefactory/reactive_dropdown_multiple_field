import 'package:flutter/material.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'common/dropdown_multiple_select.dart';

class ReactiveDropdownMultipleField<ModelDataType, ViewDataType>
    extends ReactiveFormField<List<ModelDataType>, List<ViewDataType>> {
  ReactiveDropdownMultipleField({
    Key? key,
    Key? dropdownKey,
    FormControl<List<ModelDataType>>? control,
    String? formControlName,
    Map<String, String Function(Object)>? validationMessages,
    ControlValueAccessor<List<ModelDataType>, List<ViewDataType>>?
        valueAccessor,
    bool Function(FormControl<List<ModelDataType>>)? showErrors,
    FocusNode? focusNode,
    // ---------------------- //
    Widget Function(List<ViewDataType>)? childBuilder,
    required List<ViewDataType> options,
    String Function(List<ViewDataType>, ViewDataType)? labelBuilder,
    String? whenEmpty,
    InputDecoration inputDecoration = const InputDecoration(),
    bool enabled = true,
    Widget? hint,
    TextStyle? hintStyle,
    Widget? icon,
    bool isDense = true,
    Widget Function(ViewDataType)? menuItembuilder,
    bool readOnly = false,
    TextStyle? selectedValuesStyle,
    String Function(ViewDataType?)? validator,
    Widget Function(List<ViewDataType>)? selectedItemsBuilder,
  }) : super(
          key: key,
          formControl: control,
          formControlName: formControlName,
          validationMessages: validationMessages,
          valueAccessor: valueAccessor,
          showErrors: showErrors,
          focusNode: focusNode,
          builder:
              (ReactiveFormFieldState<List<ModelDataType>, List<ViewDataType>>
                  field) {
            final effectiveDecoration = inputDecoration
                .applyDefaults(Theme.of(field.context).inputDecorationTheme);
            return DropDownMultiSelect<ViewDataType>(
              key: dropdownKey,
              labelBuilder: labelBuilder,
              decoration: effectiveDecoration,
              childBuilder: childBuilder,
              onChanged: (List<ViewDataType> selectedValues) {
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
              selectedItemsBuilder: selectedItemsBuilder,
            );
          },
        );
}
