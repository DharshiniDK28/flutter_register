import 'package:app2/router_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:app2/Register_bloc/register_bloc.dart';
import 'package:app2/data/repositories/register_repository.dart';
import 'package:app2/form_bloc/form_submission_status.dart';
import 'package:flutter_adaptive_scaffold/flutter_adaptive_scaffold.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:dropdown_button2/dropdown_button2.dart';

class RegisterScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RegisterBloc(
        registerRepository: RepositoryProvider.of<RegisterRepository>(context),
      ),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 1,
          title: Text('Create Account', style: TextStyle(color: Colors.black)),
          centerTitle: true,
          iconTheme: IconThemeData(color: Colors.black),
        ),
        body: SlotLayout(
          config: <Breakpoint, SlotLayoutConfig>{
            Breakpoints.small: SlotLayout.from(
              key: const Key('mobileView'),
              builder: (_) => Padding(
                padding: const EdgeInsets.all(20),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      _buildProfilePicture(),
                      const SizedBox(height: 20),
                      const Text(
                        'Profile Picture',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      RegisterForm(),
                    ],
                  ),
                ),
              ),
            ),
            Breakpoints.mediumAndUp: SlotLayout.from(
              key: const Key('tabletView'),
              builder: (_) => Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          _buildProfilePicture(),
                          const SizedBox(height: 20),
                          const Text(
                            'Profile Picture',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: RegisterForm(),
                    ),
                  ),
                ],
              ),
            ),
          },
        ),
      ),
    );
  }

  Widget _buildProfilePicture() => Container(
    width: 160,
    height: 160,
    decoration: BoxDecoration(
      shape: BoxShape.circle,
      border: Border.all(color: Colors.deepPurple, width: 3),
    ),
    child: ClipOval(
      child: Image.asset('assets/profile.png', fit: BoxFit.cover),
    ),
  );
}

