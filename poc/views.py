from django.shortcuts import render
from .utils import handle_upload
from django.http import HttpResponseRedirect, HttpResponse
from .forms import UploadXMLForm

# Create your views here.
def index (req):
	if req.method == 'POST':
		form = UploadXMLForm(req.POST, req.FILES)
		if form.is_valid():
			handle_upload(req.FILES['file'])
			return HttpResponseRedirect('/showcontent/')
	else:
		form = UploadXMLForm()
	return render(req, 'index.html', {'form':form})

def showcontent(req):
	f = open('este.xml','r')
	data = f.read()
	print(data)
	return render(req, 'display.html', {'data':data})
