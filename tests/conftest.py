import subprocess
from pathlib import Path

import pytest


# module-level context set by the autouse config_file_tests fixture
config_file_path: Path = None

@pytest.fixture(scope="module", autouse=True)
def config_file_tests(tmp_path_factory):
    """Provide a temporary configuration file (auto-used in all tests)."""
    global config_file_path
    config_file_path = tmp_path_factory.mktemp("arlas_cli") / "arlas_cli.yaml"

    yield config_file_path

# Helper function to run CLI commands
def run_cli_command(args, input_data=None):
    cmd = ["python3.10", "-m", "arlas.cli.cli", "--config-file", str(config_file_path)] + args
    result = subprocess.run(
        cmd,
        capture_output=True,
        text=True,
        input=input_data
    )
    return result
