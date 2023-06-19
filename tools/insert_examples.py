#!/bin/env python3


from pathlib import Path

import re

regex_code = r"```(?P<lang>[a-z]+)?(?: (?P<tagline>[^\n]+))?(?:\n.*?)*```"
regex_tag = r"(?P<key>[a-z]+)=\"(?P<value>[^\"]+)\""


def strip_path(path):
    return path.removeprefix('external/')


def replace_match(match):
    tagline = match.group('tagline')
    language = match.group('lang')

    tags = {}
    for tag in re.finditer(regex_tag, tagline or ''):
        tags[tag.group('key')] = tag.group('value')

    if 'url' not in tags:
        # print(f'  Igoring empty non-url code block')
        return match.group(0)

    if language is None:
        language = ''

    url = tags['url']

    try:
        with open(url) as f:
            new_contents = f.read()
    except FileNotFoundError:
        print(f'  Failed to find file: {url}')
        return match.group(0)

    if 'title' not in tags:
        tags['title'] = strip_path(url)

    new_tagline = ' ' + ' '.join([f'{k}="{v}"' for k, v in tags.items()])

    return f'```{language}{new_tagline}\n{new_contents}```'


def process_file(f):
    contents = f.read()

    new_contents = re.sub(regex_code, replace_match, contents, re.MULTILINE)

    f.seek(0)
    f.write(new_contents)
    f.truncate()


def main():
    for path in Path('docs').rglob('*.md'):
        # print(f'Processing: {path}')

        with open(path, 'r+', encoding='utf-8', newline='\n') as f:
            process_file(f)


if __name__ == '__main__':
    main()
