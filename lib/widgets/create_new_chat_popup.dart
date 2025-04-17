import 'package:flutter/material.dart';
import 'package:ming_cute_icons/ming_cute_icons.dart';
import 'package:smart_retiree/widgets/input_form_field.dart';
import 'package:smart_retiree/utils/theme_extension.dart';
import 'package:smart_retiree/utils/validators.dart';

class CreateNewChatPopup extends StatefulWidget {
  const CreateNewChatPopup(
      {required this.controller, required this.onCreate, super.key});

  final TextEditingController controller;
  final VoidCallback onCreate;

  @override
  State<CreateNewChatPopup> createState() => _CreateNewChatPopupState();
}

class _CreateNewChatPopupState extends State<CreateNewChatPopup> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: MediaQuery.of(context).size.width * .75,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
          decoration: BoxDecoration(
            color: context.primaryContainer,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Material(
            color: Colors.transparent,
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "Create New Chat Room",
                    style: context.headlineMedium,
                  ),
                  const SizedBox(height: 24),
                  CircleAvatar(
                    radius: 45,
                    backgroundColor: Colors.red.shade100,
                    child: Icon(
                      MingCuteIcons.mgc_group_3_fill,
                      size: 40,
                      color: context.primary,
                    ),
                  ),
                  const SizedBox(height: 30),
                  ConstrainedBox(
                    constraints: const BoxConstraints(
                      minHeight: 50,
                      maxHeight: 100,
                    ),
                    child: InputField(
                      controller: widget.controller,
                      hintText: "Enter room name",
                      textInputType: TextInputType.name,
                      validator: Validators.validateName,
                    ),
                  ),
                  const SizedBox(height: 30),
                  ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState?.validate() ?? false) {
                        Navigator.pop(context);
                        widget.onCreate.call();
                      }
                    },
                    child: const Text("Create"),
                  ),
                  const SizedBox(height: 15),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: context.secondaryContainer,
                      elevation: 0,
                      foregroundColor: context.onPrimaryContainer,
                      textStyle: context.titleMedium,
                    ),
                    child: const Text("Cancel"),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
