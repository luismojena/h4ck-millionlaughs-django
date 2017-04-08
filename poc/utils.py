import xml.etree.ElementTree as ET

def handle_upload(f):
	content_xml = f.read()
	tree = ET.fromstring(content_xml)
	ntree = ET.ElementTree(tree)
	ntree.write('este.xml')


def generate_naive_xml():
	pass

def generate_malicious_xml_v1():
	pass

def generate_malicious_xml_v2():
	pass

def generate_malicious_xml_v3():
	pass
