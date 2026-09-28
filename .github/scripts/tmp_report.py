import json, sys

d, path = sys.argv[1], sys.argv[2]
raw = open(path, encoding='utf-8', errors='replace').read()


def esc(s):
    return s.replace('%', '%25').replace('\r', '').replace('\n', '%0A')


names, fails, text = {}, [], []
for line in raw.splitlines(True):
    if line.startswith('{'):
        try:
            e = json.loads(line)
        except Exception:
            text.append(line)
            continue
        t = e.get('type')
        if t == 'testStart':
            names[e['test']['id']] = e['test']['name']
        elif t == 'print':
            text.append(e.get('message', '') + '\n')
        elif t == 'error':
            text.append('ERROR ' + names.get(e.get('testID'), '?') + ': ' + e['error'] + '\n' + e.get('stackTrace', '')[:1500] + '\n')
        elif t == 'testDone' and e.get('result') != 'success' and not e.get('hidden'):
            fails.append(names.get(e['testID'], '?'))
        continue
    text.append(line)

print(f"::notice title={d}::tests={len(names)} failures={len(fails)}")
if fails:
    print(f"::error title={d} failed::{esc(chr(10).join(fails))}")
    blob = ''.join(text)
    marks = [k for k in range(len(blob)) if blob.startswith('══╡', k)]
    starts = marks[:6] or [max(0, len(blob) - 5000)]
    for k in starts:
        print(f"::warning title={d} log::{esc(blob[k:k + 6000])}")
