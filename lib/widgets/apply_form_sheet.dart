import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/job.dart';
import '../providers/applications_notifier.dart';

class ApplyFormSheet extends ConsumerStatefulWidget {
  final Job job;

  const ApplyFormSheet({
    super.key,
    required this.job,
  });

  @override
  ConsumerState<ApplyFormSheet> createState() => _ApplyFormSheetState();
}

class _ApplyFormSheetState extends ConsumerState<ApplyFormSheet> {
  final _formKey = GlobalKey<FormState>();

  final _fullNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _experienceController = TextEditingController();
  final _coverLetterController = TextEditingController();
  final _linkedInController = TextEditingController();

  bool _availableImmediately = false;
  bool _submitting = false;

  int _noticeWeeks = 2;

  @override
  void dispose() {
    _fullNameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _experienceController.dispose();
    _coverLetterController.dispose();
    _linkedInController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    setState(() => _submitting = true);

    try {
      await ref.read(applicationsProvider.notifier).apply(
        job: widget.job,
        fullName: _fullNameController.text.trim(),
        email: _emailController.text.trim(),
        phone: _phoneController.text.trim().isEmpty
            ? null
            : _phoneController.text.trim(),
        yearsOfExperience:
        int.tryParse(_experienceController.text.trim()) ?? 0,
        coverLetter: _coverLetterController.text.trim(),
        linkedInUrl: _linkedInController.text.trim().isEmpty
            ? null
            : _linkedInController.text.trim(),
        availableImmediately: _availableImmediately,
        noticePeriodWeeks: _noticeWeeks,
      );

      if (!mounted) return;

      Navigator.pop(context, true);
    } catch (e) {
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            e.toString().replaceFirst('Exception: ', ''),
          ),
        ),
      );
    } finally {
      if (mounted) {
        setState(() => _submitting = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.only(
          left: 20,
          right: 20,
          top: 20,
          bottom: MediaQuery.of(context).viewInsets.bottom + 20,
        ),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "Apply for ${widget.job.title}",
                  style: Theme.of(context).textTheme.headlineSmall,
                ),

                const SizedBox(height: 20),

                TextFormField(
                  controller: _fullNameController,
                  decoration: const InputDecoration(
                    labelText: "Full Name",
                  ),
                  validator: (value) =>
                  value == null || value.isEmpty
                      ? "Required"
                      : null,
                ),

                const SizedBox(height: 12),

                TextFormField(
                  controller: _emailController,
                  decoration:
                  const InputDecoration(labelText: "Email"),
                  validator: (value) =>
                  value == null || value.isEmpty
                      ? "Required"
                      : null,
                ),

                const SizedBox(height: 12),

                TextFormField(
                  controller: _phoneController,
                  decoration:
                  const InputDecoration(labelText: "Phone"),
                ),

                const SizedBox(height: 12),

                TextFormField(
                  controller: _experienceController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    labelText: "Years of Experience",
                  ),
                  validator: (value) =>
                  value == null || value.isEmpty
                      ? "Required"
                      : null,
                ),

                const SizedBox(height: 12),

                TextFormField(
                  controller: _linkedInController,
                  decoration: const InputDecoration(
                    labelText: "LinkedIn URL",
                  ),
                ),

                const SizedBox(height: 12),

                TextFormField(
                  controller: _coverLetterController,
                  decoration: const InputDecoration(
                    labelText: "Cover Letter",
                  ),
                  maxLines: 5,
                  validator: (value) =>
                  value == null || value.isEmpty
                      ? "Required"
                      : null,
                ),

                const SizedBox(height: 12),

                SwitchListTile(
                  title: const Text("Available Immediately"),
                  value: _availableImmediately,
                  onChanged: (value) {
                    setState(() {
                      _availableImmediately = value;
                    });
                  },
                ),

                DropdownButtonFormField<int>(
                  initialValue: _noticeWeeks,
                  decoration: const InputDecoration(
                    labelText: "Notice Period",
                  ),
                  items: List.generate(
                    13,
                        (index) => DropdownMenuItem(
                      value: index,
                      child: Text("$index weeks"),
                    ),
                  ),
                  onChanged: (value) {
                    if (value != null) {
                      setState(() {
                        _noticeWeeks = value;
                      });
                    }
                  },
                ),

                const SizedBox(height: 24),

                FilledButton(
                  onPressed: _submitting ? null : _submit,
                  child: _submitting
                      ? const SizedBox(
                    height: 22,
                    width: 22,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                    ),
                  )
                      : const Text("Submit Application"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}