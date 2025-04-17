import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ming_cute_icons/ming_cute_icons.dart';
import 'package:smart_retiree/models/app_post.dart';
import 'package:smart_retiree/models/post_user.dart';
import 'package:smart_retiree/providers/user_provider.dart';
import 'package:smart_retiree/utils/core_utils.dart';
import 'package:smart_retiree/utils/image_upload.dart';
import 'package:smart_retiree/utils/loader.dart';
import 'package:smart_retiree/utils/max_char_input_formater.dart';
import 'package:smart_retiree/utils/theme_extension.dart';

class CreatePostScreen extends ConsumerStatefulWidget {
  const CreatePostScreen({super.key});

  @override
  ConsumerState<CreatePostScreen> createState() => _CreatePostScreenState();
}

class _CreatePostScreenState extends ConsumerState<CreatePostScreen> {
  int count = 0;
  int maxCharLength = 300;
  late TextEditingController textEditingController;

  @override
  void initState() {
    textEditingController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    textEditingController.dispose();
    super.dispose();
  }

  void chageCount(int value) {
    setState(() {
      count = value;
    });
  }

  final TextEditingController _tagController = TextEditingController();
  final List<String> _tags = [];

  void _addTag(String tag) {
    final trimmed = tag.trim();
    if (trimmed.isNotEmpty && !_tags.contains(trimmed)) {
      setState(() {
        _tags.add(trimmed);
      });
    }
    _tagController.clear();
  }

  void _removeTag(String tag) {
    setState(() {
      _tags.remove(tag);
    });
  }

  File? _selectedImage;
  final ImagePicker _picker = ImagePicker();

  Future<void> _pickImage() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        _selectedImage = File(image.path);
      });
    }
  }

  void _removeImage() {
    setState(() {
      _selectedImage = null;
    });
  }

  void _imageUpload() async {
    if (textEditingController.text.isNotEmpty) {
      try {
        Loader.show(true);
        String? imageUrl;
        if (_selectedImage != null) {
          imageUrl = await ImageUpload.uploadImageToCloudinary(_selectedImage!);
        }
        await _savePost(imageUrl);
      } catch (e) {
        CoreUtils.showToast(
            type: ToastType.error, message: "Error: ${e.toString()}");
      } finally {
        Loader.show(false);
      }
    } else {
      CoreUtils.showToast(
          type: ToastType.error, message: "Please provide something you mind");
    }
  }

  Future<void> _savePost(String? imageUrl) async {
    try {
      final user = ref.read(userProvider)!;
      final post = AppPost(
        id: '',
        title: textEditingController.text.trim(),
        imageUrl: imageUrl,
        createdAt: DateTime.now(),
        createdBy: PostUser(
          id: user.uid,
          fullName: user.fullName,
          occupation: user.occupation,
          profilePhoto: user.profilePhoto,
        ),
        tags: _tags,
        likes: [],
        commentsCount: 0,
      );
      await FirebaseFirestore.instance.collection('posts').add(post.toMap());

      CoreUtils.showToast(
          type: ToastType.success, message: "Post created successfully!");
      CoreUtils.postFrameCall(() => Navigator.pop(context));
    } catch (e) {
      rethrow;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Icon(
            MingCuteIcons.mgc_close_circle_line,
            size: 30,
            color: context.primary,
          ),
        ),
        centerTitle: true,
        title: const Text(
          "Create Post",
          style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w700,
            color: Color(0xFF15294B),
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 8),
            child: IconButton(
              onPressed: _imageUpload,
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
        child: ListView(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
          children: [
            _selectedImage != null
                ? Stack(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: AspectRatio(
                          aspectRatio: 1.25,
                          child: Image.file(
                            _selectedImage!,
                            fit: BoxFit.cover,
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
                : ElevatedButton.icon(
                    onPressed: _pickImage,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: context.primary,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 12),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8)),
                    ),
                    icon: const Icon(
                      Icons.image,
                      color: Colors.white,
                    ),
                    label: const Text("Add Image"),
                  ),
            const SizedBox(
              height: 16,
            ),
            Container(
              padding: const EdgeInsets.all(16),
              width: double.maxFinite,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey.shade300, width: 1.25),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextField(
                    controller: textEditingController,
                    maxLines: 7,
                    inputFormatters: [
                      MaxCharTextInputFormater(
                        maxChars: maxCharLength,
                        currentLength: chageCount,
                      )
                    ],
                    decoration: const InputDecoration(
                      fillColor: Colors.transparent,
                      hintText: "Say what's on your mind...",
                      border: InputBorder.none,
                      disabledBorder: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      errorBorder: InputBorder.none,
                    ),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: Text(
                      "$count/$maxCharLength",
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: Color(0xFF7A8699),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            TextField(
              controller: _tagController,
              decoration: InputDecoration(
                fillColor: Colors.transparent,
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                labelText: 'Enter a tag',
                suffixIcon: IconButton(
                  icon: const Icon(Icons.add),
                  onPressed: () => _addTag(_tagController.text),
                ),
              ),
              onSubmitted: _addTag,
            ),
            const SizedBox(height: 10),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: _tags
                  .map((tag) => Chip(
                        label: Text(tag),
                        onDeleted: () => _removeTag(tag),
                        deleteIconColor: context.primary,
                      ))
                  .toList(),
            ),
          ],
        ),
      ),
    );
  }
}
