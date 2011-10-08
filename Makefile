clean:
	@find . -name "*.pyc" -exec rm -rf {} \;

doc_dependencies: sphinx

dependencies: unittest2 argparse coverage selenium flask lxml zopetestbrowser

doc: doc_dependencies
	@cd docs && make clean && make html

argparse:
	@python -c 'import argparse' 2>/dev/null || pip install argparse

coverage:
	@python -c 'import coverage' 2>/dev/null || pip install coverage==3.5.1

selenium:
	@python -c 'import selenium' 2>/dev/null || pip install selenium==2.8.1

unittest2:
	@python -c 'from unittest import skip' 2>/dev/null || pip install unittest2

flask:
	@python -c 'import flask' 2>/dev/null || pip install flask==0.7.2

lxml:
	@python -c 'import lxml' 2>/dev/null || pip install lxml==2.3.1

sphinx:
	@python -c 'import sphinx' 2>/dev/null || pip install sphinx==1.0.8

zopetestbrowser:
	@python -c 'import zope.testbrowser' 2>/dev/null || pip install zope.testbrowser==4.0.2

which = 'tests'

test: dependencies clean
	@echo "Running all tests..."
	@coverage run run_tests.py -w $(which)
	@coverage report
	@echo
	@rm -f delete_me*

wintest: dependencies
	@echo "Running tests on windows platform..."
	@python run_tests.py -w tests/test_browser,tests/test_element_list,tests/test_meta,tests/test_request_handler,tests/test_webdriver_ie,tests/test_zopetestbrowser
	@echo
	@rm -f delete_me*
