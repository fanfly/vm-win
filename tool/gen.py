s = 'powershell -noprofile -inputformat none -executionpolicy bypass -command iex "((New-Object System.Net.WebClient).DownloadString(\'https://chocolatey.org/install.ps1\'))"'
def name(c):
    if 65 <= ord(c) <= 90:
        return 'shift-{}'.format(chr(ord(c) + 32))
    d = {
        ' ': 'spc',
        '\n': 'ret',
        '-': 'minus',
        '\'': 'apostrophe',
        '"': 'shift-apostrophe',
        '.': 'dot',
        '/': 'slash',
        '(': 'shift-9',
        ')': 'shift-0',
        ';': 'semicolon',
        ':': 'shift-semicolon',
    }
    return d[c] if c in d else c

for c in s:
    print('send "sendkey {}\\r"'.format(name(c)))