class RegisterForm extends StatefulWidget {
  @override
  _RegisterFormState createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  final _formKey = GlobalKey<FormState>();
  bool _isPasswordVisible = false;
  bool _isConfirmPasswordVisible = false;
  bool _genderError = false;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<RegisterBloc, RegisterState>(
      listener: (context, state) {
        if (state.formStatus is SubmissionSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Registration Successful!'))
          );
          context.go('/home');
        } else if (state.formStatus is SubmissionFailed) {
          ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Registration Failed'))
          );
        }
      },
      builder: (context, state) {
        return Stack(
          children: [
            AbsorbPointer(
              absorbing: state.formStatus is FormSubmitting,
              child: Opacity(
                opacity: state.formStatus is FormSubmitting ? 0.5 : 1.0,
                child: Form(
                  key: _formKey,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        const SizedBox(height: 20),
                        _buildInputField(
                          label: 'Name',
                          icon: Icons.person,
                          initialValue: state.name,
                          onChanged: (v) =>
                              context.read<RegisterBloc>().add(NameChanged(v)),
                          validator: (v) =>
                          v!.isEmpty
                              ? 'Name is required'
                              : null,
                        ),
                        _buildInputField(
                          label: 'Email',
                          icon: Icons.email,
                          initialValue: state.email,
                          onChanged: (v) =>
                              context.read<RegisterBloc>().add(EmailChanged(v)),
                          validator: (v) =>
                          v!.isEmpty || !v.contains('@')
                              ? 'Valid email required'
                              : null,
                        ),
                        _buildInputField(
                          label: 'Phone',
                          icon: Icons.phone,
                          initialValue: state.phone,
                          onChanged: (v) =>
                              context.read<RegisterBloc>().add(PhoneChanged(v)),
                          validator: (v) =>
                          v!.isEmpty
                              ? 'Phone required'
                              : null,
                        ),
                        TextFormField(
                          readOnly: true,
                          controller: TextEditingController(text: state.dob),
                          decoration: _inputDecoration(
                              'Date of Birth', Icons.calendar_today),
                          onTap: () async {
                            final d = await showDatePicker(
                              context: context,
                              initialDate: DateTime(2000),
                              firstDate: DateTime(1900),
                              lastDate: DateTime.now(),
                            );
                            if (d != null) context.read<RegisterBloc>().add(DobChanged(d.toIso8601String().split('T')[0]));
                          },
                          validator: (v) => v!.isEmpty ? 'DOB required' : null,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                const Text('Gender: '),
                                Radio<String>(
                                  value: 'Male', groupValue: state.gender,
                                  onChanged: (v) {
                                    context.read<RegisterBloc>().add(
                                        GenderChanged(v!));
                                    setState(() => _genderError = false);
                                  },
                                ), const Text('Male'),
                                Radio<String>(
                                  value: 'Female', groupValue: state.gender,
                                  onChanged: (v) {
                                    context.read<RegisterBloc>().add(
                                        GenderChanged(v!));
                                    setState(() => _genderError = false);
                                  },
                                ), const Text('Female'),
                              ],
                            ),
                            if (_genderError)
                              const Padding(
                                padding: EdgeInsets.only(left: 8),
                                child: Text('Please select a gender',
                                    style: TextStyle(
                                        color: Colors.red, fontSize: 12)),
                              ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        _buildDropdown(
                          'Street', Icons.streetview,
                          [
                            'Main Street',
                            'High Street',
                            'MG Road',
                            'Brigade Road'
                          ],
                          state.street,
                              (v) =>
                              context.read<RegisterBloc>().add(
                                  StreetChanged(v!)),
                        ),
                        _buildDropdown(
                          'State', Icons.location_city,
                          [
                            'Tamil Nadu',
                            'Karnataka',
                            'Kerala',
                            'Andhra Pradesh'
                          ],
                          state.state,
                              (v) =>
                              context.read<RegisterBloc>().add(
                                  StateChanged(v!)),
                        ),
                        _buildDropdown(
                          'Country', Icons.flag,
                          ['India', 'USA', 'UK', 'Australia'],
                          state.country,
                              (v) =>
                              context.read<RegisterBloc>().add(
                                  CountryChanged(v!)),
                        ),
                        const SizedBox(height: 12),
                        TextFormField(
                          initialValue: state.about,
                          maxLength: 50,
                          maxLines: null,
                          decoration: _inputDecoration(
                              'About Yourself', Icons.info),
                          onChanged: (v) =>
                              context.read<RegisterBloc>().add(AboutChanged(v)),
                        ),
                        _buildPasswordField(
                          initialValue: state.password,
                          onChanged: (v) =>
                              context.read<RegisterBloc>().add(
                                  PasswordChanged(v)),
                          isVisible: _isPasswordVisible,
                          toggle: () =>
                              setState(() =>
                              _isPasswordVisible = !_isPasswordVisible),
                        ),
                        _buildPasswordField(
                          initialValue: state.password,
                          onChanged: (_) {},
                          isVisible: _isConfirmPasswordVisible,
                          toggle: () =>
                              setState(() =>
                              _isConfirmPasswordVisible =
                              !_isConfirmPasswordVisible),
                          isConfirm: true,
                        ),
                        Row(
                          children: [
                            Checkbox(
                              value: state.termsAccepted,
                              onChanged: (v) =>
                                  context.read<RegisterBloc>().add(
                                      TermsChanged(v!)),
                            ),
                            const Flexible(child: Text(
                                'I agree to the terms and conditions')),
                          ],
                        ),
                        const SizedBox(height: 20),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () {
                              final valid = _formKey.currentState!.validate();
                              final genderOk = state.gender.isNotEmpty;
                              setState(() => _genderError = !genderOk);
                              if (valid && genderOk && state.termsAccepted) {
                                context.read<RegisterBloc>().add(
                                    SubmitRegister());
                              } else if (!state.termsAccepted) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(content: Text(
                                        'Please accept terms and conditions'))
                                );
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.deepPurple,
                              padding: const EdgeInsets.symmetric(vertical: 15),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12)),
                            ),
                            child: const Text('Register',
                                style: TextStyle(color: Colors.white)),
                          ),
                        ),
                        const SizedBox(height: 20),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            if (state.formStatus is FormSubmitting)
              Container(
                color: Colors.black.withOpacity(0.5),
                child: const Center(
                  child: SpinKitFadingCircle(color: Colors.white, size: 50),
                ),
              ),
          ],
        );
      },
    );
  }

  Padding _buildInputField({
    required String label,
    required IconData icon,
    required String? initialValue,
    required ValueChanged<String> onChanged,
    String? Function(String?)? validator,
  }) =>
      Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: TextFormField(
          initialValue: initialValue,
          decoration: _inputDecoration(label, icon),
          onChanged: onChanged,
          validator: validator,
        ),
      );

  Padding _buildDropdown(
      String label,
      IconData icon,
      List<String> items,
      String current,
      ValueChanged<String?> onChanged,
      ) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: DropdownButtonHideUnderline(
        child: DropdownButtonFormField2<String>(
          decoration: _inputDecoration(label, icon),
          isExpanded: true,
          buttonStyleData: ButtonStyleData(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            height: 30,
            decoration: BoxDecoration(
              color: Colors.grey.shade100,
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          iconStyleData: const IconStyleData(
            icon: Icon(Icons.arrow_drop_down, color: Colors.deepPurple),
            iconSize: 24,
          ),
          dropdownStyleData: DropdownStyleData(
            maxHeight: 200,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
            ),
            elevation: 8,
          ),
          items: items
              .map((i) => DropdownMenuItem<String>(
            value: i,
            child: Text(i, style: const TextStyle(fontSize: 16)),
          ))
              .toList(),
          value: current.isEmpty ? null : current,
          onChanged: onChanged,
          validator: (v) =>
          (v == null || v.isEmpty) ? '$label is required' : null,
        ),
      ),
    );
  }
  Padding _buildPasswordField({
    required String? initialValue,
    required ValueChanged<String> onChanged,
    required bool isVisible,
    required VoidCallback toggle,
    bool isConfirm = false,
  }) =>
      Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: TextFormField(
          obscureText: !isVisible,
          initialValue: initialValue,
          decoration: InputDecoration(
            labelText: isConfirm ? 'Confirm Password' : 'Password',
            prefixIcon: const Icon(Icons.lock),
            filled: true,
            fillColor: Colors.grey.shade100,
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
            suffixIcon: IconButton(
              icon: Icon(isVisible ? Icons.visibility : Icons.visibility_off),
              onPressed: toggle,
            ),
          ),
          onChanged: onChanged,
          validator: (v) {
            if (isConfirm)
              return v != initialValue ? 'Passwords do not match' : null;
            return v == null || v.isEmpty ? 'Password is required' : null;
          },
        ),
      );

  InputDecoration _inputDecoration(String label, IconData icon) =>
      InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon),
        filled: true,
        fillColor: Colors.grey.shade100,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
      );
}
