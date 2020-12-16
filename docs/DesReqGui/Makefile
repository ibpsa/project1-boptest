# Makefile for Sphinx documentation
#

# You can set these variables from the command line.
SPHINXOPTS    =
SPHINXBUILD   = sphinx-build
PAPER         = letter
BUILDDIR      = build

#PYTHONPATH=`pwd`/..

# Internal variables.
PAPEROPT_a4     = -D latex_paper_size=a4
PAPEROPT_letter = -D latex_paper_size=letter
ALLSPHINXOPTS   = -d $(BUILDDIR)/doctrees $(PAPEROPT_$(PAPER)) $(SPHINXOPTS) source

.PHONY: help clean html dirhtml pickle json htmlhelp qthelp latex changes linkcheck doctest release-html copypdftodoc

help:
	@echo "Please use \`make <target>' where <target> is one of"
	@echo "  html      to make standalone HTML files"
	@echo "  dirhtml   to make HTML files named index.html in directories"
	@echo "  pickle    to make pickle files"
	@echo "  json      to make JSON files"
	@echo "  htmlhelp  to make HTML files and a HTML help project"
	@echo "  qthelp    to make HTML files and a qthelp project"
	@echo "  latex     to make LaTeX files, you can set PAPER=a4 or PAPER=letter"
	@echo "  changes   to make an overview of all changed/added/deprecated items"
	@echo "  linkcheck to check all external links for integrity"
	@echo "  doctest   to run all doctests embedded in the documentation (if enabled)"
	@echo "  release-html  to copy HTML files to www folder for online publication"
	@echo "  copypdftodoc  to copy PDF file to userGuide folder for distribution"

clean:
	-rm -rf $(BUILDDIR)/*

cleanpdf:
	-rm -rf *.pdf

html:
	$(SPHINXBUILD) -b html $(ALLSPHINXOPTS) $(BUILDDIR)/html
	@echo
	@echo "Build finished. The HTML pages are in $(BUILDDIR)/html."

dirhtml:
	$(SPHINXBUILD) -b dirhtml $(ALLSPHINXOPTS) $(BUILDDIR)/dirhtml
	@echo
	@echo "Build finished. The HTML pages are in $(BUILDDIR)/dirhtml."

pickle:
	$(SPHINXBUILD) -b pickle $(ALLSPHINXOPTS) $(BUILDDIR)/pickle
	@echo
	@echo "Build finished; now you can process the pickle files."

json:
	$(SPHINXBUILD) -b json $(ALLSPHINXOPTS) $(BUILDDIR)/json
	@echo
	@echo "Build finished; now you can process the JSON files."

htmlhelp:
	$(SPHINXBUILD) -b htmlhelp $(ALLSPHINXOPTS) $(BUILDDIR)/htmlhelp
	@echo
	@echo "Build finished; now you can run HTML Help Workshop with the" \
	      ".hhp project file in $(BUILDDIR)/htmlhelp."

qthelp:
	$(SPHINXBUILD) -b qthelp $(ALLSPHINXOPTS) $(BUILDDIR)/qthelp
	@echo
	@echo "Build finished; now you can run "qcollectiongenerator" with the" \
	      ".qhcp project file in $(BUILDDIR)/qthelp, like this:"

latex:
	$(SPHINXBUILD) -b latex $(ALLSPHINXOPTS) $(BUILDDIR)/latex
	(cd build/latex; make all-pdf)
	@echo
#	@echo "Build finished; the LaTeX files are in $(BUILDDIR)/latex."
#	@echo "Run \`make all-pdf' or \`make all-ps' in that directory to" \
	      "run these through (pdf)latex."

changes:
	$(SPHINXBUILD) -b changes $(ALLSPHINXOPTS) $(BUILDDIR)/changes
	@echo
	@echo "The overview file is in $(BUILDDIR)/changes."

linkcheck:
	$(SPHINXBUILD) -b linkcheck $(ALLSPHINXOPTS) $(BUILDDIR)/linkcheck
	@echo
	@echo "Link check complete; look for any errors in the above output " \
	      "or in $(BUILDDIR)/linkcheck/output.txt."

doctest:
	$(SPHINXBUILD) -b doctest $(ALLSPHINXOPTS) $(BUILDDIR)/doctest
	@echo "Testing of doctests in the sources finished, look at the " \
	      "results in $(BUILDDIR)/doctest/output.txt."

release-html:
	#-mkdir release
	#-mkdir release/userGuide
	@echo "Copy html files to the www folder."
	-cp -R $(BUILDDIR)/html/*.* www/userGuide
	-cp -R $(BUILDDIR)/html/_images www/userGuide
	-cp -R $(BUILDDIR)/html/legal.html ../../

dist:   clean cleanpdf latex html release-html copypdftodoc copydoctowww

copypdftodoc:
	@echo "Copy pdf files to the userGuide folder."
	-cp -R $(BUILDDIR)/latex/*.pdf .

copydoctowww:
	@echo "Sent files to the server excluding .svn."
	@echo "Set permissions to ensure files can be written on gundog."
	ssh thierry@gundog.lbl.gov "sudo chmod -R g+w /usr/local/www/simulationresearch/fmu/EnergyPlus/export/"
	rsync -av --exclude '*.svn' www/* thierry@gundog.lbl.gov:/usr/local/www/simulationresearch/fmu/EnergyPlus/export/
	#scp -r release/* thierry@gundog.lbl.gov:/usr/local/www/simulationresearch/fmu/EnergyPlus/export/
