import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:textile_markaz/data/dummy/dummy_data.dart';
import 'package:textile_markaz/data/models/textile_ad.dart';
import 'package:textile_markaz/screens/home_search_screen.dart';

class PostAdScreen extends StatefulWidget {
  static const routeName = '/post-ad';

  const PostAdScreen({super.key});

  @override
  State<PostAdScreen> createState() => _PostAdScreenState();
}

class _PostAdScreenState extends State<PostAdScreen> {
  final _formKey = GlobalKey<FormState>();
  final _titleCtrl = TextEditingController();
  final _descCtrl = TextEditingController();
  final _priceCtrl = TextEditingController();
  final _phoneCtrl = TextEditingController();
  String? _city;
  final ImagePicker _picker = ImagePicker();
  final List<XFile> _images = <XFile>[];
  DateTime? _expiryDate;

  @override
  void dispose() {
    _titleCtrl.dispose();
    _descCtrl.dispose();
    _priceCtrl.dispose();
    _phoneCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final args =
        (ModalRoute.of(context)?.settings.arguments as Map?) ??
            <String, dynamic>{};
    final mode = (args['mode'] as String?) ?? 'buy';
    final category = args['category'] as String?;

    final isBuy = mode == 'buy';

    return Scaffold(
      appBar: AppBar(
        title: Text(isBuy ? 'Create BUY ad' : 'Create SELL ad'),
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            Text(
              'I want to',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 10),
              decoration: BoxDecoration(
                color: const Color(0xFF112037),
                borderRadius: BorderRadius.circular(8),
              ),
              alignment: Alignment.center,
              child: Text(
                isBuy ? 'BUY' : 'SELL',
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            const SizedBox(height: 20),
            Text(
              'Basic Information',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
            ),
            const SizedBox(height: 12),
            TextFormField(
              controller: _titleCtrl,
              decoration: const InputDecoration(
                labelText: 'Ad Title *',
              ),
              validator: (v) =>
                  (v == null || v.trim().length < 4)
                      ? 'Enter a descriptive title'
                      : null,
            ),
            const SizedBox(height: 12),
            TextFormField(
              initialValue: category,
              enabled: false,
              decoration: const InputDecoration(
                labelText: 'Category *',
              ),
            ),
            const SizedBox(height: 12),
            DropdownButtonFormField<String>(
              value: _city,
              decoration: const InputDecoration(labelText: 'Select City *'),
              items: cities
                  .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                  .toList(),
              onChanged: (v) => setState(() => _city = v),
              validator: (v) => v == null ? 'Select a city' : null,
            ),
            const SizedBox(height: 12),
            TextFormField(
              controller: _descCtrl,
              decoration: const InputDecoration(
                labelText: 'Detailed Description *',
              ),
              minLines: 4,
              maxLines: 8,
              validator: (v) => (v == null || v.trim().length < 10)
                  ? 'Describe your requirement/item'
                  : null,
            ),
            const SizedBox(height: 20),
            Text(
              'Add Photos (Up to 5)',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
            ),
            const SizedBox(height: 8),
            SizedBox(
              height: 90,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: 5,
                separatorBuilder: (_, __) => const SizedBox(width: 8),
                itemBuilder: (context, index) {
                  final hasImage = index < _images.length;
                  return GestureDetector(
                    onTap: () async {
                      if (!mounted) return;
                      final picked = await _picker.pickImage(
                        source: ImageSource.gallery,
                        imageQuality: 80,
                      );
                      if (picked != null) {
                        setState(() {
                          if (_images.length < 5) {
                            _images.add(picked);
                          } else {
                            _images[index] = picked;
                          }
                        });
                      }
                    },
                    child: Container(
                      width: 90,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: Colors.grey.shade300),
                      ),
                      child: hasImage
                          ? ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: Image.file(
                                File(_images[index].path),
                                fit: BoxFit.cover,
                              ),
                            )
                          : const Center(
                              child: Text(
                                '+ Add Image',
                                textAlign: TextAlign.center,
                                style: TextStyle(fontSize: 12),
                              ),
                            ),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 20),
            Text(
              'Price Details',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
            ),
            const SizedBox(height: 8),
            TextFormField(
              controller: _priceCtrl,
              decoration: const InputDecoration(
                labelText: 'Asking Price *',
                prefixText: 'PKR ',
              ),
              keyboardType: TextInputType.number,
              validator: (v) => (v == null || v.trim().isEmpty)
                  ? 'Enter asking price or 0'
                  : null,
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _phoneCtrl,
              decoration: const InputDecoration(
                labelText: 'Contact Phone *',
                hintText: '+92 ...',
              ),
              keyboardType: TextInputType.phone,
              validator: (v) => (v == null || v.trim().length < 8)
                  ? 'Enter contact phone'
                  : null,
            ),
            const SizedBox(height: 20),
            Text(
              'Additional Details',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
            ),
            const SizedBox(height: 8),
            GestureDetector(
              onTap: () async {
                final now = DateTime.now();
                final picked = await showDatePicker(
                  context: context,
                  firstDate: DateTime(now.year, now.month, now.day),
                  lastDate: DateTime(now.year + 2),
                  initialDate: _expiryDate ??
                      DateTime(now.year, now.month, now.day).add(
                        const Duration(days: 7),
                      ),
                );
                if (picked != null) {
                  setState(() => _expiryDate = picked);
                }
              },
              child: AbsorbPointer(
                child: TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Ad Expiry Date *',
                    hintText: 'dd/mm/yyyy',
                    suffixIcon: Icon(Icons.calendar_month_outlined),
                  ),
                  controller: TextEditingController(
                    text: _expiryDate == null
                        ? ''
                        : '${_expiryDate!.day.toString().padLeft(2, '0')}/${_expiryDate!.month.toString().padLeft(2, '0')}/${_expiryDate!.year}',
                  ),
                  validator: (_) =>
                      _expiryDate == null ? 'Select expiry date' : null,
                ),
              ),
            ),
            const SizedBox(height: 24),
            FilledButton(
              onPressed: () {
                if (!(_formKey.currentState?.validate() ?? false)) return;
                final now = DateTime.now();
                final newAd = TextileAd(
                  id: now.millisecondsSinceEpoch.toString(),
                  title: _titleCtrl.text.trim(),
                  description: _descCtrl.text.trim(),
                  category: category ?? '',
                  mode: mode,
                  city: _city ?? '',
                  contactPhone: _phoneCtrl.text.trim(),
                  price: _priceCtrl.text.trim(),
                  createdAt: now,
                  expiryDate: _expiryDate ?? now.add(const Duration(days: 7)),
                  imagePaths: _images.map((x) => x.path).toList(),
                );
                dummyAds.insert(0, newAd);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Dummy ad posted successfully')),
                );
                Navigator.of(context)
                    .popUntil(ModalRoute.withName(HomeSearchScreen.routeName));
              },
              child: const Text('POST YOUR AD'),
            ),
          ],
        ),
      ),
    );
  }
}
