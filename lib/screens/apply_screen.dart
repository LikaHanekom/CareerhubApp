import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

import '../models/auth_state.dart';
import '../providers/auth_notifier.dart';

class ApplyScreen extends HookConsumerWidget {
  const ApplyScreen({super.key, required this.jobId});

  final String jobId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Stable across rebuilds — created once, survives every build of
    // this widget until it unmounts. If this were a plain local
    // variable, a new GlobalKey would be created on every build and
    // FormBuilder would be unmounted/remounted, wiping field state.
    final formKey = useMemoized(() => GlobalKey<FormBuilderState>());

    // One-time read — the logged-in user's email doesn't change while
    // this screen is open, so ref.watch would just be an unnecessary
    // subscription.
    final authState = ref.read(authProvider).asData?.value;
    final userEmail = authState is Authenticated ? authState.user.email : null;

    void submit() {
      final isValid = formKey.currentState?.saveAndValidate() ?? false;
      if (!isValid) return;

      final values = formKey.currentState!.value;
      debugPrint('Application submitted: $values');

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Application submitted!')),
      );
      Navigator.of(context).pop();
    }

    return Scaffold(
      appBar: AppBar(title: const Text('Apply for this job')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: FormBuilder(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              FormBuilderTextField(
                name: 'full_name',
                decoration: const InputDecoration(labelText: 'Full name'),
                validator: FormBuilderValidators.compose([
                  FormBuilderValidators.required(),
                  FormBuilderValidators.minLength(2),
                ]),
              ),
              const SizedBox(height: 16),

              FormBuilderTextField(
                name: 'email',
                initialValue: userEmail,
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(labelText: 'Email'),
                validator: FormBuilderValidators.compose([
                  FormBuilderValidators.required(),
                  FormBuilderValidators.email(),
                ]),
              ),
              const SizedBox(height: 16),

              FormBuilderTextField(
                name: 'cover_letter',
                minLines: 5,
                maxLines: 10,
                decoration: const InputDecoration(
                  labelText: 'Cover letter',
                  alignLabelWithHint: true,
                ),
                validator: FormBuilderValidators.compose([
                  FormBuilderValidators.required(),
                  FormBuilderValidators.minLength(50),
                ]),
              ),
              const SizedBox(height: 16),

              FormBuilderTextField(
                name: 'years_experience',
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'Years of experience',
                ),
                validator: FormBuilderValidators.compose([
                  FormBuilderValidators.required(),
                      (value) {
                    final parsed = int.tryParse(value ?? '');
                    if (parsed == null || parsed < 0) {
                      return 'Enter a valid non-negative number';
                    }
                    return null;
                  },
                ]),
              ),
              const SizedBox(height: 16),

              FormBuilderDateTimePicker(
                name: 'start_date',
                inputType: InputType.date,
                decoration: const InputDecoration(
                  labelText: 'Earliest start date',
                ),
                validator: FormBuilderValidators.compose([
                  FormBuilderValidators.required(),
                      (value) {
                    if (value == null) return 'Please select a date';
                    final today = DateTime.now().copyWith(
                      hour: 0,
                      minute: 0,
                      second: 0,
                      millisecond: 0,
                      microsecond: 0,
                    );
                    final selected = value.copyWith(
                      hour: 0,
                      minute: 0,
                      second: 0,
                      millisecond: 0,
                      microsecond: 0,
                    );
                    if (selected.isBefore(today)) {
                      return 'Start date cannot be in the past';
                    }
                    return null;
                  },
                ]),
              ),
              const SizedBox(height: 16),

              FormBuilderTextField(
                name: 'portfolio_url',
                keyboardType: TextInputType.url,
                decoration: const InputDecoration(
                  labelText: 'Portfolio URL (optional)',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) return null;
                  return FormBuilderValidators.url()(value);
                },
              ),
              const SizedBox(height: 16),

              FormBuilderCheckbox(
                name: 'terms',
                title: const Text(
                  'I confirm my application is accurate and complete.',
                ),
                validator: (value) {
                  if (value != true) {
                    return 'You must confirm before submitting';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 24),

              FilledButton(
                onPressed: submit,
                child: const Text('Submit application'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
