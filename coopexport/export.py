from lxml import etree
from datetime import datetime
import locale
import re

def processTime(time):
	lc = locale.setlocale(locale.LC_TIME)
	try:
		locale.setlocale(locale.LC_TIME, "sv_SE")
		date = datetime.strptime(time, "%d %B %Y")
		return date.strftime("%m/%d/%Y")
	finally:
		locale.setlocale(locale.LC_TIME, lc)

def processDesc(desc):
	title = desc.find("span")
	if title is not None:
		return etree.tostring(title, method="text", encoding="unicode")
	else:
		return etree.tostring(desc, method="text", encoding="unicode")
def processSum(sum):
	m = re.search("(\-?[0-9]*,?[0-9]+)", etree.tostring(sum, method="text", encoding="unicode"))
	return m.group(0).replace(',', '.')

def main():
	with open("export_coop.txt", "r") as input:
	    data = input.read()

	tree = etree.HTML(data)
	trs = tree.xpath("//tr")

	currentTime = "Unknown"
	for tr in trs:
		time = tr.find(".//time")
		if time is not None:
			currentTime = time.text
		tds = tr.findall("td")
		print ('{};{};{}'.format(
			processTime(currentTime),
			processDesc(tds[0]),
			processSum(tds[1])
			))

main()
