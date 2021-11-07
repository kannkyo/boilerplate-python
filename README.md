# boilerplate-python

Python プロジェクト用のボイラープレート

[![ci](https://github.com/kannkyo/boilerplate-python/actions/workflows/python-ci.yml/badge.svg)](https://github.com/kannkyo/boilerplate-python/actions/workflows/python-ci.yml)
[![publish](https://github.com/kannkyo/boilerplate-python/actions/workflows/python-publish.yml/badge.svg)](https://github.com/kannkyo/boilerplate-python/actions/workflows/python-publish.yml)
[![CodeQL](https://github.com/kannkyo/boilerplate-python/actions/workflows/codeql-analysis.yml/badge.svg)](https://github.com/kannkyo/boilerplate-python/actions/workflows/codeql-analysis.yml)

```bash
in-toto-mock --name vcs-1 -- git clone <repo>
in-toto-mock --name building-1 -- poetry build
in-toto-mock --name qa-1 -- poetry run flake8 . --count --select=E9,F63,F7,F82 --show-source --statistics
in-toto-mock --name qa-2 -- poetry run flake8 . --count --exit-zero --max-complexity=10 --max-line-length=127 --statistics
in-toto-mock --name test-1 -- poetry run pytest --junitxml=junit/test-results.xml --cov=src --cov-report=xml --cov-report=html
tar czf in_toto_link_files.tar.gz vcs-1.link building-1.link qa-1.link qa-2.link test-1.link 
```

```bash
poetry run in-toto-keygen kannkyo
poetry run in-toto-sign --key kannkyo --file kannkyo boilerplate-python.layout

poetry run in-toto-run --key kannkyo --materials . --products . --step-name vcs-1 -- git clone https://github.com/kannkyo/boilerplate-python
poetry run in-toto-run --key kannkyo --materials . --products . --step-name building-1 -- poetry build
poetry run in-toto-run --key kannkyo --materials . --products . --step-name qa-1 -- poetry run flake8 . --count --select=E9,F63,F7,F82 --show-source --statistics
poetry run in-toto-run --key kannkyo --materials . --products . --step-name qa-2 -- poetry run flake8 . --count --exit-zero --max-complexity=10 --max-line-length=127 --statistics
poetry run in-toto-run --key kannkyo --materials . --products . --step-name test-1 -- poetry run pytest --junitxml=junit/test-results.xml --cov=src --cov-report=xml --cov-report=html
```
