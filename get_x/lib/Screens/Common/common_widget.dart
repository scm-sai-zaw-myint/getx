import 'package:flutter/material.dart';

typedef OnDOBChange = Function(DateTime datetime);

class CommonWidget {
  static InputDecoration commonInput(title, isDOB, [OnDOBChange? onDOBChange]) {
    return InputDecoration(
      labelText: title,
      hintText: title,
      contentPadding: const EdgeInsets.all(5),
      border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(5))),
    );
  }

  static InputDecoration dobDecoration(
      contex, title, initialDate, OnDOBChange onDOBChange) {
    return InputDecoration(
      labelText: "Date of birth",
      hintText: "Date of birth",
      contentPadding: const EdgeInsets.all(5),
      border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(5))),
      suffixIcon: IconButton(
          onPressed: () async {
            DateTime? date =
                await _selectDate(contex, DateTime.parse(initialDate));
            if (date != null) {
              onDOBChange(date);
            }
          },
          icon: const Icon(Icons.calendar_month_outlined)),
    );
  }

  static Future<DateTime?> _selectDate(context, DateTime? initialDate) async {
    final DateTime? date = await showDatePicker(
      context: context,
      initialDate: initialDate ?? DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    return date;
  }

  static String? isValidName(name) {
    if (name == null || name.isEmpty) {
      return "Please enter customer name!";
    } else if (name.length < 4) {
      return "Customer name must contains at least 4 characters!";
    }
    return null;
  }

  static String? isValidEmail(email) {
    if (email == null || email.isEmpty) {
      return "Please enter customer email";
    } else if (RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(email)) {
      return "Invalid email address!";
    }
    return null;
  }

  static String? isValidPhone(phone) {
    if (phone == null || phone.isEmpty) {
      return "Please enter phone number!";
    } else if (RegExp(r'^\+[1-9]{1}[0-9]{3,14}$').hasMatch(phone)) {
      return "Invalid phone number!";
    }
    return null;
  }

  static String? isValidPassword(password) {
    if (password == null || password.isEmpty) {
      return "Please enter confirm password!";
    } else if (password.length < 6) {
      return "Password must contain at least 6 characters!";
    }
    return null;
  }

  static String? isValidConfirmPassword(confirmPw, pw) {
    if (confirmPw == null || confirmPw.isEmpty) {
      return "Please enter confirm password!";
    } else if (confirmPw.length < 6) {
      return "Password must contain at least 6 characters!";
    } else if (confirmPw != pw) {
      return "Password do mot match!";
    }
    return null;
  }

  static String? isValidDobNAddress(value, title) {
    if (value == null || value.isEmpty) {
      return "Please enter $title!";
    }
    return null;
  }
}
