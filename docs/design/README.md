Design Requirements and Guide
=============================

Sphinx is needed to compile the documentation, with the following extensions:

- sphinx.ext.autodoc
- sphinx.ext.autosummary
- sphinx.ext.doctest
- sphinx.ext.todo
- sphinx.ext.mathjax
- sphinxcontrib.bibtex
- numpydoc

To compile documentation into pdf (latex must be installed):

```
$ make latex
```

To compile documentation into html:

```
$ make html
```

Then, check the subdirectory that is created ``/build``.
