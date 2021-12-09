from urllib.request import urlopen
from urllib.parse import  urljoin
from urllib.parse import urlparse
import re
import sys

def site_exists(url):
    try:
        status_code = urlopen(url).getcode()
        return status_code < 400
    except:
        return False

def collect_urls (url, parent_url):
    html = urlopen(url).read().decode('utf-8')
    links = re.findall(r'href="(.*?)"', html)

    for i, element in enumerate(links):
        links[i] = urljoin(url,links[i])

    if parent_url in links: links.remove(parent_url)

    return links


in_file = open(sys.argv[1], 'r')
out_file = open(sys.argv[2], 'w')
 
lines = in_file.readlines()
 
for line in lines:
    line = line.strip()
    pattern = re.compile("GSE[0-9]+")
    if pattern.match(line):
        #add dir name
        out_file.write("{}\n".format(line.strip()))

        #build base url
        parent_url = "https://ftp.ncbi.nlm.nih.gov/geo/series/" + line[0:-3] + "nnn"+ "/" +line + "/"
        base_url = parent_url + "suppl/"

        if not site_exists(base_url):
            out_file.write("***webpage with GSE id {} does not exist, please check the provided GSE id again.\n".format(line))
        else:
            urls = collect_urls(base_url, parent_url)
            for element in urls:
                out_file.write(element + "\n")

in_file.close()
out_file.close()