from lxml import etree
import os

xmlfile = "ETL0.txt"
xmlfilepath = os.path.join("../docs", xmlfile)
if not os.path.isfile(xmlfilepath):
    assert False
xml = open(xmlfilepath, "rw")
xmlstring = xml.read()
tree = etree.XML(xmlstring)
find0 = etree.XPath("//database")
ele = find0(tree)[0]
for k in ele.keys():
    print "%s:%s" %(k, ele.get(k))

find1 = etree.XPath("//order")
ele = find1(tree)[0]
for k in ele.keys():
    print "%s:%s" %(k, ele.get(k))

find2 = etree.XPath("//order/id/column")
ele = find2(tree)[0]
print "column0:%s" % ele.get("name")

find3 = etree.XPath("//order/mapping")
ele = find3(tree)[0]
for k in ele.keys():
    print "%s:%s" %(k, ele.get(k))

ele_child = ele.getchildren()[0]
print "column type: %s" % ele_child[0].tag
for k in ele_child.keys():
    print "%s:%s" %(k, ele_child.get(k))

ele_children = ele_child.getchildren()
for e in ele_children:
    for k in e.keys():
        print "%s:%s" %(k, e.get(k))

ele_children1 = ele_children[0].getchildren()
for e in ele_children1:
    for k in e.keys():
        print "%s:%s" %(k, e.get(k))
