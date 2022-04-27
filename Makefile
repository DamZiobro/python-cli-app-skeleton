CODE_DIRS=cli_command
TEST_DIRS=tests
POETRY_COMMAND=cli-command

requirements:
	pip install poetry
	poetry install
	touch $@

format: requirements
	poetry run isort $(CODE_DIRS) $(TEST_DIRS)
	poetry run black $(CODE_DIRS) $(TEST_DIRS)

lint: requirements
	poetry run flake8 $(CODE_DIRS) $(TEST_DIRS)
	poetry run isort --check-only $(CODE_DIRS) $(TEST_DIRS)
	poetry run black --check $(CODE_DIRS) $(TEST_DIRS)

unit-tests: requirements
	poetry run pytest -s -vv $(TEST_FILE)
	
cov: requirements
	poetry run pytest -s -vv --cov=$(CODE_DIRS) $(TEST_FILE)

cov-html: requirements
	poetry run coverage html

run: requirements
	poetry run $(POETRY_COMMAND) $(OPTIONS)

install: requirements
	pip install .