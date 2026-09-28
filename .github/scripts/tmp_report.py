import json, sys

d, path = sys.argv[1], sys.argv[2]
names, logs, fails = {}, {}, []
for line in open(path, encoding='utf-8', errors='replace'):
    line = line.strip()
    if not line.startswith('{'):
        continue
    try:
        e = json.loads(line)
    except Exception:
        continue
    t = e.get('type')
    if t == 'testStart':
        names[e['test']['id']] = e['test']['name']
    elif t == 'error':
        logs.setdefault(e['testID'], []).append('ERR ' + e['error'][:1200])
    elif t == 'print':
        logs.setdefault(e['testID'], []).append(e['message'][:1800])
    elif t == 'testDone' and e.get('result') != 'success' and not e.get('hidden'):
        fails.append(e['testID'])


def esc(s):
    return s.replace('%', '%25').replace('\r', '').replace('\n', '%0A')


for i in fails[:10]:
    msg = names.get(i, '?') + '\n' + '\n'.join(logs.get(i, []))
    print(f"::error title={d}::{esc(msg[:6000])}")
real = [n for n in names.values() if not n.startswith('loading')]
print(f"::notice title={d}::tests={len(real)} failures={len(fails)}")
if not real or any(names.get(i, '').startswith('loading') for i in fails):
    txt = open(path, encoding='utf-8', errors='replace').read()
    print(f"::error title={d} load::{esc(txt[-5000:])}")
