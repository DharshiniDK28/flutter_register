import 'package:app2/Register_bloc/register_event.dart';
import 'package:app2/Register_bloc/register_state.dart';
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
                      Container(
                        width: 160,
                        height: 160,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.deepPurple, width: 3),
                        ),
                        child: ClipOval(
                          child: Image.asset('assets/profile.png', fit: BoxFit.cover),
                        ),
                      ),
                      const SizedBox(height: 20),
                      const Text('Profile Picture', style: TextStyle(fontWeight: FontWeight.bold)),
                      const SizedBox(height: 20),
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
                          Container(
                            width: 160,
                            height: 160,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(color: Colors.deepPurple, width: 3),
                            ),
                            child: ClipOval(
                              child: Image.asset('assets/profile.png', fit: BoxFit.cover),
                            ),
                          ),
                          const SizedBox(height: 20),
                          const Text('Profile Picture', style: TextStyle(fontWeight: FontWeight.bold)),
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
}

class RegisterForm extends StatefulWidget {
  @override
  _RegisterFormState createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  final _formKey = GlobalKey<FormState>();
  bool _isPasswordVisible = false;
  bool _isConfirmPasswordVisible = false;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<RegisterBloc, RegisterState>(
      listener: (context, state) {
        if (state.formStatus is SubmissionSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Registration Successful!')),
          );
          context.go('/home');
        } else if (state.formStatus is SubmissionFailed) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Registration Failed')),
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
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(bottom: 16),
                          child: TextFormField(
                            initialValue: state.name,
                            decoration: InputDecoration(
                              labelText: 'Name',
                              prefixIcon: Icon(Icons.person),
                              filled: true,
                              fillColor: Colors.grey.shade100,
                              border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                              errorText: state.isNameValid ? null : 'Invalid Name',
                            ),
                            onChanged: (v) => context.read<RegisterBloc>().add(NameChanged(v)),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 16),
                          child: TextFormField(
                            initialValue: state.email,
                            decoration: InputDecoration(
                              labelText: 'Email',
                              prefixIcon: Icon(Icons.email),
                              filled: true,
                              fillColor: Colors.grey.shade100,
                              border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                              errorText: state.isEmailValid ? null : 'Invalid Email',
                            ),
                            onChanged: (v) => context.read<RegisterBloc>().add(EmailChanged(v)),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 16),
                          child: TextFormField(
                            initialValue: state.phone,
                            decoration: InputDecoration(
                              labelText: 'Phone',
                              prefixIcon: Icon(Icons.phone),
                              filled: true,
                              fillColor: Colors.grey.shade100,
                              border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                              errorText: state.isPhoneValid ? null : 'Invalid Phone',
                            ),
                            onChanged: (v) => context.read<RegisterBloc>().add(PhoneChanged(v)),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 16),
                          child: TextFormField(
                            controller: TextEditingController(text: state.dob),
                            decoration: InputDecoration(
                              labelText: 'Date of Birth',
                              prefixIcon: Icon(Icons.calendar_today),
                              filled: true,
                              fillColor: Colors.grey.shade100,
                              border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                              errorText: state.isDobValid ? null : 'Enter your date of birth',
                            ),
                            readOnly: true,
                            onTap: () async {
                              final d = await showDatePicker(
                                context: context,
                                initialDate: DateTime(2000),
                                firstDate: DateTime(1900),
                                lastDate: DateTime.now(),
                              );
                              if (d != null) {
                                context.read<RegisterBloc>().add(DobChanged(d.toIso8601String().split('T')[0]));
                              }
                            },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  const Text('Gender: '),
                                  Radio<String>(
                                    value: 'Male',
                                    groupValue: state.gender,
                                    onChanged: (v) => context.read<RegisterBloc>().add(GenderChanged(v!)),
                                  ),
                                  const Text('Male'),
                                  Radio<String>(
                                    value: 'Female',
                                    groupValue: state.gender,
                                    onChanged: (v) => context.read<RegisterBloc>().add(GenderChanged(v!)),
                                  ),
                                  const Text('Female'),
                                ],
                              ),
                              if (!state.isGenderValid)
                                const Text('Select gender', style: TextStyle(color: Colors.red)),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 16),
                          child: DropdownButtonFormField2<String>(
                            decoration: InputDecoration(
                              labelText: 'Street',
                              prefixIcon: Icon(Icons.streetview),
                              filled: true,
                              fillColor: Colors.grey.shade100,
                              border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                              errorText: state.isStreetValid ? null : 'Select Street',
                            ),
                            isExpanded: true,
                            items: ['Main Street', 'High Street', 'MG Road', 'Brigade Road']
                                .map((i) => DropdownMenuItem<String>(value: i, child: Text(i)))
                                .toList(),
                            value: state.street.isEmpty ? null : state.street,
                            onChanged: (v) => context.read<RegisterBloc>().add(StreetChanged(v!)),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 16),
                          child: DropdownButtonFormField2<String>(
                            decoration: InputDecoration(
                              labelText: 'State',
                              prefixIcon: Icon(Icons.location_city),
                              filled: true,
                              fillColor: Colors.grey.shade100,
                              border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                              errorText: state.isStateValid ? null : 'Select State',
                            ),
                            isExpanded: true,
                            items: ['Tamil Nadu', 'Karnataka', 'Kerala', 'Andhra Pradesh']
                                .map((i) => DropdownMenuItem<String>(value: i, child: Text(i)))
                                .toList(),
                            value: state.state.isEmpty ? null : state.state,
                            onChanged: (v) => context.read<RegisterBloc>().add(StateChanged(v!)),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 16),
                          child: DropdownButtonFormField2<String>(
                            decoration: InputDecoration(
                              labelText: 'Country',
                              prefixIcon: Icon(Icons.flag),
                              filled: true,
                              fillColor: Colors.grey.shade100,
                              border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                              errorText: state.isCountryValid ? null : 'Select Country',
                            ),
                            isExpanded: true,
                            items: ['India', 'USA', 'UK', 'Australia']
                                .map((i) => DropdownMenuItem<String>(value: i, child: Text(i)))
                                .toList(),
                            value: state.country.isEmpty ? null : state.country,
                            onChanged: (v) => context.read<RegisterBloc>().add(CountryChanged(v!)),
                          ),
                        ),
                        TextFormField(
                          initialValue: state.about,
                          maxLength: 50,
                          maxLines: null,
                          decoration: InputDecoration(
                            labelText: 'About Yourself',
                            prefixIcon: Icon(Icons.info),
                            filled: true,
                            fillColor: Colors.grey.shade100,
                            border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                            errorText: state.isAboutValid ? null : 'Write about yourself',
                          ),
                          onChanged: (v) => context.read<RegisterBloc>().add(AboutChanged(v)),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 16),
                          child: TextFormField(
                            obscureText: !_isPasswordVisible,
                            decoration: InputDecoration(
                              labelText: 'Password',
                              prefixIcon: Icon(Icons.lock),
                              suffixIcon: IconButton(
                                icon: Icon(_isPasswordVisible ? Icons.visibility : Icons.visibility_off),
                                onPressed: () => setState(() => _isPasswordVisible = !_isPasswordVisible),
                              ),
                              filled: true,
                              fillColor: Colors.grey.shade100,
                              border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                              errorText: state.isPasswordValid ? null : 'Password must be at least 8 characters',
                            ),
                            onChanged: (v) => context.read<RegisterBloc>().add(PasswordChanged(v)),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 16),
                          child: TextFormField(
                            obscureText: !_isConfirmPasswordVisible,
                            decoration: InputDecoration(
                              labelText: 'Confirm Password',
                              prefixIcon: Icon(Icons.lock),
                              suffixIcon: IconButton(
                                icon: Icon(_isConfirmPasswordVisible ? Icons.visibility : Icons.visibility_off),
                                onPressed: () => setState(() => _isConfirmPasswordVisible = !_isConfirmPasswordVisible),
                              ),
                              filled: true,
                              fillColor: Colors.grey.shade100,
                              border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                              errorText: state.isConfirmPasswordValid ? null : 'Passwords do not match',
                            ),
                            onChanged: (v) => context.read<RegisterBloc>().add(ConfirmPasswordChanged(v)),
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Checkbox(
                                  value: state.termsAccepted,
                                  onChanged: (v) => context.read<RegisterBloc>().add(TermsChanged(v!)),
                                ),
                                const Expanded(child: Text('I agree to the Terms and Conditions')),
                              ],
                            ),
                            if (!state.isTermsAccepted)
                              const Text('You must accept the terms', style: TextStyle(color: Colors.red)),
                          ],
                        ),
                        const SizedBox(height: 20),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                context.read<RegisterBloc>().add(SubmitRegister());
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(content: Text('Please fill in the fields correctly!')),
                                );
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.deepPurple,
                              padding: const EdgeInsets.symmetric(vertical: 15),
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                            ),
                            child: const Text('Register', style: TextStyle(color: Colors.white)),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            if (state.formStatus is FormSubmitting)
              Positioned.fill(
                child: Container(
                  color: Colors.black.withOpacity(0.3),
                  child: Center(
                    child: SpinKitCircle(
                      color: Colors.deepPurple,
                      size: 50.0,
                    ),
                  ),
                ),
              )
          ],
        );
      },
    );
  }
}
