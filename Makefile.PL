use inc::Module::Install;
name 'Plack-App-Xslate';
all_from 'lib/Plack/App/Xslate.pm';

# requires '';


readme_markdown_from 'lib/Plack/App/Xslate.pm';
tests 't/*.t t/*/*.t t/*/*/*.t t/*/*/*/*.t';
test_requires 'Test::More';
test_requires 'YAML';
author_tests('xt');
# use_test_base;
auto_include;
WriteAll;
