import subprocess
import logging
import toml
import sys
from os import path


def main():
    try:
        # change version
        if len(sys.argv) == 2:
            option = sys.argv[1]
            ret = subprocess.run(["poetry", "version", option])
            logging.info("poetry version " + option)
            logging.info(ret.stdout)
        elif len(sys.argv) > 2:
            raise Exception('wrong argument ' + sys.argv)

        # get version
        project = toml.load(
            path.join(path.dirname(path.abspath(__file__)),
                      path.pardir,
                      'pyproject.toml'))
        version = project['tool']['poetry']['version']

        # generate tag
        ret = subprocess.run(["git", "tag", version])

        logging.info("git tag " + version)
        logging.info(ret.stdout)
    except subprocess.TimeoutExpired as e:
        logging.error(ret.stderr)
        logging.error(f'timeout = {e.timeout}')
    except subprocess.CalledProcessError as e:
        logging.error(ret.stderr)
        logging.error(f'returncode = {e.returncode}')
        logging.error(f'output = {e.output}')
    except Exception as e:
        logging.error(e)
