import 'package:app2/router_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:app2/Register_bloc/register_bloc.dart';
import 'package:app2/data/repositories/register_repository.dart';
import 'package:app2/form_bloc/form_submission_status.dart';
import 'package:flutter_adaptive_scaffold/flutter_adaptive_scaffold.dart';
import 'package:go_router/go_router.dart';

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
                          child: Image.asset(
                            'assets/profile.png',
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
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
                          Container(
                            width: 160,
                            height: 160,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(color: Colors.deepPurple, width: 3),
                            ),
                            child: ClipOval(
                              child: Image.asset(
                                'assets/profile.png',
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
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
              SnackBar(content: Text('Registration Successful!')));
          context.go('/home');
        } else if (state.formStatus is SubmissionFailed) {
          ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Registration Failed')));
          context.go('/home');
        }
      },
      builder: (context, state) {
        return Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 20),
                _buildInputField(context, label: "Name",
                    icon: Icons.person,
                    initialValue: state.name,
                    onChanged: (val) => context.read<RegisterBloc>().add(NameChanged(val)),
                    validator: (val) => val!.isEmpty ? 'Name is required' : null),
                _buildInputField(context, label: "Email",
                    icon: Icons.email,
                    initialValue: state.email,
                    onChanged: (val) => context.read<RegisterBloc>().add(EmailChanged(val)),
                    validator: (val) => val!.isEmpty || !val.contains('@') ? 'Valid email required' : null),
                _buildInputField(context, label: "Phone", icon: Icons.phone, initialValue: state.phone,
                    onChanged: (val) => context.read<RegisterBloc>().add(PhoneChanged(val)),
                    validator: (val) => val!.isEmpty ? 'Phone required' : null),
                TextFormField(
                  readOnly: true,
                  controller: TextEditingController(text: state.dob),
                  decoration: _inputDecoration("Date of Birth", Icons.calendar_today),
                  onTap: () async {
                    final pickedDate = await showDatePicker(
                      context: context,
                      initialDate: DateTime(2000),
                      firstDate: DateTime(1900),
                      lastDate: DateTime.now(),
                    );
                    if (pickedDate != null) {
                      context.read<RegisterBloc>().add(
                          DobChanged(pickedDate.toString().split(" ")[0]));
                    }
                  },
                  validator: (val) => val!.isEmpty ? 'DOB required' : null,
                ),
                Row(
                  children: [
                    Text("Gender: "),
                    Radio<String>(
                      value: 'Male',
                      groupValue: state.gender,
                      onChanged: (value) => context.read<RegisterBloc>().add(GenderChanged(value!)),
                    ),
                    Text("Male"),
                    Radio<String>(
                      value: 'Female',
                      groupValue: state.gender,
                      onChanged: (value) => context.read<RegisterBloc>().add(GenderChanged(value!)),
                    ),
                    Text("Female"),
                  ],
                ),
                DropdownButtonFormField<String>(
                  value: state.street.isEmpty ? null : state.street,
                  decoration: _inputDecoration("Street", Icons.streetview),
                  items: ['Main Street', 'High Street', 'MG Road', 'Brigade Road']
                      .map((street) => DropdownMenuItem(value: street, child: Text(street)))
                      .toList(),
                  onChanged: (val) {
                    if (val != null) {
                      context.read<RegisterBloc>().add(StreetChanged(val));
                    }
                  },
                  validator: (val) => val == null || val.isEmpty ? 'Street is required' : null,
                ),
                const SizedBox(height: 12),

                DropdownButtonFormField<String>(
                  value: state.state.isEmpty ? null : state.state,
                  decoration: _inputDecoration("State", Icons.location_city),
                  items: ['Tamil Nadu', 'Karnataka', 'Kerala', 'Andhra Pradesh']
                      .map((stateItem) => DropdownMenuItem(value: stateItem, child: Text(stateItem)))
                      .toList(),
                  onChanged: (val) {
                    if (val != null) {
                      context.read<RegisterBloc>().add(StateChanged(val));
                    }
                  },
                  validator: (val) => val == null || val.isEmpty ? 'State is required' : null,
                ),
                const SizedBox(height: 12),

                DropdownButtonFormField<String>(
                  value: state.country.isEmpty ? null : state.country,
                  decoration: _inputDecoration("Country", Icons.flag),
                  items: ['India', 'USA', 'UK', 'Australia']
                      .map((country) => DropdownMenuItem(value: country, child: Text(country)))
                      .toList(),
                  onChanged: (val) {
                    if (val != null) {
                      context.read<RegisterBloc>().add(CountryChanged(val));
                    }
                  },
                  validator: (val) => val == null || val.isEmpty ? 'Country is required' : null,
                ),
                const SizedBox(height: 12),

                TextFormField(
                  initialValue: state.about,
                  maxLength: 50,
                  maxLines: 2,
                  decoration: _inputDecoration("About Yourself", Icons.info),
                  onChanged: (val) => context.read<RegisterBloc>().add(AboutChanged(val)),
                ),
                _buildPasswordField(context, state.password, (val) => context.read<RegisterBloc>().add(PasswordChanged(val)), _isPasswordVisible, () {
                  setState(() => _isPasswordVisible = !_isPasswordVisible);
                }),
                _buildPasswordField(context, state.password, (_) {}, _isConfirmPasswordVisible, () {
                  setState(() => _isConfirmPasswordVisible = !_isConfirmPasswordVisible);
                }, isConfirm: true),
                Row(
                  children: [
                    Checkbox(
                      value: state.termsAccepted,
                      onChanged: (val) => context.read<RegisterBloc>().add(TermsChanged(val!)),
                    ),
                    Flexible(child: Text('I agree to the terms and conditions')),
                  ],
                ),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        context.read<RegisterBloc>().add(SubmitRegister());
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.deepPurple,
                      padding: EdgeInsets.symmetric(vertical: 15),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    ),
                    child: Text('Register', style: TextStyle(color: Colors.white)),
                  ),
                ),

                if (state.formStatus is FormSubmitting)
                  CircularProgressIndicator(),

              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildInputField(BuildContext context, {
    required String label,
    required IconData icon,
    required String? initialValue,
    required void Function(String) onChanged,
    bool obscureText = false,
    String? Function(String?)? validator,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: TextFormField(
        initialValue: initialValue,
        obscureText: obscureText,
        decoration: _inputDecoration(label, icon),
        onChanged: onChanged,
        validator: validator,
      ),
    );
  }

  Widget _buildPasswordField(BuildContext context, String? initialValue,
      void Function(String) onChanged, bool isVisible, VoidCallback toggleVisibility,
      {bool isConfirm = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: TextFormField(
        obscureText: !isVisible,
        initialValue: initialValue,
        decoration: InputDecoration(
          labelText: isConfirm ? 'Confirm Password' : 'Password',
          prefixIcon: Icon(Icons.lock),
          filled: true,
          fillColor: Colors.grey.shade100,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
          suffixIcon: IconButton(
            icon: Icon(
              isVisible ? Icons.visibility : Icons.visibility_off,
            ),
            onPressed: toggleVisibility,
          ),
        ),
        onChanged: onChanged,
        validator: isConfirm
            ? (val) => val != initialValue ? 'Passwords do not match' : null
            : (val) => val!.isEmpty ? 'Password is required' : null,
      ),
    );
  }

  InputDecoration _inputDecoration(String label, IconData icon) {
    return InputDecoration(
      labelText: label,
      prefixIcon: Icon(icon),
      filled: true,
      fillColor: Colors.grey.shade100,
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
    );
  }
}
