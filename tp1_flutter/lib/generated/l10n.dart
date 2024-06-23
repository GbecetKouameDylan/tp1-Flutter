// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(_current != null,
        'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(instance != null,
        'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?');
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Username`
  String get userName {
    return Intl.message(
      'Username',
      name: 'userName',
      desc: '',
      args: [],
    );
  }

  /// `Enter a username`
  String get QName {
    return Intl.message(
      'Enter a username',
      name: 'QName',
      desc: '',
      args: [],
    );
  }

  /// `Password`
  String get Password {
    return Intl.message(
      'Password',
      name: 'Password',
      desc: '',
      args: [],
    );
  }

  /// `Enter a password`
  String get QPassword {
    return Intl.message(
      'Enter a password',
      name: 'QPassword',
      desc: '',
      args: [],
    );
  }

  /// `Confimr youre Password`
  String get QConfirmPassword {
    return Intl.message(
      'Confimr youre Password',
      name: 'QConfirmPassword',
      desc: '',
      args: [],
    );
  }

  /// `Signup`
  String get Signup {
    return Intl.message(
      'Signup',
      name: 'Signup',
      desc: '',
      args: [],
    );
  }

  /// `Home`
  String get Home {
    return Intl.message(
      'Home',
      name: 'Home',
      desc: '',
      args: [],
    );
  }

  /// `Deadline`
  String get Deadline {
    return Intl.message(
      'Deadline',
      name: 'Deadline',
      desc: '',
      args: [],
    );
  }

  /// `Add a task`
  String get AddATask {
    return Intl.message(
      'Add a task',
      name: 'AddATask',
      desc: '',
      args: [],
    );
  }

  /// `Log out`
  String get LogOut {
    return Intl.message(
      'Log out',
      name: 'LogOut',
      desc: '',
      args: [],
    );
  }

  /// `Creation of task`
  String get Creationoftask {
    return Intl.message(
      'Creation of task',
      name: 'Creationoftask',
      desc: '',
      args: [],
    );
  }

  /// `Task`
  String get Task {
    return Intl.message(
      'Task',
      name: 'Task',
      desc: '',
      args: [],
    );
  }

  /// `Enter a name for your task`
  String get QTask {
    return Intl.message(
      'Enter a name for your task',
      name: 'QTask',
      desc: '',
      args: [],
    );
  }

  /// `Chosse a date`
  String get Choose {
    return Intl.message(
      'Chosse a date',
      name: 'Choose',
      desc: '',
      args: [],
    );
  }

  /// `Consulatation`
  String get Consultation {
    return Intl.message(
      'Consulatation',
      name: 'Consultation',
      desc: '',
      args: [],
    );
  }

  /// `Number`
  String get Number {
    return Intl.message(
      'Number',
      name: 'Number',
      desc: '',
      args: [],
    );
  }

  /// `Enter a number`
  String get QNumber {
    return Intl.message(
      'Enter a number',
      name: 'QNumber',
      desc: '',
      args: [],
    );
  }

  /// `Swicht the percentage`
  String get Change {
    return Intl.message(
      'Swicht the percentage',
      name: 'Change',
      desc: '',
      args: [],
    );
  }

  /// `Task Percentage :`
  String get Percentage {
    return Intl.message(
      'Task Percentage :',
      name: 'Percentage',
      desc: '',
      args: [],
    );
  }

  /// `Percentage between the date of the Task and now :`
  String get PercentageDeadline {
    return Intl.message(
      'Percentage between the date of the Task and now :',
      name: 'PercentageDeadline',
      desc: '',
      args: [],
    );
  }

  /// `Connexion`
  String get Connexion {
    return Intl.message(
      'Connexion',
      name: 'Connexion',
      desc: '',
      args: [],
    );
  }

  /// `Choose a image`
  String get Image {
    return Intl.message(
      'Choose a image',
      name: 'Image',
      desc: '',
      args: [],
    );
  }

  /// `Send a image`
  String get Simage {
    return Intl.message(
      'Send a image',
      name: 'Simage',
      desc: '',
      args: [],
    );
  }

  /// `No connection`
  String get NetworkError {
    return Intl.message(
      'No connection',
      name: 'NetworkError',
      desc: '',
      args: [],
    );
  }

  /// `Retry`
  String get Retry {
    return Intl.message(
      'Retry',
      name: 'Retry',
      desc: '',
      args: [],
    );
  }

  /// `Confirmation of your Password`
  String get ConfirmPassword {
    return Intl.message(
      'Confirmation of your Password',
      name: 'ConfirmPassword',
      desc: '',
      args: [],
    );
  }

  /// `Password do not macht`
  String get PasswordsDoNotMatch {
    return Intl.message(
      'Password do not macht',
      name: 'PasswordsDoNotMatch',
      desc: '',
      args: [],
    );
  }

  /// `Username is already taken`
  String get UsernameTaken {
    return Intl.message(
      'Username is already taken',
      name: 'UsernameTaken',
      desc: '',
      args: [],
    );
  }

  /// `Username too short`
  String get UsernameTooShort {
    return Intl.message(
      'Username too short',
      name: 'UsernameTooShort',
      desc: '',
      args: [],
    );
  }

  /// `Password to short`
  String get PasswordTooShort {
    return Intl.message(
      'Password to short',
      name: 'PasswordTooShort',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'fr'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
