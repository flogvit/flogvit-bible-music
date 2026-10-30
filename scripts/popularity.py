#!/usr/bin/env python3
"""How many people opened each page of bible.flogvit.com, from the site's Caddy access log (JSON lines) on stdin.

    <the access log, rotated files unpacked> | python3 popularity.py > catalog/popularity.tsv

Run it where the log is: only `visitors<TAB>path` leaves, never an address. Counted are page loads (GET, 200, a
document) by people: no User-Agent of a bot or a script, and no address in the cloud ranges a bot fleet once came
from. scripts/catalog-write.ts writes the most visited pages' songs first.
"""
import collections, json, re, sys

BOT = re.compile(r'bot|crawl|spider|slurp|mediapartners|bingpreview|yandex|baidu|gptbot|ccbot|claude|anthropic|'
                 r'perplexity|bytespider|facebookexternalhit|facebot|ia_archiver|semrush|ahrefs|mj12|petalbot|applebot|'
                 r'amazonbot|pingdom|uptimerobot|monitor|headless|phantomjs|scrapy|python-|go-http-client|okhttp|libwww|'
                 r'httpclient|curl/|wget/|appengine-google|virustotal|urlscan|securitytrails|censys|shodan', re.I)
FLEET = ('47.79.', '47.82.')
# Pages of the site that are not about one passage, person, story or theme.
SITE_PAGES = re.compile(r'^/[a-z]{2}/(bidra|manuskripter|mcp)(/|$)')

visitors = collections.defaultdict(set)
for line in sys.stdin:
    try:
        r = json.loads(line)
    except ValueError:
        continue
    q = r.get('request', {})
    if not q.get('host', '').startswith('bible.') or q.get('method') != 'GET' or r.get('status') != 200:
        continue
    h = q.get('headers', {})
    ua, ip = (h.get('User-Agent') or [''])[0], q.get('client_ip', '')
    if not ua or BOT.search(ua) or ip.startswith(FLEET) or (h.get('Sec-Fetch-Dest') or ['document'])[0] != 'document':
        continue
    path = q.get('uri', '').split('?')[0]
    if re.match(r'^/[a-z]{2}/.', path) and not SITE_PAGES.match(path):
        visitors[path].add(ip)
for path, ips in sorted(visitors.items(), key=lambda x: (-len(x[1]), x[0])):
    print(f'{len(ips)}\t{path}')
