import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:ming_cute_icons/ming_cute_icons.dart';
import 'package:smart_retiree/models/app_event.dart';
import 'package:smart_retiree/models/app_user.dart';
import 'package:smart_retiree/providers/user_provider.dart';
import 'package:smart_retiree/utils/core_utils.dart';
import 'package:smart_retiree/utils/image_upload.dart';
import 'package:smart_retiree/utils/loader.dart';
import 'package:smart_retiree/utils/theme_extension.dart';

class CreateEventScreen extends ConsumerStatefulWidget {
  const CreateEventScreen({super.key});

  @override
  ConsumerState<CreateEventScreen> createState() => _CreateEventScreenState();
}

class _CreateEventScreenState extends ConsumerState<CreateEventScreen> {
  final _formKey = GlobalKey<FormState>();

  File? _selectedImage;
  final picker = ImagePicker();

  String? _name;
  String? _location;
  String? _type;
  String? _description;
  DateTime? _selectedDate;
  TimeOfDay? _selectedTime;
  late AppUser _currentUser;

  final List<String> _eventTypes = ['Education', 'Environment', 'Health'];

  @override
  void initState() {
    super.initState();
    _currentUser = ref.read(userProvider)!;
  }

  Future<void> _pickImage() async {
    final pickedFile =
        await picker.pickImage(source: ImageSource.gallery, imageQuality: 80);
    if (pickedFile != null) {
      setState(() => _selectedImage = File(pickedFile.path));
    }
  }

  Future<void> _pickDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
    );
    if (picked != null) setState(() => _selectedDate = picked);
  }

  Future<void> _pickTime() async {
    final picked =
        await showTimePicker(context: context, initialTime: TimeOfDay.now());
    if (picked != null) setState(() => _selectedTime = picked);
  }

  void _removeImage() {
    setState(() {
      _selectedImage = null;
    });
  }

  void _submitForm() async {
    if (!_formKey.currentState!.validate() ||
        _selectedImage == null ||
        _selectedDate == null ||
        _selectedTime == null) {
      CoreUtils.showToast(
          type: ToastType.error, message: 'Please complete all fields!');

      return;
    }

    _formKey.currentState!.save();
    final fullDateTime = DateTime(
      _selectedDate!.year,
      _selectedDate!.month,
      _selectedDate!.day,
      _selectedTime!.hour,
      _selectedTime!.minute,
    );

    try {
      Loader.show(true);

      final imageUrl =
          await ImageUpload.uploadImageToCloudinary(_selectedImage!);

      final event = AppEvent(
        id: '',
        name: _name!,
        time: fullDateTime,
        location: _location!,
        type: _type!,
        imageUrl: imageUrl!,
        description: _description!,
        createdAt: DateTime.now(),
        createdBy: _currentUser.uid,
        members: [_currentUser.uid],
      );
      await FirebaseFirestore.instance.collection('events').add(event.toMap());

      CoreUtils.showToast(
          type: ToastType.success, message: "🎉 Event created successfully!");
      CoreUtils.postFrameCall(() => Navigator.pop(context));
    } catch (e) {
      CoreUtils.showToast(
          type: ToastType.error, message: "Error: ${e.toString()}");
    } finally {
      Loader.show(false);
    }
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(top: 16, bottom: 6, left: 8),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(
          title,
          style: const TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 16,
            color: Colors.black87,
          ),
          textAlign: TextAlign.left,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfff6f7fb),
      appBar: AppBar(
        elevation: 0,
        surfaceTintColor: Colors.transparent,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Icon(
            MingCuteIcons.mgc_close_circle_line,
            size: 30,
            color: context.primary,
          ),
        ),
        centerTitle: true,
        title: Text(
          "Create Event",
          style: context.headlineMedium,
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 8),
            child: IconButton(
              onPressed: _submitForm,
              icon: Icon(
                MingCuteIcons.mgc_send_plane_line,
                size: 30,
                color: context.primary,
              ),
            ),
          )
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                AspectRatio(
                  aspectRatio: 1.75,
                  child: Container(
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: Colors.transparent,
                      border: Border.all(color: Colors.grey.shade300),
                    ),
                    child: _selectedImage != null
                        ? Stack(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(8),
                                child: AspectRatio(
                                  aspectRatio: 1.75,
                                  child: Image.file(
                                    _selectedImage!,
                                    fit: BoxFit.fill,
                                  ),
                                ),
                              ),
                              Positioned(
                                right: 8,
                                top: 8,
                                child: GestureDetector(
                                  onTap: _removeImage,
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: Colors.black.withAlpha(120),
                                      shape: BoxShape.circle,
                                    ),
                                    padding: const EdgeInsets.all(4),
                                    child: const Icon(
                                      Icons.close,
                                      color: Colors.white,
                                      size: 20,
                                    ),
                                  ),
                                ),
                              )
                            ],
                          )
                        : GestureDetector(
                            onTap: _pickImage,
                            child: const Center(
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(Icons.add_a_photo_outlined, size: 36),
                                  SizedBox(height: 6),
                                  Text("Tap to upload event image"),
                                ],
                              ),
                            ),
                          ),
                  ),
                ),
                _buildSectionTitle("Event Name"),
                TextFormField(
                  decoration: _inputDecoration("Enter event name"),
                  validator: (val) =>
                      val == null || val.isEmpty ? "Required" : null,
                  onSaved: (val) => _name = val,
                ),
                _buildSectionTitle("Location"),
                TextFormField(
                  decoration: _inputDecoration("Enter location"),
                  validator: (val) =>
                      val == null || val.isEmpty ? "Required" : null,
                  onSaved: (val) => _location = val,
                ),
                _buildSectionTitle("Event Type"),
                DropdownButtonFormField<String>(
                  value: _type,
                  decoration: _inputDecoration("Select type"),
                  items: _eventTypes
                      .map((e) => DropdownMenuItem(
                          value: e,
                          child: Text(
                            e,
                            style: const TextStyle(fontWeight: FontWeight.w500),
                          )))
                      .toList(),
                  validator: (val) => val == null ? "Required" : null,
                  onChanged: (val) => _type = val,
                ),
                _buildSectionTitle("Description"),
                TextFormField(
                  decoration: _inputDecoration("Write description"),
                  maxLines: 3,
                  onSaved: (val) => _description = val,
                ),
                _buildSectionTitle("Date & Time"),
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton.icon(
                        icon: const Icon(MingCuteIcons.mgc_calendar_add_line),
                        style: _pickerButtonStyle(),
                        label: Text(_selectedDate == null
                            ? "Pick date"
                            : DateFormat('yyyy-MM-dd').format(_selectedDate!)),
                        onPressed: _pickDate,
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: ElevatedButton.icon(
                        icon: const Icon(
                          MingCuteIcons.mgc_time_line,
                        ),
                        style: _pickerButtonStyle(),
                        label: Text(_selectedTime == null
                            ? "Pick time"
                            : _selectedTime!.format(context)),
                        onPressed: _pickTime,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  InputDecoration _inputDecoration(String hint) {
    return InputDecoration(
      hintText: hint,
      filled: false,
      contentPadding: const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: BorderSide.none,
      ),
    );
  }

  ButtonStyle _pickerButtonStyle() {
    return ElevatedButton.styleFrom(
      padding: const EdgeInsets.symmetric(vertical: 14),
      backgroundColor: Colors.transparent,
      foregroundColor: Colors.black87,
      elevation: 0,
      side: BorderSide(color: Colors.grey.shade300, width: 2),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
    );
  }
}
