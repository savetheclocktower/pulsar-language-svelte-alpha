exports.activate = function() {

  atom.grammars.addInjectionPoint('source.svelte', {
    type: 'style_element',

    language(element) {
      // A `style` element can opt into SCSS with `lang="scss"`.
      let attributes = element.descendantsOfType('attribute');
      for (let attribute of attributes) {
        if (attribute.firstNamedChild.text === 'lang') {
          return attribute.lastNamedChild.firstNamedChild?.text;
        }
      }
      return 'css';
    },

    content(element) {
      return element.descendantsOfType('raw_text');
    }
  });

  atom.grammars.addInjectionPoint('source.svelte', {
    type: 'script_element',

    language(element) {
      // A `script` element can opt into TypeScript with `lang="ts"`.
      let attributes = element.descendantsOfType('attribute');
      for (let attribute of attributes) {
        if (attribute?.firstNamedChild?.text === 'lang') {
          let value = attribute?.lastNamedChild?.firstNamedChild?.text ?? '';
          if (value === 'ts') return 'typescript';
        }
      }
      return 'javascript';
    },

    scopeName: 'source.js',

    content(element) {
      return element.descendantsOfType('raw_text');
    }
  });

  const EXPR_TYPES = [
    'expression',
    'html_expr',
    'const_expr',
    'each_start_expr',
    'if_start_expr',
    'each_start_expr',
    'expr_attribute_value'
  ];

  for (let nodeType of EXPR_TYPES) {
    atom.grammars.addInjectionPoint('source.svelte', {
      type: nodeType,
      language(element) {
        return 'javascript';
      },
      content (element) {
        let results = element.descendantsOfType(['raw_text_expr', 'raw_text_each']);
        return results;
      }
    });
  }

  // atom.grammars.addInjectionPoint('source.svelte', {
  //   type: 'expression',
  //   language(element) {
  //     return 'javascript';
  //   },
  //   content (element) {
  //     let results = element.descendantsOfType('raw_text_expr');
  //     return results;
  //   }
  // });
  //
  // atom.grammars.addInjectionPoint('source.svelte', {
  //   type: 'html_expr',
  //   language(element) {
  //     return 'javascript';
  //   },
  //   content (element) {
  //     let results = element.descendantsOfType('raw_text_expr');
  //     return results;
  //   }
  // });

};
