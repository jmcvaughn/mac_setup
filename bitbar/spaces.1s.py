#!/usr/local/bin/python3

import json
import subprocess

def main():
    yabai_query = subprocess.run(
        ['/usr/local/bin/yabai', '-m', 'query', '--spaces'],
        capture_output=True
    )

    spaces = json.loads(yabai_query.stdout)

    output = []
    for space in spaces:
        if space['visible'] == 1:
            output.extend(str(space['index']))

    print(', '.join(output))

if __name__ == '__main__':
    main()

