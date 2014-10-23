import json

f = open('userdata.json', 'r')
data = f.read()
f.close()

data = data.split("\n")
arr = []

for t in data:
	try:
		_t = json.loads(t)
	except Exception, e:
		pass
	
	if(_t[0]["label"] == "No results found"):
		print "true"
	else:
		for a in _t:
			if a not in arr:
				print "Im looking for :"
				print a
				arr.append(a)

f = open('modify.json', 'w')
f.write(json.dumps(arr))
# print arr
