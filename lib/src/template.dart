const templateString = '''
class Assets {
{{#assets.assets}}
/// {{{path}}}
static const {{name}} = Asset({{{path}}});
{{/assets.assets}}
}

static I18n {

{{#i18n.defaultValues.strings}}

static const {{key}}Key = {{escapedKey}};
/// {{value}}
String get {{key}} => {{value}};
{{/i18n.defaultValues.strings}}

}


{{#fonts}}
{{.}}
{{/fonts}}
''';
